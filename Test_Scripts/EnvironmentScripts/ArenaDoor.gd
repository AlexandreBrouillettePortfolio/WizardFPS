class_name arena_door extends StaticBody3D

var isRisen:bool = false
var baseY:float

func _ready() -> void:
	baseY = position.y

func _physics_process(delta: float) -> void:
	if isRisen:
		if position.y < baseY + 5:
			position.y += delta
	else:
		if position.y > baseY:
			position.y -= 2 * delta

func rise() -> void:
	isRisen = true

func lower() -> void:
	isRisen = false
