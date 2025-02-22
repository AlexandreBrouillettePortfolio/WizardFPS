extends Area3D

func _door_close_trigger_entered(body: Node3D) -> void:
	if body is test_character:
		($/root/Level/Map/ArenaDoor as arena_door).lower()
		($/root/Level/LevelBoss as test_boss).spawn()
		($/root/Level/LevelBoss as test_boss).activateAI()
		queue_free()
