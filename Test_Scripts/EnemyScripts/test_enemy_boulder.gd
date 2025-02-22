class_name test_enemy_boulder extends test_abstract_projectile

var speed:int = 20
@export var fall_acceleration:int = 14
var target_velocity:Vector3 = Vector3.ZERO

func _ready() -> void:
	set_as_top_level(true)
	set_monitoring(true)
	target_velocity.y = 15 #Speed set for easier range calculations

func _physics_process(_delta:float) -> void:
	pPosition = ($/root/Level/Player/Neck/Camera3D as Camera3D).global_position
	#pPosition = ($/root/Node3D/Camera3D as Camera3D).global_position
	changeSpriteZ()
	direction = -transform.basis.z
	target_velocity.x = direction.normalized().x * speed
	target_velocity.z = direction.normalized().z * speed
	target_velocity.y = target_velocity.y - (fall_acceleration * _delta)
	position += target_velocity * _delta

func _boulder_entered(body: Node3D) -> void:
	if (body is StaticBody3D):
		if (body as StaticBody3D).get_collision_layer_value(3) == true:
			queue_free()
	elif body is CharacterBody3D:
			(body as test_character).isDamaged(0, 30)
			queue_free()
