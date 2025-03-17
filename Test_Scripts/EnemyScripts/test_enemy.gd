class_name test_enemy extends CharacterBody3D

var health:int
@export var speed:float
@export var fall_acceleration:int
var maxFallSpeed:int = 10
var windResistance:int = 1

@onready var player:CharacterBody3D = $"/root/Level/Player"

var invincible:bool = false
var movementEnabled:bool = true
var inTornado:bool = false
var target_velocity:Vector3 = Vector3.ZERO
var wind_velocity:Vector3 = Vector3.ZERO
var isImpaired:int = 0 #0 = Good, 1 = Frozen, 2 = Petrified, 3 = On Fire
var isOnFire:bool = false
var freezeLimit:int = 3
var coldStacks:int = 0
var earthStacks:int = 0
var petrifyLimit:int = 3
var AIenabled:bool = false
@onready var navAgent:NavigationAgent3D = $NavigationAgent3D

func enableAI(enable:bool) -> void:
	AIenabled = enable
	($CollisionShape3D as CollisionShape3D).disabled = false

func spawn() -> void:
	($SpawningSprite as Node3D).visible = true
	($SpawningSprite as AnimatedSprite3D).play()
	set_visible(true)
	ChildSpawnParameters()

func spawnDummy() -> void:
	set_visible(true)
	startAnim()
	enableAI(true)
	ChildSpawnParameters()

func ChildSpawnParameters() -> void:
	pass

func actor_setup() -> void:
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(player.global_position)

func set_movement_target(movement_target: Vector3) -> void:
	navAgent.set_target_position(movement_target)

func _physics_process(_delta:float) -> void:
	self.look_at(Vector3(player.global_position.x, self.global_position.y, player.global_position.z))
	if !AIenabled or isImpaired:
		return
	target_velocity = horizontalMovement()
	target_velocity.y = MovementScript.enemyFallOptions(target_velocity, inTornado, self.is_on_floor(), fall_acceleration, _delta, maxFallSpeed)
	manageCast(_delta)
	
	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navAgent.get_next_path_position()
	set_movement_target(player.global_position)
	
	#velocity = current_agent_position.direction_to(next_path_position)*(target_velocity + wind_velocity)
	if inTornado:
		velocity = Vector3.ZERO
	else:
		velocity = current_agent_position.direction_to(next_path_position)*(speed)
	velocity = velocity + wind_velocity/windResistance
	velocity.y = MovementScript.enemyFallOptions(target_velocity, inTornado, self.is_on_floor(), fall_acceleration, _delta, maxFallSpeed)
	move_and_slide()

func manageCast(_delta:float) -> void:
	pass

func horizontalMovement() -> Vector3:
	return Vector3(0, target_velocity.y, 0)

func rangeTo(target:CharacterBody3D) -> float:
	var catheteX:float = pow(target.position.x - self.position.x, 2)
	var catheteY:float = pow(target.position.y - self.position.y, 2)
	var catheteZ:float = pow(target.position.z - self.position.z, 2)
	var distance:float = sqrt(catheteX+catheteY+catheteZ)
	return distance

func inEarthquakeSwitch(switch:bool) -> void:
	pass

func inTornadoSwitch(switch:bool) -> void:
	movementEnabled = !switch
	inTornado = switch

func isInWind(switch:bool, wind_dir:Vector3 = Vector3.ZERO) -> void:
	if switch:
		wind_velocity = wind_dir
	else:
		wind_velocity = Vector3.ZERO

func isDamaged(damage:int, dmgType:int, strength:int = 1, dmgDir:Vector3 = Vector3.ZERO) -> void:
	if !invincible:
		health -= damage
		if health <= 0:
			FlagDeath()
			queue_free()
		if damage > 0:
			showDamage()
		if dmgType == 2:
			if isImpaired == 2:
				explode(2, dmgDir, strength)
		if dmgType == 3 and isImpaired == 0: #dmgType: 2 = punch, 3 = earthquake, 4 = ice, 5 = fire, 6 = trueFire
			earthStacks += strength
			speed = 3.0/(earthStacks+1)
			if earthStacks >= petrifyLimit/3:
				showStatusEffect(0,1)
			if earthStacks >= 2*petrifyLimit/3:
				showStatusEffect(0,2)
			if earthStacks >= petrifyLimit:
				isImpaired = 2
				setOnFire(false)
				showStatusEffect(0,3)
			updateDisplay()
		if dmgType == 4:
			if isOnFire:
				setOnFire(false)
				var explosion:PackedScene = load("res://Test_Objects/test_ice_explosion.tscn")
				var e1:Area3D = explosion.instantiate()
				e1.rotation = self.rotation
				(e1 as test_ice_explosion).strength = strength
				(e1 as test_ice_explosion).size = 1+strength
				get_tree().current_scene.get_parent().add_child(e1)
				e1.global_position = self.global_position
				print(e1.name)
			elif isImpaired == 0:
				coldStacks += strength
				if coldStacks >= freezeLimit/3:
					showStatusEffect(1,1)
				if coldStacks >= 2*freezeLimit/3:
					showStatusEffect(1,2)
				if coldStacks >= freezeLimit:
					isImpaired = 1
					setOnFire(false)
					showStatusEffect(1,3)
			updateDisplay()
		if dmgType == 6:
			if isImpaired == 0 and !isOnFire:
				setOnFire(true)
			elif isImpaired == 1:
				explode(1)
			elif isImpaired == 2:
				explode(3)
		if dmgType == 5:
			if isImpaired == 1:
				explode(1)
			elif isImpaired == 2:
				explode(3)

func setOnFire(status:bool) -> void:
	if status:
		isOnFire = true
		($FireDurationTimer as Timer).start()
		(get_node("OnFireSprite") as Node3D).visible = true
		(get_node("OnFireSprite") as AnimatedSprite3D).play()
		if ($FireDoTTimer as Timer).is_stopped():
			(get_node("FireDoTTimer") as Timer).start()
	else:
		isOnFire = false
		(get_node("OnFireSprite") as Node3D).visible = false
		(get_node("OnFireSprite") as AnimatedSprite3D).stop()
		(get_node("FireDoTTimer") as Timer).stop()

func explode(explosionType:int, direction:Vector3 = Vector3.ZERO, throwStrength:float = 0) -> void:
	#1 = Frozen, 2 = Petrified Punched, 3 = Melted
	FlagDeath()
	if explosionType == 1:
		var explosion:PackedScene = load("res://Test_Objects/test_ice_explosion.tscn")
		var e1:Area3D = explosion.instantiate()
		e1.rotation = self.rotation
		get_tree().current_scene.get_parent().add_child(e1)
		e1.global_position = self.global_position
		queue_free()
	elif explosionType == 2:
		var ROCK:PackedScene = load("res://Test_Objects/test_earthbox.tscn")
		var r1:Area3D = ROCK.instantiate() #Base center rock
		r1.position = Vector3(self.position.x, self.position.y, 
								self.position.z)
		r1.rotation.y = direction.y
		(r1 as test_earthbox).sAdd = throwStrength
		get_tree().current_scene.add_child(r1)
		queue_free()
	elif explosionType == 3:
		showMelting(false)
		set_physics_process(false)
		invincible = true
		var LAVA:PackedScene = load("res://Test_Objects/test_lava.tscn")
		var l:Area3D = LAVA.instantiate()
		l.position = Vector3(self.position.x, self.position.y - (($MeshInstance3D as MeshInstance3D).mesh as CapsuleMesh).height/2, 
								self.position.z)
		get_tree().current_scene.add_child(l)
		($MeltControl as Timer).start()

func FlagDeath() -> void:
	(get_node("/root/Level") as component_level).enemyKilled() 

func startAnim() -> void:
	pass

func updateDisplay() -> void:
	if coldStacks != 0:
		var toDisplay:String
		if coldStacks < freezeLimit:
			toDisplay = str("Cold ", coldStacks) 
		else:
			toDisplay = str("Frozen") 
		(get_node("Status Display") as Label3D).text = toDisplay
	if earthStacks != 0:
		var toDisplay:String
		if earthStacks < petrifyLimit:
			toDisplay = str("Earth ", earthStacks) 
		else:
			toDisplay = str("Petrified") 
		(get_node("Status Display") as Label3D).text = toDisplay

func showDamage() -> void:
	var tempTween:Tween = create_tween()
	tempTween.set_parallel(false)
	tempTween.tween_property($Sprite3D, "modulate", Color.RED, 0)
	tempTween.tween_property($Sprite3D, "modulate", Color.RED, 0.15)
	tempTween.tween_property($Sprite3D, "modulate", Color.WHITE, 0)

func showStatusEffect(type:int, strength:int) -> void:
	if type == 0:
		if strength == 1:
			(get_node("EffectSprite") as Sprite3D).texture = load("res://Test_Assets/Petrify1.png")
		elif strength == 2:
			(get_node("EffectSprite") as Sprite3D).texture = load("res://Test_Assets/Petrify2.png")
		elif strength == 3:
			(get_node("EffectSprite") as Sprite3D).texture = load("res://Test_Assets/Petrify3.png")
	elif type == 1:
		if strength == 1:
			(get_node("EffectSprite") as Sprite3D).texture = load("res://Test_Assets/Frozen1.png")
		elif strength == 2:
			(get_node("EffectSprite") as Sprite3D).texture = load("res://Test_Assets/Frozen2.png")
		elif strength == 3:
			(get_node("EffectSprite") as Sprite3D).texture = load("res://Test_Assets/Frozen3.png")

func _fire_dot_tick() -> void:
	isDamaged(5, 1)
	(get_node("FireDoTTimer") as Timer).start()

func _on_spawning_sprite_animation_finished() -> void:
	($SpawningSprite as AnimatedSprite3D).stop()
	($SpawningSprite as Node3D).visible = false
	enableAI(true)

func _on_spawning_sprite_frame_changed() -> void:
	if ($SpawningSprite as AnimatedSprite3D).frame == 2:
			($Sprite3D as Node3D).visible = true
			($"Status Display" as Node3D).visible = true
			startAnim()

func _on_is_damaged_timeout() -> void:
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", false)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", false)

func _on_fire_duration_timer_timeout() -> void:
	setOnFire(false)

func showMelting(flipped:bool) -> void:
	pass

func _on_melt_control_timeout() -> void:
	if ($Sprite/Body as Node3D).position.y <= 0:
		queue_free()
	($Sprite/Body as Node3D).position.y -= (($MeshInstance3D as MeshInstance3D).mesh as CapsuleMesh).height/4
	($Sprite/Arms as Node3D).position.y -= (($MeshInstance3D as MeshInstance3D).mesh as CapsuleMesh).height/3
	if ($Sprite as Node3D).get_child(1).name == "Head":
		($Sprite/Head as Node3D).position.y -= (($MeshInstance3D as MeshInstance3D).mesh as CapsuleMesh).height/3
	showMelting(true)
	($MeltControl as Timer).start()

func OBSOLETECODEDONOTUSE() -> void:
	pass
		#var icicle:PackedScene = load("res://test_projectile.tscn")
		#var i1:Area3D = icicle.instantiate()
		#i1.position = Vector3(self.position.x - 1*sin(get_rotation().y), 
		#						(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
		#							self.position.z - 1*cos(get_rotation().y))
		#i1.rotation.y = get_rotation().y
		#var i2:Area3D = icicle.instantiate() # 1 + 45 deg y
		#i2.position = Vector3(self.position.x - 1*sin(get_rotation().y + 0.785398), 
		#						(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
		#							self.position.z - 1*cos(get_rotation().y + 0.785398))
		#i2.rotation.y = get_rotation().y + 0.785398
		#var i3:Area3D = icicle.instantiate() #1 + 90 deg y
		#i3.position = Vector3(self.position.x - 1*sin(get_rotation().y + 1.5708), 
		#						(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
		#							self.position.z - 1*cos(get_rotation().y + 1.5708))
		#i3.rotation.y = get_rotation().y + 1.5708
		#var i4:Area3D = icicle.instantiate() #1 + 135 deg y
		#i4.position = Vector3(self.position.x - 1*sin(get_rotation().y + 2.35619), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
									#self.position.z - 1*cos(get_rotation().y + 2.35619))
		#i4.rotation.y = get_rotation().y + 2.35619
		#var i5:Area3D = icicle.instantiate() #1 + 180 deg y
		#i5.position = Vector3(self.position.x - 1*sin(get_rotation().y + 3.14159), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
									#self.position.z - 1*cos(get_rotation().y + 3.14159))
		#i5.rotation.y = get_rotation().y + 3.14159
		#var i6:Area3D = icicle.instantiate() #1 + 225 deg y
		#i6.position = Vector3(self.position.x - 1*sin(get_rotation().y + 3.92699), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
									#self.position.z - 1*cos(get_rotation().y + 3.92699))
		#i6.rotation.y = get_rotation().y + 3.92699
		#var i7:Area3D = icicle.instantiate() #1 + 270 deg y
		#i7.position = Vector3(self.position.x - 1*sin(get_rotation().y + 4.71239), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
									#self.position.z - 1*cos(get_rotation().y + 4.71239))
		#i7.rotation.y = get_rotation().y + 4.71239
		#var i8:Area3D = icicle.instantiate() #1 + 315
		#i8.position = Vector3(self.position.x - 1*sin(get_rotation().y + 5.49779), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2), 
									#self.position.z - 1*cos(get_rotation().y + 5.49779))
		#i8.rotation.y = get_rotation().y + 5.49779
		#var i9:Area3D = icicle.instantiate() #1 + 45 deg x
		#i9.position = Vector3(self.position.x - 1*sin(get_rotation().y ), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2) 
									#+ 1*sin(get_rotation().x + 0.785398), 
									#self.position.z - 1*cos(get_rotation().y))
		#i9.rotation.y = get_rotation().y
		#i9.rotation.x = get_rotation().x - 0.785398
		#var i10:Area3D = icicle.instantiate() #1 + 45 deg x + 90 deg y
		#i10.position = Vector3(self.position.x - 1*sin(get_rotation().y  + 1.5708), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2) 
									#+ 1*sin(get_rotation().x + 0.785398), 
									#self.position.z - 1*cos(get_rotation().y  + 1.5708))
		#i10.rotation.y = get_rotation().y  + 1.5708
		#i10.rotation.x = get_rotation().x - 0.785398
		#var i11:Area3D = icicle.instantiate() #1 + 45 deg x + 180 deg y
		#i11.position = Vector3(self.position.x - 1*sin(get_rotation().y  + 3.14159), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2) 
									#+ 1*sin(get_rotation().x + 0.785398), 
									#self.position.z - 1*cos(get_rotation().y  + 3.14159))
		#i11.rotation.y = get_rotation().y  + 3.14159
		#i11.rotation.x = get_rotation().x - 0.785398
		#var i12:Area3D = icicle.instantiate() #1 + 45 deg x + 270 deg y
		#i12.position = Vector3(self.position.x - 1*sin(get_rotation().y  + 4.71239), 
								#(self.position.y + ((get_node("MeshInstance3D") as MeshInstance3D).mesh as CylinderMesh).height/2) 
									#+ 1*sin(get_rotation().x + 0.785398), 
									#self.position.z - 1*cos(get_rotation().y  + 4.71239))
		#i12.rotation.y = get_rotation().y  + 4.71239
		#i12.rotation.x = get_rotation().x - 0.785398
		#get_tree().current_scene.get_parent().add_child(i1)
		#get_tree().current_scene.get_parent().add_child(i2)
		#get_tree().current_scene.get_parent().add_child(i3)
		#get_tree().current_scene.get_parent().add_child(i4)
		#get_tree().current_scene.get_parent().add_child(i5)
		#get_tree().current_scene.get_parent().add_child(i6)
		#get_tree().current_scene.get_parent().add_child(i7)
		#get_tree().current_scene.get_parent().add_child(i8)
		#get_tree().current_scene.get_parent().add_child(i9)
		#get_tree().current_scene.get_parent().add_child(i10)
		#get_tree().current_scene.get_parent().add_child(i11)
		#get_tree().current_scene.get_parent().add_child(i12)

