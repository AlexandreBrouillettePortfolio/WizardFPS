extends Area3D


func _on_platform_entered(body: Node3D) -> void:
	if (body is StaticBody3D):
		if (body as StaticBody3D).get_collision_layer_value(3) == true:
			print("Platform destroyed")
			(get_node("..") as test_float_platform).queue_free()
			queue_free()
