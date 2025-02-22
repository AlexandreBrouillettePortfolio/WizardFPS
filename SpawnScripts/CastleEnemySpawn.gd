extends Area3D


func _on_castle_body_entered(body: Node3D) -> void:
	($/root/Level/CastleChaser1 as test_enemy).spawn()
	($/root/Level/CastleChaser2 as test_enemy).spawn()
	($/root/Level/CastleChaser3 as test_enemy).spawn()
	($/root/Level/CastleShooter1 as test_enemy).spawn()
	($/root/Level/CastleShooter2 as test_enemy).spawn()
	($/root/Level/CastleShooter3 as test_enemy).spawn()
	($/root/Level/CastleThrower1 as test_enemy).spawn()
	($/root/Level/CastleThrower2 as test_enemy).spawn()
	($/root/Level/CastleThrower3 as test_enemy).spawn()
	queue_free()
