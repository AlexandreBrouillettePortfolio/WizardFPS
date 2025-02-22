class_name test_projectile extends test_abstract_projectile

var speed:int = 10

func _ready() -> void:
	set_as_top_level(true)
	set_monitoring(true)

func _enter_tree() -> void:
	#direction = position
	direction = transform.basis.y
	speed = 10

func _physics_process(_delta:float) -> void:
	#pPosition = ($/root/TestLevel/Player/Neck/Camera3D as Camera3D).global_position
	pPosition = ($/root/Level/Player/Neck/Camera3D as Camera3D).global_position
	#pPosition = ($/root/Node3D/Camera3D as Camera3D).global_position
	changeSpriteY()
	#changeSprite()
	var velocity:Vector3 = transform.basis.y * speed
	position += velocity * _delta

func _on_test_projectile_body_entered(body: Node3D) -> void:
	#print("hello")
	#print((body as CharacterBody3D).get_collision_layer())
	if (body is StaticBody3D):
		if (body as StaticBody3D).get_collision_layer_value(3) == true:
			queue_free()
	elif (body is CharacterBody3D): 
		if (body as CharacterBody3D).get_collision_layer() == 2:
			(body as test_enemy).isDamaged(5, 4)
			queue_free()
