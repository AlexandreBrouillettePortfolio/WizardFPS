extends Area3D

var splitProjectile:PackedScene = preload("res://Test_Objects/test_enemy_projectile.tscn")

@export var direction:Vector3
@export var speed:int = 8
var canSplit:bool = true
var distanceTraveled:float = 0

func _physics_process(_delta:float) -> void:
	var velocity:Vector3 = transform.basis.y * speed
	distanceTraveled += speed * _delta
	position += velocity * _delta
	if canSplit and distanceTraveled > 5:
		split()
		canSplit = false

func split() -> void:
	var p1:Area3D = splitProjectile.instantiate()
	p1.position = position
	p1.rotation = Vector3(rotation.x, rotation.y - 0.261799, rotation.z) # Numpad 4 when head-on
	var p2:Area3D = splitProjectile.instantiate()
	p2.position = position
	p2.rotation = Vector3(rotation.x + 0.261799, rotation.y - 0.261799, rotation.z) # Numpad 7 when head-on
	var p3:Area3D = splitProjectile.instantiate()
	p3.position = position
	p3.rotation = Vector3(rotation.x + 0.261799, rotation.y, rotation.z) # Numpad 8 when head-on
	var p4:Area3D = splitProjectile.instantiate()
	p4.position = position
	p4.rotation = Vector3(rotation.x + 0.261799, rotation.y + 0.261799, rotation.z) # Numpad 9 when head-on
	var p5:Area3D = splitProjectile.instantiate()
	p5.position = position
	p5.rotation = Vector3(rotation.x, rotation.y + 0.261799, rotation.z) # Numpad 6 when head-on
	var p6:Area3D = splitProjectile.instantiate()
	p6.position = position
	p6.rotation = Vector3(rotation.x - 0.261799, rotation.y + 0.261799, rotation.z) # Numpad 3 when head-on
	var p7:Area3D = splitProjectile.instantiate()
	p7.position = position
	p7.rotation = Vector3(rotation.x - 0.261799, rotation.y, rotation.z) # Numpad 2 when head-on
	var p8:Area3D = splitProjectile.instantiate()
	p8.position = position
	p8.rotation = Vector3(rotation.x - 0.261799, rotation.y - 0.261799, rotation.z) # Numpad 1 when head-on
	get_tree().current_scene.add_child(p1)
	get_tree().current_scene.add_child(p2)
	get_tree().current_scene.add_child(p3)
	get_tree().current_scene.add_child(p4)
	get_tree().current_scene.add_child(p5)
	get_tree().current_scene.add_child(p6)
	get_tree().current_scene.add_child(p7)
	get_tree().current_scene.add_child(p8)

func _on_test_projectile_body_entered(body: Node3D) -> void:
	if (body is StaticBody3D):
		if (body as StaticBody3D).get_collision_layer_value(3) == true:
			queue_free()
	elif (body is CharacterBody3D): 
		if (body as CharacterBody3D).get_collision_layer() == 1:
			(body as test_character).isDamaged(0, 10)
			queue_free()
