class_name test_ice_explosion extends Area3D

var ttl:float = 0.2
var strength:int = 2
var size:float = 5

func _enter_tree() -> void:
	(($MeshInstance3D as MeshInstance3D).mesh as SphereMesh).radius = size
	(($MeshInstance3D as MeshInstance3D).mesh as SphereMesh).height = 2*size
	(($CollisionShape3D as CollisionShape3D).shape as SphereShape3D).radius = size
	($FogVolume as FogVolume).size = Vector3(size*1.6, size*1.6, size*1.6)

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func _on_explosion_entered(body: Node3D) -> void:
	if (body is CharacterBody3D): 
		if (body as CharacterBody3D).get_collision_layer() == 2:
			(body as test_enemy).isDamaged(5*strength, 4, strength)
