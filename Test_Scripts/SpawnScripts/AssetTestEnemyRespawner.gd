extends activatable

var CHASE:PackedScene = preload("res://Test_Objects/test_chase_enemy.tscn")
var PURSUIT:PackedScene = preload("res://Test_Objects/test_pursuit_enemy.tscn")
var SHOOT:PackedScene = preload("res://Test_Objects/test_shoot_enemy.tscn")
var THROW:PackedScene = preload("res://Test_Objects/test_throw_enemy.tscn")
var BOSS:PackedScene = preload("res://Test_Objects/test_boss.tscn")


func activate() -> void:
	var chase_enemy:test_chase_enemy = CHASE.instantiate()
	var pursuit_enemy:test_pursuit_enemy = PURSUIT.instantiate()
	var shoot_enemy:test_shoot_enemy = SHOOT.instantiate()
	var throw_enemy:test_throw_enemy = THROW.instantiate()
	var boss_enemy:test_boss = BOSS.instantiate()
	
	$/root/Level/Enemies.add_child(chase_enemy)
	$/root/Level/Enemies.add_child(pursuit_enemy)
	$/root/Level/Enemies.add_child(shoot_enemy)
	$/root/Level/Enemies.add_child(throw_enemy)
	$/root/Level/Enemies.add_child(boss_enemy)
	
	chase_enemy.position = Vector3(-42.55, 2.07, 7.335)
	pursuit_enemy.position = Vector3(-42.48, 1.967, 5.144)
	shoot_enemy.position = Vector3(-42.58, 1.759, 9.536)
	throw_enemy.position = Vector3(-42.65, 2.26, 11.736)
	boss_enemy.position = Vector3(-42.21, 3, 15.394)
	
	for enemy in $/root/Level/Enemies.get_children():
		(enemy as test_enemy).spawn()
	
