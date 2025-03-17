class_name test_boss extends test_enemy

var spike:PackedScene = preload("res://Test_Objects/test_spike_wave.tscn")
var sProjectile:PackedScene = preload("res://Test_Objects/test_boss_projectile.tscn")

func _ready() -> void:
	health = 300
	speed = 0
	fall_acceleration = 14
	freezeLimit = 7
	petrifyLimit = 7

func _enter_tree() -> void:
	pass
	#invincible = true # Si Boss plante pour aucune raison: verifier connexions de la variable isInvincible

func ChildSpawnParameters() -> void:
	activateAI()

func startAnim() -> void:
	($Sprite3D as Node3D).visible = false
	($Sprite as Node3D).visible = true
	for sprite in ($Sprite as Node).get_children():
		(sprite as AnimatedSprite3D).visible = true
		(sprite as AnimatedSprite3D).play()

func teleport() -> void:
	var teleportSpotNum:int = $/root/Level/Map/BossTelePoints.get_child_count()
	if teleportSpotNum <= 0:
		return
	var teleSpot:int = randi_range(0, teleportSpotNum-1)
	position = Vector3(($/root/Level/Map/BossTelePoints.get_child(teleSpot) as Node3D).global_position.x, global_position.y, 
						($/root/Level/Map/BossTelePoints.get_child(teleSpot) as Node3D).global_position.z)
	look_at(player.global_position)

func activateAI() -> void:
	set_physics_process(true)
	(get_node("Timer") as Timer).start()
	(get_node("SpikeWaveTimer") as Timer).start()
	#invincible = false

func _teleport_ready() -> void:
	($Sprite/Body as AnimatedSprite3D).play("Teleporting") 

func _spike_wave_ready() -> void:
	if player.is_on_floor():
		($Sprite/Arms as AnimatedSprite3D).position.y = -0.102
		($Sprite/Arms as AnimatedSprite3D).position.x = 0.291
		($Sprite/Arms as AnimatedSprite3D).play("Attacking") 
	else:
		($Sprite/Arms as AnimatedSprite3D).play("Shooting") 

func _on_arms_frame_changed() -> void:
	if ($Sprite/Arms as AnimatedSprite3D).animation == "Attacking" and ($Sprite/Arms as AnimatedSprite3D).frame == 1: 
		($Sprite/Arms as AnimatedSprite3D).position.y = 0.47
		($Sprite/Arms as AnimatedSprite3D).position.x = -0.272
		var nextSpike:test_spike_wave = spike.instantiate()
		var nextPosition:Vector3 = Vector3(self.position.x - 0.66*sin(get_rotation().y), self.position.y, 
									self.position.z - 0.66*cos(get_rotation().y))
		nextSpike.shoot(0, nextPosition, get_rotation())
		get_tree().current_scene.add_child(nextSpike)
	if ($Sprite/Arms as AnimatedSprite3D).animation == "Shooting" and ($Sprite/Arms as AnimatedSprite3D).frame == 1: 
		var projectile:Area3D = sProjectile.instantiate()
		projectile.position = Vector3(self.position.x - 3*sin(get_rotation().y), self.position.y + 1.5, 
										self.position.z - 3*cos(get_rotation().y))
		projectile.rotation.y = get_rotation().y
		projectile.rotation.x = get_rotation().x - 1.5900
		get_tree().current_scene.add_child(projectile)
	if ($Sprite/Arms as AnimatedSprite3D).frame == 2:
		($Sprite/Arms as AnimatedSprite3D).position.y = -0.102
		($Sprite/Arms as AnimatedSprite3D).position.x = 0.129
		($Sprite/Arms as AnimatedSprite3D).play("Idle") 
		movementEnabled = !inTornado

func _on_body_frame_changed() -> void:
	if ($Sprite/Body as AnimatedSprite3D).animation == "Teleporting"  and ($Sprite/Body as AnimatedSprite3D).frame == 4: 
		teleport()
		(get_node("Timer") as Timer).start()
		($Sprite/Body as AnimatedSprite3D).play("Idle")

func showDamage() -> void:
	(($Sprite/Arms as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	(($Sprite/Body as AnimatedSprite3D).material_overlay as ShaderMaterial).set_shader_parameter("isDamageActive", true)
	($isDamaged as Timer).start()
	var tempTweenHead:Tween = create_tween()
	tempTweenHead.set_parallel(false)
	tempTweenHead.tween_property($Sprite/Head, "modulate", Color.RED, 0)
	tempTweenHead.tween_property($Sprite/Head, "modulate", Color.RED, 0.15)
	tempTweenHead.tween_property($Sprite/Head, "modulate", Color.WHITE, 0)

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

func OBSOLETECODEDONOTUSE() -> void:
	pass
	#---Test_Ground TELEPORT ALGORITHM---
	#if teleSpot == 0: #Center of Arena
		#position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						#(get_node("../Map/ArenaFloor") as StaticBody3D).position.z)
		#look_at(player.global_position)
	#elif teleSpot == 1: # Start position
		#position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						#(get_node("../Map/ArenaFloor") as StaticBody3D).position.z+ 17.5)
		#look_at(player.global_position) 
	#elif teleSpot == 2: # Door position
		#position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						#(get_node("../Map/ArenaFloor") as StaticBody3D).position.z - 17.5)
		#look_at(player.global_position)
	#elif teleSpot == 3: # Left when looking from entrance
		#position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x + 17.5, position.y, 
						#(get_node("../Map/ArenaFloor") as StaticBody3D).position.z)
		#look_at(player.global_position)
	#elif teleSpot == 4: # Right when looking from entrance
		#position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						#(get_node("../Map/ArenaFloor") as StaticBody3D).position.z - 17.5)
		#look_at(player.global_position)
