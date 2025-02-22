class_name test_throw_enemy extends test_enemy

@export var ROCK:PackedScene = preload("res://Test_Objects/test_enemy_boulder.tscn")

var throwDelay:float = 1

func _ready() -> void:
	health = 60
	speed = 1
	fall_acceleration = 14
	freezeLimit = 5
	petrifyLimit = 5

func startAnim() -> void:
	($Sprite3D as Node3D).visible = false
	($OmniLight3D as OmniLight3D).visible = true
	($Sprite as Node3D).visible = true
	for sprite in ($Sprite as Node).get_children():
		(sprite as AnimatedSprite3D).visible = true
		(sprite as AnimatedSprite3D).play()
	($ArmEffectSprite as AnimatedSprite3D).pause()

func shoot() -> void:
	($Sprite/Arms as AnimatedSprite3D).position.y = 1.33
	($Sprite/Arms as AnimatedSprite3D).play("Throw")
	var tempFrame:int = ($ArmEffectSprite as AnimatedSprite3D).frame
	($ArmEffectSprite as AnimatedSprite3D).position.y = 1.33
	($ArmEffectSprite as AnimatedSprite3D).play("Prepped")
	($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(tempFrame, 0)

func showDamage() -> void:
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	($isDamaged as Timer).start()
	#var tempTweenBody:Tween = create_tween()
	#tempTweenBody.set_parallel(false)
	#tempTweenBody.tween_property($Sprite/Body, "modulate", Color.RED, 0)
	#tempTweenBody.tween_property($Sprite/Body, "modulate", Color.RED, 0.15)
	#tempTweenBody.tween_property($Sprite/Body, "modulate", Color.WHITE, 0)
	var tempTweenHead:Tween = create_tween()
	tempTweenHead.set_parallel(false)
	tempTweenHead.tween_property($Sprite/Head, "modulate", Color.RED, 0)
	tempTweenHead.tween_property($Sprite/Head, "modulate", Color.RED, 0.15)
	tempTweenHead.tween_property($Sprite/Head, "modulate", Color.WHITE, 0)
	#var tempTweenArms:Tween = create_tween()
	#tempTweenArms.set_parallel(false)
	#tempTweenArms.tween_property($Sprite/Arms, "modulate", Color.RED, 0)
	#tempTweenArms.tween_property($Sprite/Arms, "modulate", Color.RED, 0.15)
	#tempTweenArms.tween_property($Sprite/Arms, "modulate", Color.WHITE, 0)

func showStatusEffect(type:int, strength:int) -> void:
	#($RealEffectSprite as AnimatedSprite3D).visible = true
	#($ArmEffectSprite as AnimatedSprite3D).visible = true
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("active", true)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("active", true)
	if type == 0:
		if strength == 1:
			($RealEffectSprite as AnimatedSprite3D).set_frame_and_progress(3, 0)
			($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(3, 0)
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded1.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded1.png"))
		elif strength == 2:
			($RealEffectSprite as AnimatedSprite3D).set_frame_and_progress(4, 0)
			($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(4, 0)
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded2.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpanded2.png"))
		elif strength == 3:
			($Sprite/Arms as AnimatedSprite3D).pause()
			($RealEffectSprite as AnimatedSprite3D).set_frame_and_progress(5, 0)
			($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(5, 0)
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpandedFull.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/EarthExpandedFull.png"))
	elif type == 1:
		if strength == 1:
			($RealEffectSprite as AnimatedSprite3D).set_frame_and_progress(0, 0)
			($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(0, 0)
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded1.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded1.png"))
		elif strength == 2:
			($RealEffectSprite as AnimatedSprite3D).set_frame_and_progress(1, 0)
			($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(1, 0)
			(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded2.png"))
			(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("over_tex", load("res://Test_Assets/CharacterSprites/Effects/IceExpanded2.png"))
		elif strength == 3:
			($Sprite/Arms as AnimatedSprite3D).pause()
			($RealEffectSprite as AnimatedSprite3D).set_frame_and_progress(2, 0)
			($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(2, 0)
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

func manageCast(_delta:float) -> void:
	throwDelay -= _delta
	if throwDelay <= 0 and rangeTo(player) > 5:
		shoot()
		throwDelay = 3

func horizontalMovement() -> Vector3:
	if rangeTo(player) < 10 and movementEnabled and isImpaired == 0:
		speed = -1
		($Sprite/Body as AnimatedSprite3D).play("Walking")
	else:
		speed = 0
		($Sprite/Body as AnimatedSprite3D).play("Idle")
	return target_velocity

func _on_arms_frame_changed() -> void:
	var tempFrame:int = ($ArmEffectSprite as AnimatedSprite3D).frame
	if ($Sprite/Arms as AnimatedSprite3D).frame == 1:
		($ArmEffectSprite as AnimatedSprite3D).position.y = 1.33
		($ArmEffectSprite as AnimatedSprite3D).play("Thrown")
		($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(tempFrame, 0)
		var rock:Area3D = ROCK.instantiate()
		rock.position = Vector3(self.position.x - 1*sin(get_rotation().y), self.position.y+1.5, 
							self.position.z - 1*cos(get_rotation().y))
		rock.rotation.y = get_rotation().y
		if !player.is_on_floor() or rangeTo(player) > 40:
			(rock as test_enemy_boulder).speed = 20
		else:
			(rock as test_enemy_boulder).speed = (rangeTo(player)/2.2)
		get_tree().current_scene.add_child(rock)
	if ($Sprite/Arms as AnimatedSprite3D).frame == 2:
		($Sprite/Arms as AnimatedSprite3D).position.y = 0.576
		($Sprite/Arms as AnimatedSprite3D).play("Idle")
		($ArmEffectSprite as AnimatedSprite3D).position.y = 0.576
		($ArmEffectSprite as AnimatedSprite3D).play("Idle")
		($ArmEffectSprite as AnimatedSprite3D).set_frame_and_progress(tempFrame, 0)

func OBSOLETECODEDONOTUSE() -> void:
	pass
	#func _physics_process(_delta:float) -> void:
	#self.look_at(Vector3(player.global_position.x, self.global_position.y, player.global_position.z))
	#if AIenabled:
		#if isImpaired:
			#return
			##throwDelay -= _delta
			##if throwDelay <= 0 and rangeTo(player) > 5:
				##shoot()
				##throwDelay = 3
		#manageCast(_delta)
		#target_velocity = horizontalMovement()
		##if rangeTo(player) < 10 and movementEnabled and isImpaired == 0:
			##var direction:Vector3 = (Vector3(self.get_rotation().x,0,self.get_rotation().z)).normalized()
			##direction = transform.basis.z
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
