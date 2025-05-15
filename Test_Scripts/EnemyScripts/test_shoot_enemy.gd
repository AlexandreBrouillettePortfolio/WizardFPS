class_name test_shoot_enemy extends test_enemy

@export var PROJECTILE:PackedScene = preload("res://Test_Objects/test_enemy_projectile.tscn")

@export var shoot_delay:float = 3

func _ready() -> void:
	health = 20
	speed = 0
	fall_acceleration = 14

func startAnim() -> void:
	($Sprite3D as Node3D).visible = false
	($Sprite as Node3D).visible = true
	for sprite in ($Sprite as Node).get_children():
		(sprite as AnimatedSprite3D).visible = true
		(sprite as AnimatedSprite3D).play()

func shoot() -> void:
	($ShootEffect as AnimatedSprite3D).visible = true
	($Sprite/Arms as AnimatedSprite3D).position.y = 0.24
	($Sprite/Arms as AnimatedSprite3D).play("Shooting")

func manageCast(_delta:float) -> void:
	shoot_delay -= _delta
	if shoot_delay <= 0:
		shoot()
		shoot_delay = 3

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
			($Sprite/Arms as AnimatedSprite3D).pause()
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
			($Sprite/Arms as AnimatedSprite3D).pause()
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

func _on_arms_frame_changed() -> void:
	if ($Sprite/Arms as AnimatedSprite3D).frame == 3:
		var projectile:Area3D = PROJECTILE.instantiate()
		projectile.position = Vector3(self.position.x - 3*sin(get_rotation().y), self.position.y, 
										self.position.z - 3*cos(get_rotation().y))
		projectile.rotation.y = get_rotation().y
		projectile.rotation.x = get_rotation().x - 1.5708
		get_tree().current_scene.add_child(projectile)
		($ShootEffect as AnimatedSprite3D).visible = false
		($Sprite/Arms as AnimatedSprite3D).position.y = -0.036
		($Sprite/Arms as AnimatedSprite3D).play("Idle")

func OBSOLETECODEDONOTUSE() -> void:
	pass
	#func _physics_process(_delta:float) -> void:
	#self.look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z))
	#if AIenabled:
		#if isImpaired:
			#return
		#shoot_delay -= _delta
		#if shoot_delay <= 0:
			#shoot()
			#shoot_delay = 3
