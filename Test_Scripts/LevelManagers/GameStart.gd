extends Button

func _add_a_scene_manually() -> void:
	get_tree().change_scene_to_file("res://Test_Scenes/StoneTowerLevel.tscn")

func _quit() -> void:
	get_tree().quit()
