class_name test_float_platform extends StaticBody3D

var fall_acceleration:float = 0.5
var fall_velocity:float = 0

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	fall_velocity = fall_velocity + (fall_acceleration * delta)
	global_position.y -= fall_velocity

func fall() -> void:
	set_physics_process(true)
	
