class_name test_earthquake extends Area3D

var ttl:float = 5 #time to live en secondes
var isOnFire:bool = false
var modules:PackedScene = preload("res://Test_Objects/earthquake_module.tscn")

func _enter_tree() -> void:
	strike()
	(get_node("NormalAnimation") as AnimatedSprite3D).play()
	(get_node("FireAnimation") as AnimatedSprite3D).play()
	($Timer as Timer).start()

func setOnFire() -> void:
	isOnFire = true
	((get_node("MeshInstance3D") as MeshInstance3D).mesh.surface_get_material(0) as BaseMaterial3D).set_albedo(Color(255,0,0)) 
	(get_node("NormalAnimation") as Node3D).visible = false
	(get_node("FireAnimation") as Node3D).visible = true

func _earthquake_targeted(area: Area3D) -> void:
	if area is test_fireball and !isOnFire:
		setOnFire()

func strike() -> void:
	var bodyList:Array[test_enemy]
	var areaList:Array[Area3D]
	for child in get_children():
		if child is earthquake_module:
			if (child as earthquake_module).has_overlapping_bodies():
				print(child.name)
				for body in (child as earthquake_module).get_overlapping_bodies():
					print(body.name)
					if body is test_enemy and !bodyList.has(body):
						if !isOnFire:
							(body as test_enemy).isDamaged(0, 3)
						else:
							(body as test_enemy).isDamaged(0, 5)
						bodyList.append(body)
			if (child as earthquake_module).has_overlapping_areas():
				for body in (child as earthquake_module).get_overlapping_areas():
					print(body.name)
					if isOnFire and body is test_tornado and !areaList.has(body):
						(body as test_tornado).setOnFire()
					if body is destructibleRocks and !areaList.has(body):
						print("Has overlapping areas")
						(body as destructibleRocks).breakSome(1)
					areaList.append(body)

func _cooldown_finished() -> void:
	strike()
	($Timer as Timer).start()

func _physics_process(delta: float) -> void:
	if ttl == 5:
		spawnModules()
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func spawnModules() -> void: #Remplacer la methode dans Module ici pour spawn les tuiles
	var mSize:float
	var center:Vector3 = self.global_position
	var module:PackedScene = load("res://Test_Objects/earthquake_module.tscn")
	if true:
		var eMod:earthquake_module = module.instantiate()
		add_child(eMod)
		eMod.global_position = center
		mSize = (eMod as earthquake_module).size
		(eMod as earthquake_module).initial_alignment()
	moduleLoopX(center, Vector3(center.x + mSize, center.y, center.z), 1, module, 10, mSize) #Droite du centre
	moduleLoopX(center, Vector3(center.x - mSize, center.y, center.z), -1, module, 10, mSize) #Gauche du centre
	moduleLoopZ(center, Vector3(center.x, center.y, center.z + mSize), 1, module, 10, mSize) #En Haut du centre
	moduleLoopZ(center, Vector3(center.x, center.y, center.z - mSize), -1, module, 10, mSize) #En Bas du centre

func moduleLoopX(center:Vector3, startPos:Vector3, polarity:int, module:PackedScene, range:float, mSize:float) -> void:
	while MovementScript.rangeTo(startPos, center) < range:
		var eMod:earthquake_module = module.instantiate()
		add_child(eMod)
		eMod.global_position = startPos
		(eMod as earthquake_module).initial_alignment()
		moduleLoopZ(center, Vector3(startPos.x, startPos.y, startPos.z + mSize), 1, module, range, mSize)
		moduleLoopZ(center, Vector3(startPos.x, startPos.y, startPos.z - mSize), -1, module, range, mSize)
		startPos.x = startPos.x + mSize*polarity

func moduleLoopZ(center:Vector3, startPos:Vector3, polarity:int, module:PackedScene, range:float, mSize:float) -> void:
	while MovementScript.rangeTo(startPos, center) < range:
		var eMod:earthquake_module = module.instantiate()
		add_child(eMod)
		eMod.global_position = startPos
		(eMod as earthquake_module).initial_alignment()
		startPos.z = startPos.z + mSize*polarity
