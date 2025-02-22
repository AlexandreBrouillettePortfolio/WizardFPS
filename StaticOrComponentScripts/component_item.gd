class_name item extends Area3D

var baseY:float
var angleTime:float = 0

func _ready() -> void:
	baseY = position.y

func _physics_process(delta: float) -> void:
	angleTime += delta
	position.y = baseY + sin(angleTime)/3
