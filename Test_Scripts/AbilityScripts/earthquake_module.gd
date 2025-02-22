class_name earthquake_module extends Area3D

var ttl:float = 5 #time to live en secondes
@export var size:float = 1.5
var parent:earthquake_module
var modules:PackedScene
@export var center:Vector3

func _ready() -> void:
	rotation.y = randi() % 4 * 1.5708
	if randi() % 5 == 4:
		($earthquakeRock as Node3D).visible = true

func initial_alignment() -> void:
	await testUpperBoundary()
	($RayCast3D as RayCast3D).force_raycast_update()
	#print(" ")
	#print(name)
	#print(global_position)
	#print(($RayCast3D as RayCast3D).is_colliding())
	#if ($RayCast3D as RayCast3D).is_colliding():
		#print(($RayCast3D as RayCast3D).get_collider())
	if !($RayCast3D as RayCast3D).is_colliding():
		#print("Death to the unworthy")
		queue_free()
	elif ($RayCast3D as RayCast3D).get_collision_mask_value(6):
		modules = load("res://Test_Objects/earthquake_module.tscn")
		#print(position)
		global_transform = align_with_y(global_transform, ($RayCast3D as RayCast3D).get_collision_normal())
		($RayCast3D as RayCast3D).force_raycast_update()
		global_position = ($RayCast3D as RayCast3D).get_collision_point()
		remove_child($RayCast3D)
		#spawnChildren()

func align_with_y(xform:Transform3D, new_y:Vector3) -> Transform3D:
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform

func testUpperBoundary() -> void:
	($RayCast3DUp as RayCast3D).force_raycast_update()
	if (($RayCast3DUp as RayCast3D).is_colliding()):
		var collision:Vector3 = ($RayCast3DUp as RayCast3D).get_collision_point()
		print("Initial Vertical Position: ", global_position)
		global_position = Vector3(collision.x, collision.y + 1, collision.z)
		print("Processed Vertical Position: ", global_position)
	remove_child($RayCast3DUp)

func _physics_process(delta: float) -> void:
	($earthquakeRock as Node3D).position.y += delta/10
	ttl -= delta
	if (ttl <= 0):
		queue_free()
