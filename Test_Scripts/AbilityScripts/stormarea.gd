extends Area3D

var LIGHTNING:PackedScene

var strikeReady:bool = false
var LightUpTTL:float = 0.2
var parentStorm:Area3D

#func _enter_tree() -> void:
	#strikeReady = true
	#($LightUp as Node3D).global_position.y = parentStorm.global_position.y - 0.2

func _ready() -> void:
	parentStorm = (get_parent() as Area3D)
	strikeReady = true
	LIGHTNING = load("res://Test_Objects/test_lightning.tscn")

func strike() -> void:
	if (self as Area3D).has_overlapping_bodies():
		if (self as Area3D).get_overlapping_bodies()[0] is test_enemy:
			shoot((self as Area3D).get_overlapping_bodies()[0] as test_enemy)

func _physics_process(delta: float) -> void:
	#if LightUpTTL > 0 and ($LightUp as Node3D).visible == true:
		#LightUpTTL -= delta
		#if (LightUpTTL <= 0):
			#($LightUp as Node3D).visible = false
			#LightUpTTL = 0.2
	if (self as Area3D).has_overlapping_bodies() and strikeReady:
		strike()
		strikeReady = false
		($Cooldown as Timer).start()

func shoot(enemy:test_enemy) -> void:
	var lightning:Sprite3D = LIGHTNING.instantiate()
	lightning.rotation = Vector3(-1.5708, 0, 0)
	lightning.position = Vector3(enemy.position.x, parentStorm.position.y, enemy.position.z)
	#print("Position : ", ($LightUp as Node3D).position)
	#print("Global Position : ", ($LightUp as Node3D).global_position)
	#($LightUp as Node3D).position = Vector3(enemy.position.x, parentStorm.position.y - 0.2, enemy.position.z)
	(lightning as test_lightning).target = enemy
	(lightning as test_lightning).distanceToTravel = parentStorm.position.y - enemy.position.y
	(lightning as test_lightning).strength = 4
	#print("Position : ", ($LightUp as Node3D).position)
	#print("Global Position : ", ($LightUp as Node3D).global_position)
	#($LightUp as Node3D).visible = true
	get_tree().current_scene.add_child(lightning)
	($/root/Level/Player as test_character).refillMana(test_character.manaType.LIGHTNING, true, 1)

func _on_cooldown_timeout() -> void:
	strikeReady = true
