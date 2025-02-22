class_name test_enemy_punch extends Area3D

var ttl:float = 0.05

func _ready() -> void:
	set_as_top_level(true)
	set_monitoring(true)

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func _punch_entered(body: Node3D) -> void:
	if body is test_character:
		(body as test_character).isDamaged(0, 15)
