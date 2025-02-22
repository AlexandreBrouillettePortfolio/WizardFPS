class_name test_punch extends Area3D

var ttl:float = 0.05
var playerSpeed:float = 0

func _ready() -> void:
	set_as_top_level(true)
	set_monitoring(true)

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func _punch_entered(body: Node3D) -> void:
	if body is test_earthwall:
		(body as test_earthwall).explode(playerSpeed, get_rotation())
	if body is test_enemy:
		(body as test_enemy).isDamaged(10, 2, playerSpeed, get_rotation()) # Ajoute la vitesse extra au degat

func _projectile_entered(area: Area3D) -> void:
	if area is test_abstract_projectile:
		(area as test_abstract_projectile).queue_free()
		
