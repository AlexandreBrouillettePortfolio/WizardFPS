extends activatable

var rubblePile:PackedScene = preload("res://Test_Objects/destructible_rocks.tscn")

var fall_acceleration:int = 14
var maxFallSpeed:int = 10
var currentFallSpeed: float = 0

func _ready() -> void:
	set_physics_process(false)

func activate() -> void:
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	currentFallSpeed = currentFallSpeed - (fall_acceleration * delta)
	position.y += currentFallSpeed * delta

func _chandelier_entered(body: Node3D) -> void:
	if (body is test_earthwall):
		var rubble:Area3D = rubblePile.instantiate()
		get_tree().current_scene.add_child(rubble)
		rubble.global_position = body.global_position
		rubble.global_position.y -= 0.25
		body.queue_free()
		queue_free()
		
