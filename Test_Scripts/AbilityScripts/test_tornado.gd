class_name test_tornado extends Area3D

var ttl:float = 10 #time to live en secondes
var speed:float = 1
var isOnFire:bool = false
var direction:Vector3

func _ready() -> void:
	set_as_top_level(true)
	set_monitoring(true)

func _enter_tree() -> void:
	direction = -transform.basis.z

func _physics_process(delta: float) -> void:
	if ttl == 10:
		if has_overlapping_areas():
			print("Tornado is in Area")
			for body in get_overlapping_areas():
				if body is earthquake_module and (body.get_parent() as test_earthquake).isOnFire:
					setOnFire()
	var pPosition:Vector3 = ($/root/Level/Player/Neck/Camera3D as Camera3D).global_position
	look_at(Vector3(pPosition.x, self.position.y, pPosition.z))
	ttl -= delta
	if (ttl <= 0):
		queue_free()
	var velocity:Vector3 = direction * speed
	position += velocity * delta

func strike() -> void:
	if has_overlapping_areas():
		for body in get_overlapping_areas():
			if isOnFire and body is test_tornado:
				(body as test_tornado).setOnFire()
	if has_overlapping_bodies():
		for body in get_overlapping_bodies():
			if isOnFire and body is test_enemy:
				(body as test_enemy).isDamaged(5, 5)

func _tornado_entered(body: Node3D) -> void:
	if body is test_enemy and (body as test_enemy).get_collision_layer() == 2:
		(body as test_enemy).inTornadoSwitch(true)

func _tornado_exited(body: Node3D) -> void:
	if body is test_enemy and (body as test_enemy).get_collision_layer() == 2:
		(body as test_enemy).inTornadoSwitch(false)

func setOnFire() -> void:
	if isOnFire:
		return
	isOnFire = true
	var tempTween:Tween = create_tween()
	tempTween.tween_property($TornadoInterior, "mesh:material:albedo_color:r", 1, 0)
	tempTween.tween_property($TornadoExterior, "mesh:material:albedo_color:r", 1, 0)
	tempTween.tween_property($TornadoInterior, "mesh:material:albedo_color:g", 0, 0)
	tempTween.tween_property($TornadoExterior, "mesh:material:albedo_color:g", 0, 0)
	($Sprite as AnimatedSprite3D).play("OnFire")
	(get_child(2) as Timer).start()
	strike()

func _cooldown_finished() -> void:
	strike()
	(get_child(2) as Timer).start()

func _turning_time() -> void:
	($TornadoExterior as MeshInstance3D).rotation.y -= 0.785
	($TornadoInterior as MeshInstance3D).rotation.y += 0.785
	(get_child(4) as Timer).start()
