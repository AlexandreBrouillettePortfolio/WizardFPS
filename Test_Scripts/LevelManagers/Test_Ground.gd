class_name test_ground extends component_level

var enemyCount:int = 9

func enemyKilled() -> void:
	enemyCount -= 1
	if enemyCount == 0:
		(get_node("Map/ArenaDoor") as arena_door).rise()
