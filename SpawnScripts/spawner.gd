class_name spawner extends activatable

func activate() -> void:
	for child in get_children():
		(child as test_enemy).spawn()
