class_name test_earthbox extends Area3D

var speed:float = 3
var sAdd:float = 0

func _physics_process(delta: float) -> void:
	var velocity:Vector3 = -transform.basis.z * (speed + sAdd)
	position += velocity * delta

func _earthbox_entered(body: Node3D) -> void:
	if body is StaticBody3D:
		if (body as StaticBody3D).get_collision_layer_value(3) == true:
			queue_free()
	if body is test_earthwall:
		(body as test_earthwall).explode(sAdd, get_rotation())
		queue_free()
	if body is test_enemy:
		(body as test_enemy).isDamaged(10, 2, sAdd, get_rotation()) # Ajoute la vitesse extra au degat
	if body is Area3D:
		if (body as Area3D).get_collision_layer_value(3) == true:
			queue_free()
