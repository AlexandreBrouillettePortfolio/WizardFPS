extends component_level

var testEnemyKilled:int = 0
var testEnemyMax:int

func _ready() -> void:
	testEnemyMax = $Enemies.get_child_count()
	for enemy in $Enemies.get_children():
		(enemy as test_enemy).spawn()

func enemyKilled() -> void:
	testEnemyKilled += 1
	if testEnemyKilled >= testEnemyMax:
		($/root/Level/Interactables/PunchButton as punch_button).reset()
		testEnemyKilled = 0
