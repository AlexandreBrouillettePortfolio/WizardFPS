extends item

func _on_body_entered(body: Node3D) -> void:
	if body is test_character:
		queue_free()
