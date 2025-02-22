extends Area3D

func _on_elevator_entered(body: Node3D) -> void:
	(get_node("../MainElevator") as main_elevator).rise()
	queue_free()
