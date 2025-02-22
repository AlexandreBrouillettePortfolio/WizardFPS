extends Area3D


func _on_body_entered(body: Node3D) -> void:
	($/root/Level/TestShoot as test_enemy).spawn()
	($/root/Level/TestThrow as test_enemy).spawn()
	queue_free()
