extends Area3D

var speed:float = 8
var maxRadius:float = 1.5
var radiusExpandRate:float = 0.25
var spriteExpandRate:float = 0.0075
var collisionChild:CollisionShape3D
var spriteChild:Sprite3D
var ttl:float = 3

func _ready() -> void:
	set_as_top_level(true)
	set_monitoring(true)
	collisionChild = get_node("CollisionShape3D")
	spriteChild = get_node("Sprite3D")

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()
	if (collisionChild.shape as SphereShape3D).get_radius() < maxRadius:
		(collisionChild.shape as SphereShape3D).radius += radiusExpandRate*delta
		spriteChild.pixel_size += spriteExpandRate*delta
		position.y += delta/2
	var velocity:Vector3 = -transform.basis.z * speed
	position += velocity * delta

func _flame_entered(body: Node3D) -> void:
	if body is test_enemy:
		(body as test_enemy).isDamaged(5, 5)
