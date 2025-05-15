class_name test_chase_enemy extends test_enemy

@export var PUNCH:PackedScene = preload("res://Test_Objects/test_enemy_punch.tscn")
@export var PROJ:PackedScene = preload("res://Test_Objects/test_enemy_projectile.tscn")

var punchDelay:float = 2
var shoot_delay:float = 2

func _ready() -> void:
	health = 30
	speed = 5
	fall_acceleration = 14

func startAnim() -> void:
	($Sprite3D as Node3D).visible = false
	($Sprite as Node3D).visible = true
	for sprite in ($Sprite as Node).get_children():
		(sprite as AnimatedSprite3D).visible = true
		(sprite as AnimatedSprite3D).play()

func shoot(mode:int) -> void:
	if mode == 0:
		($Sprite/Arms as AnimatedSprite3D).play("Attacking") 
		movementEnabled = false
	elif mode == 1:
		($Sprite/Arms as AnimatedSprite3D).play("Shooting") 
		movementEnabled = false

func manageCast(_delta:float) -> void:
	punchDelay -= _delta
	shoot_delay -= _delta
	if rangeTo(player) < 1  and punchDelay <= 0:
		shoot(0)
		punchDelay = 2
	elif rangeTo(player) >= 2 and shoot_delay <= 0:
		shoot(1)
		shoot_delay = 2

func horizontalMovement() -> Vector3:
	if rangeTo(player) < 10 and movementEnabled and isImpaired == 0:
		#var direction:Vector3 = (Vector3(self.get_rotation().x,0,self.get_rotation().z)).normalized()
		#direction = -transform.basis.z
		#target_velocity.x = direction.normalized().x * speed
		#target_velocity.z = direction.normalized().z * speed
		speed = 5
		($Sprite/Body as AnimatedSprite3D).play("Walking")
	else:
		#target_velocity.x = 0
		#target_velocity.z = 0
		speed = 0
		($Sprite/Body as AnimatedSprite3D).play("Idle")
	return target_velocity

func showStatusEffect(type:int, strength:int) -> void:
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("active", true)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("active", true)
	if type == 0:
		if strength == 1:
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded1.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded1.png"))
		elif strength == 2:
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded2.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded2.png"))
		elif strength == 3:
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpandedFull.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpandedFull.png"))
	elif type == 1:
		if strength == 1:
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded1.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded1.png"))
		elif strength == 2:
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded2.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded2.png"))
		elif strength == 3:
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpandedFull.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpandedFull.png"))

func showMelting(flipped:bool) -> void:
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", false)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", false)
	if !flipped:
		(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/MeltExpanded.png"))
		(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/MeltExpanded.png"))
	else:
		(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/MeltExpandedFlipped.png"))
		(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/MeltExpandedFlipped.png"))
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("active", true)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("active", true)

func showDamage() -> void:
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	($isDamaged as Timer).start()
	#var tempTweenBody:Tween = create_tween()
	#tempTweenBody.set_parallel(false)
	#tempTweenBody.tween_property($Sprite/Body, "modulate", Color.RED, 0)
	#tempTweenBody.tween_property($Sprite/Body, "modulate", Color.RED, 0.15)
	#tempTweenBody.tween_property($Sprite/Body, "modulate", Color.WHITE, 0)
	#var tempTweenHead:Tween = create_tween()
	#tempTweenHead.set_parallel(false)
	#tempTweenHead.tween_property($Sprite/Head, "modulate", Color.RED, 0)
	#tempTweenHead.tween_property($Sprite/Head, "modulate", Color.RED, 0.15)
	#tempTweenHead.tween_property($Sprite/Head, "modulate", Color.WHITE, 0)
	#var tempTweenArms:Tween = create_tween()
	#tempTweenArms.set_parallel(false)
	#tempTweenArms.tween_property($Sprite/Arms, "modulate", Color.RED, 0)
	#tempTweenArms.tween_property($Sprite/Arms, "modulate", Color.RED, 0.15)
	#tempTweenArms.tween_property($Sprite/Arms, "modulate", Color.WHITE, 0)

func _on_arms_frame_changed() -> void:
	if ($Sprite/Arms as AnimatedSprite3D).animation == "Attacking" and ($Sprite/Arms as AnimatedSprite3D).frame == 1: 
		var punch:Area3D = PUNCH.instantiate()
		punch.position = Vector3(self.position.x - 1*sin(get_rotation().y), self.position.y, 
								self.position.z - 1*cos(get_rotation().y))
		punch.rotation = Vector3(0, get_rotation().y, 0)
		get_tree().current_scene.add_child(punch)
	if ($Sprite/Arms as AnimatedSprite3D).animation == "Shooting" and ($Sprite/Arms as AnimatedSprite3D).frame == 1: 
		var projectile:Area3D = PROJ.instantiate()
		projectile.position = Vector3(self.position.x - 3*sin(get_rotation().y), self.position.y, 
										self.position.z - 3*cos(get_rotation().y))
		projectile.rotation.y = get_rotation().y
		projectile.rotation.x = get_rotation().x - 1.5708
		(projectile as test_enemy_projectile).speed = 8
		get_tree().current_scene.add_child(projectile)
	if ($Sprite/Arms as AnimatedSprite3D).frame == 2:
		($Sprite/Arms as AnimatedSprite3D).play("Idle") 
		movementEnabled = !inTornado

func OBSOLETECODEDONOTUSE() -> void:
	pass
	#func _physics_process(_delta:float) -> void:
	#self.look_at(Vector3(player.global_position.x, self.global_position.y, player.global_position.z))
	#if AIenabled:
		#if isImpaired:
			#return
		#punchDelay -= _delta
		#shoot_delay -= _delta
		#if rangeTo(player) < 1  and punchDelay <= 0:
			#shoot(0)
			#punchDelay = 2
		#elif rangeTo(player) >= 2 and shoot_delay <= 0:
			#shoot(1)
			#shoot_delay = 2
		#target_velocity = horizontalMovement()
		##if rangeTo(player) < 10 and movementEnabled and isImpaired == 0:
			##var direction:Vector3 = (Vector3(self.get_rotation().x,0,self.get_rotation().z)).normalized()
			##direction = -transform.basis.z
			##target_velocity.x = direction.normalized().x * speed
			##target_velocity.z = direction.normalized().z * speed
			##($Sprite/Body as AnimatedSprite3D).play("Walking")
		##else:
			##target_velocity.x = 0
			##target_velocity.z = 0
			##($Sprite/Body as AnimatedSprite3D).play("Idle")
		#if inTornado:
			#target_velocity.y = 1 #Modifier par valeur de la tornade
		#elif is_on_floor():
			#target_velocity.y = 0
		#else: 
			#target_velocity.y = target_velocity.y - (fall_acceleration * _delta)
		#velocity = target_velocity + wind_velocity
		#move_and_slide()
