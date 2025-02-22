extends activatable

func activate() -> void:
	($Label3D as Label3D).text = "Currently Activated"

func deactivate() -> void:
	($Label3D as Label3D).text = "Currently Deactivated"
