extends item

@export var strength:int = 25

func _potion_entered(body: Node3D) -> void:
	if body is test_character:
		(body as test_character).manaPotionDrank(strength)
		queue_free()
