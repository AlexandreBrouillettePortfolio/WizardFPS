class_name test_enemy_projectile extends test_abstract_projectile

var speed:int = 16

func _ready() -> void:
	set_as_top_level(true)
	set_monitoring(true)

func _enter_tree() -> void:
	#direction = position
	direction = transform.basis.y

func _physics_process(_delta:float) -> void:
	pPosition = ($/root/Level/Player/Neck/Camera3D as Camera3D).global_position
	#pPosition = ($/root/Node3D/Camera3D as Camera3D).global_position
	changeSpriteY()
	var velocity:Vector3 = direction * speed
	position += velocity * _delta

func _on_test_projectile_body_entered(body: Node3D) -> void:
	if (body is StaticBody3D):
		if (body as StaticBody3D).get_collision_layer_value(3) == true:
			queue_free()
	elif (body is CharacterBody3D):
		if (body as CharacterBody3D).get_collision_layer() == 1:
			(body as test_character).isDamaged(0, 10)
			queue_free()

func OBSOLETECODEDONOTUSE() -> void:
	pass
	#return pPosition.dot(transform.basis.x) > 0.0
	#if (-0.75 < angle.y or angle.y > 0.75):
		#frame = 3 #Very top or bottom
		#($AnimatedSprite3D as Node3D).rotation.x = 0
		#($AnimatedSprite3D as Node3D).rotation.y = 0
		#($AnimatedSprite3D as Node3D).rotation.z = 1.5708 #90 deg
	#elif (-0.75 < angle.y and angle.y < -0.25):
		#frame = 1 # Bottom
		#($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
		#($AnimatedSprite3D as Node3D).rotation.y = 0.6632 #38 deg
		#($AnimatedSprite3D as Node3D).rotation.z = 0.9599 #55 deg
	#elif (-0.25 < angle.y and angle.y < 0.25):
		#frame = 0 # Center
		#($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
		#($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
		#($AnimatedSprite3D as Node3D).rotation.z = 1.5708 #90 deg
	#elif (0.25 < angle.y and angle.y < 0.75):
		#frame = 2 # Top
		#($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
		#($AnimatedSprite3D as Node3D).rotation.y = 2.5307 #145 deg
		#($AnimatedSprite3D as Node3D).rotation.z = 2.1817 #125 deg
	#
	#if angle.z > 0.0:
		#($AnimatedSprite3D as Node3D).rotation.y *= -1
		#($AnimatedSprite3D as Node3D).rotation.z *= -1
	#
	#if (-0.25 < angle.x and angle.x < 0.25):
		#($AnimatedSprite3D as AnimatedSprite3D).play("Side")
		#($AnimatedSprite3D as Node3D).rotation.x = 0
		#($AnimatedSprite3D as Node3D).rotation.z = 1.5708 #90 deg
	#elif angle.x > 0.75:
		#($AnimatedSprite3D as AnimatedSprite3D).play("Back")
	#elif angle.x < -0.75:
		#($AnimatedSprite3D as AnimatedSprite3D).play("Front")
	#if angle.x > 0.5: #If looking from back (Deg > 135) Inverse parce que c'est l'angle du joueur au proj
		#($AnimatedSprite3D as Node3D).rotation.x =  1.5708 #90 deg
		#($AnimatedSprite3D as AnimatedSprite3D).frame = 0
	#elif angle.x < -0.5: #If looking from front (Deg < 45)
		#($AnimatedSprite3D as Node3D).rotation.x =  1.5708 #90 deg
		#($AnimatedSprite3D as AnimatedSprite3D).frame = 4
	#elif (-0.5 < angle.x and angle.x < 0.5): #If looking from sides (Deg 45/135)
		#($AnimatedSprite3D as Node3D).rotation.x = 3.14159 #180 deg
		#($AnimatedSprite3D as AnimatedSprite3D).frame = 6
	#elif 1.963 < angle.x and angle.x < 2.75: #If looking from diagonal back (Deg 1.575)
		#if isRight:
		#if angle.z > 0.0:
			#($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
		#else:
			#($AnimatedSprite3D as Node3D).rotation.x = -0.7854 #45 deg
		#($AnimatedSprite3D as AnimatedSprite3D).frame = 7
	#elif 0.393 < angle.x and angle.x < 1.147: #If looking from diagonal front (Deg 1.575)
		#if angle.z > 0.0:
			#($AnimatedSprite3D as Node3D).rotation.x = 2.3562
		#else:
			#($AnimatedSprite3D as Node3D).rotation.x = -2.3562 #135 deg
		#($AnimatedSprite3D as AnimatedSprite3D).frame = 3 
	#var isRight:bool = isOnRight()
	#print(isRight)
	#var playerVector:Vector3 = pPosition.direction_to(position).normalized()
	#var frontVector:float = playerVector.dot(direction)
	#var upVector:float = playerVector.dot(transform.basis.z)
	#var rightVector:float = playerVector.dot(transform.basis.x)
	#print("Front: ", frontVector, " Up: ", upVector, " Right: ", rightVector)
	#print("isInFront: ", frontVector > 0.0, " isIOnTop: ", upVector > 0.0, " isOnRight: ", rightVector > 0.0)
