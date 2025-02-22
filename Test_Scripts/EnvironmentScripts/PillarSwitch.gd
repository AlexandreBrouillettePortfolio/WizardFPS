class_name pillarSwitch extends activator

var baseY:float
var angleTime:float = 0
var electrified:bool = false
var connectionMade:bool = false

func _ready() -> void:
	baseY = position.y

func _physics_process(delta: float) -> void:
	#angleTime += delta
	#position.y = baseY + sin(angleTime)/3
	set_collision_layer_value(1, not get_collision_layer_value(1))

func _on_body_entered(body: Node3D) -> void:
	if body is test_earthwall:
		body.rotation = get_rotation()
		body.position.x = get_position().x
		body.position.z = get_position().z
		(body as test_earthwall).connectedSwitch = self

func _on_body_exited(body: Node3D) -> void:
	if body is test_earthwall:
		depower()
		disconnected()
		(body as test_earthwall).connectedSwitch = null

func connected() -> void:
	#print("Making connection")
	connectionMade = true
	#print("Electrified? : ", electrified)
	activate()
	if electrified:
		for collision in get_overlapping_bodies():
			if collision is test_earthwall:
				(collision as test_earthwall).electrify()
				(collision as test_earthwall).pauseTimer(true)
		for collision in get_overlapping_areas():
			if collision is electricCircuit:
				(collision as electricCircuit).electrify()

func disconnected() -> void:
	connectionMade = false
	#deactivate()

func electrify() -> void:
	if electrified:
		return
	#print("Base Got Electrified")
	electrified = true
	if connectionMade:
		for collision in get_overlapping_bodies():
			if collision is test_earthwall:
				(collision as test_earthwall).electrify()
				(collision as test_earthwall).pauseTimer(true)
		for collision in get_overlapping_areas():
			if collision is electricCircuit:
				(collision as electricCircuit).electrify()

func depower() -> void:
	if !electrified:
		return
	#print("Base Got Depowered")
	electrified = false
	#for collision in get_overlapping_bodies():
		#if collision is test_earthwall:
			#(collision as test_earthwall).pauseTimer(false)
	for collision in get_overlapping_areas():
		if collision is electricCircuit:
			(collision as electricCircuit).depower()
