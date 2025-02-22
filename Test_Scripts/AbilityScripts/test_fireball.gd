class_name test_fireball extends Area3D

var ttl:float = 0.2

func _enter_tree() -> void:
	(get_node("AnimatedSprite3D") as AnimatedSprite3D).play()

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()
			
#Fonction d'explosion
func _on_body_entered(body: Node3D) -> void:
	if (body is StaticBody3D):
		if (body as StaticBody3D).get_collision_layer_value(3) == true:
			pass
	elif (body is CharacterBody3D): 
		if (body as CharacterBody3D).get_collision_layer() == 2:
			(body as test_enemy).isDamaged(5, 6)

func _fireball_targeted(area: Area3D) -> void:
	if (area is test_earthquake):
		if (area as test_earthquake).get_collision_layer() == 4 and !(area as test_earthquake).isOnFire:
			(area as test_earthquake).setOnFire()
	elif (area is earthquake_module):
		if !(area.get_parent() as test_earthquake).isOnFire:
			(area.get_parent() as test_earthquake).setOnFire()
	elif (area is test_tornado):
		(area as test_tornado).setOnFire()
