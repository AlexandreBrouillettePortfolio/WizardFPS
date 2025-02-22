extends Area3D

var ttl:float = 0.4
var stage:int = 0

func _enter_tree() -> void:
	($CollisionShape3D as CollisionShape3D).disabled = true

func _physics_process(delta: float) -> void:
	if ttl == 0.4:
		spawnModules() #TODO
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func _wave_entered(body: Node3D) -> void:
	if body is test_enemy and (body as test_enemy).get_collision_layer() == 2:
		(body as test_enemy).isDamaged(5, 4, 2)

func spawnModules() -> void: #TODO Implementer le degat
	var mSize:float
	var center:Vector3 = self.global_position
	var initialRotation:Vector3 = self.rotation
	var module:PackedScene = load("res://Test_Objects/wave_module.tscn")
	if true:
		var wMod:wave_module = module.instantiate()
		#add_child(wMod)
		mSize = (wMod as wave_module).size
		center.z -= mSize/2*cos(initialRotation.y)
		center.x -= mSize/2*sin(initialRotation.y)
		wMod.global_position = center
		wMod.rotation = initialRotation
		print(initialRotation)
		#(wMod as wave_module).initial_alignment()
	for i in range(8):
		print("Spawning")
		moduleLoop(center, initialRotation, (i*2)+1, mSize, module)
		await get_tree().physics_frame

func moduleLoop(startPos:Vector3, initialRotation:Vector3, tileNbr:int, mSize:float, module:PackedScene) -> void: #TODO Prendre en compte la rotation
	var depth:int = (tileNbr - 1)/2
	var currentPos:Vector3 = Vector3(startPos.x + depth*mSize*sin(initialRotation.y), startPos.y, startPos.z + depth*mSize*cos(initialRotation.y))
	for i in range(tileNbr):
		#print("Changing Pos")
		var wMod:wave_module = module.instantiate()
		add_child(wMod)
		wMod.global_position = currentPos
		wMod.rotation = initialRotation
		(wMod as wave_module).initial_alignment()
		currentPos.x = currentPos.x - mSize*sin(initialRotation.y-1.5708)

func _growth() -> void: #FIX AFTER WAVE MODULES
	pass
	#stage += 1
	#if stage == 1:
		##($MeshInstance3D as MeshInstance3D).visible = false
		##($MeshInstance3D2 as MeshInstance3D).visible = true
		#($WaveFloor1 as Sprite3D).visible = false
		#($WaveFloor2 as Sprite3D).visible = true
		#($Crystal4 as Sprite3D).visible = true
		#($Crystal5 as Sprite3D).visible = true
		#($Crystal6 as Sprite3D).visible = true
	#if stage == 2:
		##($MeshInstance3D2 as MeshInstance3D).visible = false
		##($MeshInstance3D3 as MeshInstance3D).visible = true
		#($WaveFloor2 as Sprite3D).visible = false
		#($WaveFloor3 as Sprite3D).visible = true
		#($Crystal7 as Sprite3D).visible = true
		#($Crystal8 as Sprite3D).visible = true
		#($CollisionShape3D as CollisionShape3D).disabled = false
	#if stage < 3:
		#($GrowTimer as Timer).start()
