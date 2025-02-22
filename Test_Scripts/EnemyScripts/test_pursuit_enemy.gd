class_name test_pursuit_enemy extends test_enemy

@export var PUNCH:PackedScene = preload("res://Test_Objects/test_enemy_punch.tscn")

var punchDelay:float = 2

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

func shoot() -> void:
	($Sprite/Arms as AnimatedSprite3D).play("Attacking") 
	movementEnabled = false

func showDamage() -> void:
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	($isDamaged as Timer).start()

func manageCast(_delta:float) -> void:
	punchDelay -= _delta
	if punchDelay <= 0 and rangeTo(player) < 1:
		shoot()
		punchDelay = 2

func horizontalMovement() -> Vector3:
	if  movementEnabled and isImpaired == 0:
		var direction:Vector3 = (Vector3(self.get_rotation().x,0,self.get_rotation().z)).normalized()
		direction = -transform.basis.z
		target_velocity.x = direction.normalized().x * speed
		target_velocity.z = direction.normalized().z * speed
		($Sprite/Body as AnimatedSprite3D).play("Walking")
	else:
		target_velocity.x = 0
		target_velocity.z = 0
		($Sprite/Body as AnimatedSprite3D).play("Idle")
		if ($Sprite/Arms as AnimatedSprite3D).animation != "Attacking":
			($Sprite/Arms as AnimatedSprite3D).play("Idle")
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

func _on_arm_frame_changed() -> void:
	if ($Sprite/Arms as AnimatedSprite3D).animation == "Attacking" and ($Sprite/Arms as AnimatedSprite3D).frame == 1: 
		var punch:Area3D = PUNCH.instantiate()
		punch.position = Vector3(self.position.x - 1*sin(get_rotation().y), self.position.y+0.5, 
							self.position.z - 1*cos(get_rotation().y))
		punch.rotation = Vector3(0, get_rotation().y, 0)
		get_tree().current_scene.add_child(punch)
	if ($Sprite/Arms as AnimatedSprite3D).frame == 2:
		($Sprite/Arms as AnimatedSprite3D).play("Idle") 
		movementEnabled = !inTornado

func OBSOLETECODEDONOTUSE() -> void:
	pass
	#func _physics_process(_delta:float) -> void:
	#look_at(Vector3(player.global_position.x, self.global_position.y, player.global_position.z))
	#if AIenabled:
		#if isImpaired:
			#return
		#manageCast(_delta)
		#horizontalMovement()
		#if inTornado:
			#target_velocity.y = 1 #Modifier par valeur de la tornade
		#elif is_on_floor():
			#target_velocity.y = 0
		#else: 
			#target_velocity.y = target_velocity.y - (fall_acceleration * _delta)
		#velocity = target_velocity + wind_velocity
		#move_and_slide()
