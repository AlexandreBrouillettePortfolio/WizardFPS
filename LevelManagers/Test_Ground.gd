class_name test_ground extends Node3D

var enemyCount:int = 9

func enemyKilled() -> void:
	enemyCount -= 1
	if enemyCount == 0:
		(get_node("Map/ArenaDoor") as arena_door).rise()
