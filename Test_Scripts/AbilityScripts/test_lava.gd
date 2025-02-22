extends Area3D

var ttl:float = 5 #time to live en secondes

func _enter_tree() -> void:
	strike()
	($StrikeTimer as Timer).start()

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func strike() -> void:
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if body is test_enemy:
				(body as test_enemy).isDamaged(5, 6)
	if has_overlapping_areas():
		for body in get_overlapping_areas():
			if body is test_tornado:
				(body as test_tornado).setOnFire()
			elif body is test_earthquake:
				(body as test_earthquake).setOnFire()

func _on_strike_timer_timeout() -> void:
	strike()
	($StrikeTimer as Timer).start()
