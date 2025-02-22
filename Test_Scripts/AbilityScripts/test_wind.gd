extends Area3D

var windStrength:float = 4

func _enter_tree() -> void:
	(get_node("AnimatedSprite3D") as AnimatedSprite3D).play()
	(get_node("AnimatedSprite3D2") as AnimatedSprite3D).play()

func _physics_process(delta: float) -> void:
	if self.has_overlapping_bodies():
		for body:Node3D in self.get_overlapping_bodies():
			if (body is test_enemy):
				if (body as test_enemy).isOnFire:
					flameSpread()
				(body as test_enemy).isInWind(true, Vector3(sin(get_rotation().y)*windStrength,0,
							cos(get_rotation().y)*windStrength))

func flameSpread() -> void:
	for body:Node3D in self.get_overlapping_bodies():
		if (body is test_enemy):
			(body as test_enemy).setOnFire(true)
#func _wind_entered(body: Node3D) -> void:
	#if body is test_enemy and (body as test_enemy).get_collision_layer() == 2:
		#(body as test_enemy).isInWind(true, rotation*windStrength)

func _wind_exited(body: Node3D) -> void:
	if body is test_enemy and (body as test_enemy).get_collision_layer() == 2:
		(body as test_enemy).isInWind(false)
