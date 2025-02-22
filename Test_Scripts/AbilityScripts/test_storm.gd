extends Area3D

var LIGHTNING:PackedScene = preload("res://Test_Objects/test_lightning.tscn")

var ttl:float = 10

#func _enter_tree() -> void:
	#strike()
	#($Cooldown as Timer).start()

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

#func strike() -> void:
	#for collisions in self.get_children():
		#if (collisions is Area3D):
			#if (collisions as Area3D).has_overlapping_bodies():
				#if (collisions as Area3D).get_overlapping_bodies()[0] is test_enemy:
					#shoot((collisions as Area3D).get_overlapping_bodies()[0] as test_enemy)

#func shoot(enemy:test_enemy) -> void:
	#var lightning:Sprite3D = LIGHTNING.instantiate()
	#lightning.rotation = Vector3(-1.5708, 0, 0)
	#lightning.position = Vector3(enemy.position.x, self.position.y, enemy.position.z)
	#(lightning as test_lightning).target = enemy
	#(lightning as test_lightning).distanceToTravel = self.position.y - enemy.position.y
	#get_tree().current_scene.add_child(lightning)

#func _cooldown_finished() -> void:
	#strike()
	#($Cooldown as Timer).start()
