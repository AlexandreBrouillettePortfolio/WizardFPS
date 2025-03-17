class_name test_spike_wave extends Area3D

var spike:PackedScene
var distanceTraveled:float = 0
var growthHeight:float = 0
var baseY:float
var height:float = 2

func _ready() -> void:
	spike = load("res://Test_Objects/test_spike_wave.tscn")

func shoot(startingDistance:float, assignedPosition:Vector3, parentRotation:Vector3) -> void:
	distanceTraveled = startingDistance
	position = assignedPosition
	rotation.y = parentRotation.y
	baseY = position.y - height
	position.y = baseY

func _physics_process(delta: float) -> void:
	growthHeight += delta*10
	if growthHeight >= height:
		growthHeight = height
		position.y = baseY + growthHeight
		if distanceTraveled + 1 < 20:
			var nextSpike:test_spike_wave = spike.instantiate()
			var nextPosition:Vector3 = Vector3(self.position.x - 1*sin(get_rotation().y), self.position.y, 
											self.position.z - 1*cos(get_rotation().y))
			nextSpike.shoot(distanceTraveled + 1, nextPosition, get_rotation())
			get_tree().current_scene.add_child(nextSpike)
		queue_free()
	else:
		position.y = baseY + growthHeight

func _spike_entered(body: Node3D) -> void:
	if body is test_character:
		(body as test_character).isDamaged(0, 20)
