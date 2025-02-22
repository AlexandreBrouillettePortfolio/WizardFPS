extends Area3D


func _on_checkpoint_body_entered(body: Node3D) -> void:
	($/root/Level/CheckpointShoot1 as test_enemy).spawn()
	($/root/Level/CheckpointShoot2 as test_enemy).spawn()
	($/root/Level/CheckpointShoot3 as test_enemy).spawn()
	($/root/Level/CheckpointShoot4 as test_enemy).spawn()
	($/root/Level/CheckpointShoot5 as test_enemy).spawn()
	($/root/Level/CheckpointShoot6 as test_enemy).spawn()
	($/root/Level/CheckpointThrow1 as test_enemy).spawn()
	($/root/Level/CheckpointThrow2 as test_enemy).spawn()
	($/root/Level/CheckpointPursuit1 as test_enemy).spawn()
	($/root/Level/CheckpointPursuit2 as test_enemy).spawn()
	($/root/Level/CheckpointPursuit3 as test_enemy).spawn()
	($/root/Level/CheckpointPursuit4 as test_enemy).spawn()
	($/root/Level/CheckpointChase1 as test_enemy).spawn()
	($/root/Level/CheckpointChase2 as test_enemy).spawn()
	($/root/Level/CheckpointChase3 as test_enemy).spawn()
	($/root/Level/CheckpointChase4 as test_enemy).spawn()
	($/root/Level/CheckpointChase5 as test_enemy).spawn()
	queue_free()
