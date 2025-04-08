class_name stoneTower extends component_level

var pillarRoomConnections:int = 0
var teleportRoomConnections:int = 0
var part2Connections:int = 0
var earthquake4Connections:int = 0

func _enter_tree() -> void:
	for child in ($Map/Navigation/NavigationRegion3D/StoneTower as Node3D).get_children():
		print(child.name)
		for node in child.get_children():
			if (node is StaticBody3D):
				(node as StaticBody3D).set_collision_layer_value(1, false)
				(node as StaticBody3D).set_collision_layer_value(3, true)
				(node as StaticBody3D).set_collision_mask_value(1, true)
				(node as StaticBody3D).set_collision_mask_value(2, true)
				(node as StaticBody3D).set_collision_mask_value(3, true)
				if "Floor" in child.name:
					(node as StaticBody3D).set_collision_layer_value(6, true)
				if "Wall" in child.name:
					(node as StaticBody3D).set_collision_layer_value(7, true)
				if "Ceiling" in child.name:
					(node as StaticBody3D).set_collision_layer_value(8, true)
	for child in ($Map/Navigation/NavigationRegion3D/StoneTowerArena as Node3D).get_children():
		for node in child.get_children():
			if (node is StaticBody3D):
				(node as StaticBody3D).set_collision_layer_value(1, false)
				(node as StaticBody3D).set_collision_layer_value(3, true)
				(node as StaticBody3D).set_collision_mask_value(1, true)
				(node as StaticBody3D).set_collision_mask_value(2, true)
				(node as StaticBody3D).set_collision_mask_value(3, true)
				if "Floor" in child.name:
					(node as StaticBody3D).set_collision_layer_value(6, true)
				if "Wall" in child.name:
					(node as StaticBody3D).set_collision_layer_value(7, true)
				if "Ceiling" in child.name:
					(node as StaticBody3D).set_collision_layer_value(8, true)

func _on_teleport_1_body_entered(body: Node3D) -> void:
	if !($Timers/TeleportCooldown as Timer).is_stopped():
		return
	($Map/WorldEnvironment as WorldEnvironment).environment.ambient_light_source = Environment.AMBIENT_SOURCE_BG
	if body is test_character:
		body.position = ($Teleporters/Teleport2Area/MeshInstance3D as Node3D).global_position
		(body as test_character).neck.rotation.y = -1.5708
		($Timers/TeleportCooldown as Timer).start()

func _on_teleport_2_body_entered(body: Node3D) -> void:
	if !($Timers/TeleportCooldown as Timer).is_stopped():
		return
	($Map/WorldEnvironment as WorldEnvironment).environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	if body is test_character:
		($Triggers/MainReturn1/CollisionShape3D as CollisionShape3D).set_deferred("disabled", false)
		body.position = ($Teleporters/Teleport1Area/MeshInstance3D as Node3D).global_position
		(body as test_character).neck.rotation.y = -1.5708
		($Timers/TeleportCooldown as Timer).start()

func _on_teleport_3_body_entered(body: Node3D) -> void:
	if !($Timers/TeleportCooldown as Timer).is_stopped():
		return
	if body is test_character:
		body.position = ($Teleporters/Teleport4Area/MeshInstance3D as Node3D).global_position
		(body as test_character).neck.rotation.y = 0
		($Timers/TeleportCooldown as Timer).start()

func _on_teleport_4_body_entered(body: Node3D) -> void:
	if !($Timers/TeleportCooldown as Timer).is_stopped():
		return
	if body is test_character:
		body.position = ($Teleporters/Teleport3Area/MeshInstance3D as Node3D).global_position
		(body as test_character).neck.rotation.y = 0
		($Timers/TeleportCooldown as Timer).start()

func _on_teleport_5_body_entered(body: Node3D) -> void:
	if !($Timers/TeleportCooldown as Timer).is_stopped():
		return
	if body is test_character:
		body.position = ($Teleporters/Teleport6Area/MeshInstance3D as Node3D).global_position
		(body as test_character).neck.rotation.y = 0
		($Timers/TeleportCooldown as Timer).start()

func _on_teleport_6_body_entered(body: Node3D) -> void:
	if !($Timers/TeleportCooldown as Timer).is_stopped():
		return
	if body is test_character:
		body.position = ($Teleporters/Teleport5Area/MeshInstance3D as Node3D).global_position
		(body as test_character).neck.rotation.y = 0
		($Timers/TeleportCooldown as Timer).start()

func _on_spellbook_punch_tree_exited() -> void:
	($Doors/ReverseStoneDoorTutorial as reverse_stone_door).deactivate()
	($Doors/ReverseStoneDoorPostTutorial as reverse_stone_door).deactivate()

func _on_spellbook_pillar_tree_exited() -> void:
	#Destroy Pillars in adjacent room and near the teleporter
	if get_node_or_null("Map/Navigation/NavigationRegion3D/Pillars/PillarRoom1") != null:
		($Map/Navigation/NavigationRegion3D/Pillars/PillarRoom1 as Node3D).queue_free()
	if get_node_or_null("Map/Navigation/NavigationRegion3D/Pillars/PillarTeleporter1") != null:
		($Map/Navigation/NavigationRegion3D/Pillars/PillarTeleporter1 as Node3D).queue_free()
	($Doors/StoneDoorPillarExit as stone_door).deactivate()

func _on_spellbook_earthquake_tree_exited() -> void:
	($Lighting/CeilingLights/ChandelierEarthquake as activatable).activate()
	($Lighting/CeilingLights/ChandelierTwoStage as activatable).activate()
	($Lighting/CeilingLights/Chandelier2ndDeathTrap as activatable).activate()
	
func pillarRoomConnectionMade(body:Node3D) -> void:
	if body is test_earthwall:
		checkPillarRoomDoors(1)

func pillarRoomConnectionBroken(body:Node3D) -> void:
	if body is test_earthwall:
		checkPillarRoomDoors(-1)

func checkPillarRoomDoors(change:int) -> void:
	pillarRoomConnections += change
	print(pillarRoomConnections)
	if pillarRoomConnections == 4:
		($Doors/StoneDoorPillarSpell as stone_door).activate()
	elif pillarRoomConnections < 4:
		($Doors/StoneDoorPillarSpell as stone_door).deactivate()

func teleportRoomConnectionMade(body:Node3D) -> void:
	if body is test_earthwall:
		checkTeleportRoomDoors(1)

func teleportRoomConnectionBroken(body:Node3D) -> void:
	if body is test_earthwall:
		checkTeleportRoomDoors(-1)

func checkTeleportRoomDoors(change:int) -> void:
	teleportRoomConnections += change
	print(teleportRoomConnections)
	if teleportRoomConnections == 2:
		($Doors/StoneDoorTeleporter as stone_door).activate()
	elif teleportRoomConnections < 2:
		($Doors/StoneDoorTeleporter as stone_door).deactivate()

func _on_death_zone_body_entered(body: Node3D) -> void:
	if body is test_character:
		(body as test_character).isDamaged(1, 100)
	elif body is test_enemy:
		(body as test_enemy).isDamaged(100, 1)

func part2ConnectionMade(body:Node3D) -> void:
	if body is test_earthwall:
		checkPart2Door(1)

func part2ConnectionBroken(body:Node3D) -> void:
	if body is test_earthwall:
		checkPart2Door(-1)

func checkPart2Door(change:int) -> void:
	part2Connections += change
	print(part2Connections)
	if part2Connections == 2:
		($Doors/StoneDoorPart2 as stone_door).activate()
	elif part2Connections < 2:
		($Doors/StoneDoorPart2 as stone_door).deactivate()

func earthquake4ConnectionMade(body:Node3D) -> void:
	if body is test_earthwall:
		earthquake4Door(1)

func earthquake4ConnectionBroken(body:Node3D) -> void:
	if body is test_earthwall:
		earthquake4Door(-1)

func earthquake4Door(change:int) -> void:
	earthquake4Connections += change
	print(earthquake4Connections)
	if earthquake4Connections == 2:
		($Doors/StoneDoorEarthquake3 as stone_door).activate()
	elif earthquake4Connections < 2:
		($Doors/StoneDoorEarthquake3 as stone_door).deactivate()

func onTriggerEnter(body: Node3D, id: String) -> void:
	if body is test_character:
		for node in ($Spawns as Node).get_children():
			if node.name == id:
				for enemy in node.get_children():
					(enemy as test_enemy).spawn()
