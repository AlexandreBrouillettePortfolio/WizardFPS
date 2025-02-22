class_name test_earthwall extends StaticBody3D

var normalTexture:CompressedTexture2D = preload("res://Test_Assets/Textures/PillarSprite.png")
var electrifiedTexture:CompressedTexture2D = preload("res://Test_Assets/Textures/PillarSpriteElectrified.png")

@export var riseMax:float = 2.9
var riseTime:float = 0.5
var currentRise:float = 0
var isBreaking:bool = false
var isElectified:bool = false
var connectedSwitch:pillarSwitch
var eArea:Area3D

func _process(delta: float) -> void:
	if (currentRise < riseMax):
		self.position.y += delta*(3.0/riseTime)
		currentRise += delta*(3.0/riseTime)
	elif (currentRise >= riseMax):
		print("Rise Finished")
		currentRise = riseMax
		if connectedSwitch != null:
			connectedSwitch.connected()
		if eArea != null:
			eArea.position = Vector3(self.position.x, self.position.y + 1, 
								self.position.z)
		set_process(false)

func electrify() -> void:
	if isElectified:
		return
	print("Pillar Got Electrified")
	isElectified = true
	(($MeshInstance3D as MeshInstance3D).mesh.surface_get_material(0) as StandardMaterial3D).set_texture(0, electrifiedTexture)
	($OmniLight3D as Node3D).visible = true
	var ELECTRIFIED:PackedScene = load("res://Test_Objects/test_electrifiedPillar.tscn")
	eArea = ELECTRIFIED.instantiate()
	eArea.position = Vector3(self.position.x, self.position.y + 1, 
								self.position.z)
	eArea.rotation = Vector3.ZERO
	get_tree().current_scene.add_child(eArea)
	#add_child(eArea)
	#($test_electrifiedPillar as electrifiedPillar).activate()
	($ElectricTimer as Timer).start()
	if connectedSwitch != null:
		connectedSwitch.electrify()

func explode(throwStrength:float, direction:Vector3) -> void:
	if isBreaking:
		return
	isBreaking = true
	var ROCK:PackedScene = load("res://Test_Objects/test_earthbox.tscn")
	var r1:Area3D = ROCK.instantiate() #Base center rock
	r1.position = Vector3(self.position.x - 0.1*sin(self.get_rotation().y), self.position.y, 
								self.position.z - 0.1*cos(self.get_rotation().y))
	r1.rotation.y = direction.y + randf_range(-0.1, 0.1)
	(r1 as test_earthbox).sAdd = throwStrength
	var r2:Area3D = ROCK.instantiate() #Top center rock
	r2.position = Vector3(self.position.x, self.position.y + 1.5, 
								self.position.z)
	r2.rotation.y = direction.y + randf_range(-0.1, 0.1)
	(r2 as test_earthbox).sAdd = throwStrength
	for child in get_tree().current_scene.get_children():
		if child is Area3D:
			child.queue_free()
	get_tree().current_scene.add_child(r1)
	get_tree().current_scene.add_child(r2)
	queue_free()

func _on_eletric_timer_timeout() -> void:
	isElectified = false
	(($MeshInstance3D as MeshInstance3D).mesh.surface_get_material(0) as StandardMaterial3D).set_texture(0, normalTexture)
	($OmniLight3D as Node3D).visible = false

func pauseTimer(switch:bool) -> void:
	($PauseDelay as Timer).start()
	($ElectricTimer as Timer).set_paused(switch)

func _on_pause_delay_timeout() -> void:
	if eArea != null:
		(eArea as electrifiedPillar).set_physics_process(false)
