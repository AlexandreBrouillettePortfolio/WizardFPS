class_name electrifiedPillar extends Area3D

var LIGHTNING:PackedScene = preload("res://Test_Objects/test_lightning.tscn")

var ttl:float = 5

func _enter_tree() -> void:
	strike()
	(self.get_child(1) as Timer).start()
	print(self.get_path())

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func strike() -> void:
	for collision in get_overlapping_bodies():
		if collision is test_enemy:
				shoot(collision as test_enemy)

func shoot(enemy:test_enemy) -> void:
	print(position)
	print(global_position)
	print(enemy.position)
	print(enemy.global_position)
	var shootHeight:float = randf_range(self.position.y - 0.5, self.position.y + 1.5)
	var lightning:test_lightning = LIGHTNING.instantiate()
	lightning.position = Vector3(self.position.x, shootHeight, self.position.z)
	lightning.look_at_from_position(Vector3(self.position.x, shootHeight, self.position.z), 
									Vector3(enemy.position.x, enemy.position.y + 0.5, enemy.position.z))
	lightning.target = enemy
	(lightning as test_lightning).distanceToTravel = rangeTo(enemy)
	get_tree().current_scene.add_child(lightning)
	($/root/Level/Player as test_character).refillMana(test_character.manaType.LIGHTNING, true, 1)

func rangeTo(target:Node3D) -> float:
	var catheteX:float = pow(target.position.x - self.position.x, 2)
	var catheteY:float = pow(target.position.y - self.position.y, 2)
	var catheteZ:float = pow(target.position.z - self.position.z, 2)
	var distance:float = sqrt(catheteX+catheteY+catheteZ)
	return distance

func _cooldown_finished() -> void:
	strike()
	(self.get_child(1) as Timer).start()
