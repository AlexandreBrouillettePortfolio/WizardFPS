class_name test_boss extends test_enemy

var spike:PackedScene = preload("res://Test_Objects/test_spike_wave.tscn")
var sProjectile:PackedScene = preload("res://Test_Objects/test_boss_projectile.tscn")

func _ready() -> void:
	health = 300
	speed = 3
	fall_acceleration = 14
	freezeLimit = 7
	petrifyLimit = 7

func _enter_tree() -> void:
	invincible = true # Si Boss plante pour aucune raison: verifier connexions de la variable isInvincible

func _physics_process(delta: float) -> void:
	look_at(player.global_position)

func teleport() -> void:
	var teleSpot:int = randi_range(0, 4)
	if teleSpot == 0: #Center of Arena
		position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						(get_node("../Map/ArenaFloor") as StaticBody3D).position.z)
		look_at(player.global_position)
	elif teleSpot == 1: # Start position
		position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						(get_node("../Map/ArenaFloor") as StaticBody3D).position.z+ 17.5)
		look_at(player.global_position) 
	elif teleSpot == 2: # Door position
		position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						(get_node("../Map/ArenaFloor") as StaticBody3D).position.z - 17.5)
		look_at(player.global_position)
	elif teleSpot == 3: # Left when looking from entrance
		position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x + 17.5, position.y, 
						(get_node("../Map/ArenaFloor") as StaticBody3D).position.z)
		look_at(player.global_position)
	elif teleSpot == 4: # Right when looking from entrance
		position = Vector3((get_node("../Map/ArenaFloor") as StaticBody3D).position.x, position.y, 
						(get_node("../Map/ArenaFloor") as StaticBody3D).position.z - 17.5)
		look_at(player.global_position)

func activateAI() -> void:
	set_physics_process(true)
	(get_node("Timer") as Timer).start()
	(get_node("SpikeWaveTimer") as Timer).start()
	invincible = false

func _teleport_ready() -> void:
	teleport()
	(get_node("Timer") as Timer).start()

func _spike_wave_ready() -> void:
	if player.is_on_floor():
		var nextSpike:test_spike_wave = spike.instantiate()
		var nextPosition:Vector3 = Vector3(self.position.x - 0.66*sin(get_rotation().y), self.position.y, 
									self.position.z - 0.66*cos(get_rotation().y))
		nextSpike.shoot(0, nextPosition, get_rotation())
		get_tree().current_scene.add_child(nextSpike)
	else:
		var projectile:Area3D = sProjectile.instantiate()
		projectile.position = Vector3(self.position.x - 3*sin(get_rotation().y), self.position.y + 1.5, 
										self.position.z - 3*cos(get_rotation().y))
		projectile.rotation.y = get_rotation().y
		projectile.rotation.x = get_rotation().x - 1.5900
		get_tree().current_scene.add_child(projectile)

func _on_spawning_sprite_animation_finished() -> void:
	($SpawningSprite as AnimatedSprite3D).stop()
