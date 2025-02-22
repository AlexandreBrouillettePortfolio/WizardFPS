class_name destructibleRocks extends Area3D

var breakage:int = 3

func breakSome(str:int) -> void:
	breakage -= str
	checkHealth()

func checkHealth() -> void:
	if breakage == 2:
		($MeshInstance3D3 as Node3D).visible = false
		($MeshInstance3D5 as Node3D).visible = false
		($MeshInstance3D6 as Node3D).visible = false
	elif breakage == 1:
		($MeshInstance3D3 as Node3D).visible = false
		($MeshInstance3D5 as Node3D).visible = false
		($MeshInstance3D6 as Node3D).visible = false
		($MeshInstance3D7 as Node3D).visible = false
		($MeshInstance3D8 as Node3D).visible = false
		($MeshInstance3D2 as Node3D).visible = false
	elif breakage <= 0:
		destroy()

func destroy() -> void:
	queue_free()
