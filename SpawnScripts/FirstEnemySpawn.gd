extends Area3D


func _on_first_spawn_entered(body: Node3D) -> void:
	($/root/Level/FirstPursuit1 as test_enemy).spawn()
	($/root/Level/FirstPursuit2 as test_enemy).spawn()
	($/root/Level/FirstPursuit3 as test_enemy).spawn()
	($/root/Level/FirstPursuit4 as test_enemy).spawn()
	($/root/Level/FirstShoot1 as test_enemy).spawn()
	($/root/Level/FirstShoot2 as test_enemy).spawn()
	($/root/Level/FirstShoot3 as test_enemy).spawn()
	($/root/Level/FirstShoot4 as test_enemy).spawn()
	($/root/Level/FirstShoot5 as test_enemy).spawn()
	($/root/Level/FirstShoot6 as test_enemy).spawn()
	($/root/Level/FirstThrow1 as test_enemy).spawn()
	($/root/Level/FirstThrow2 as test_enemy).spawn()
	($/root/Level/FirstThrow3 as test_enemy).spawn()
	($/root/Level/FirstChase1 as test_enemy).spawn()
	($/root/Level/FirstChase2 as test_enemy).spawn()
	($/root/Level/FirstPursuitSpawnSound as AudioStreamPlayer3D).play()
	queue_free()
