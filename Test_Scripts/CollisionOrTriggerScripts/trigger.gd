class_name trigger extends activator

func _on_trigger_entered(body: Node3D) -> void:
	if body is test_character:
		print(name, " Entered")
		activate()
		queue_free()
