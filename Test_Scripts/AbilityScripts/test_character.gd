class_name test_character extends CharacterBody3D

@export var PROJECTILE:PackedScene = preload("res://Test_Objects/test_projectile.tscn")
@export var EARTHQUAKE:PackedScene = preload("res://Test_Objects/test_earthquake.tscn")
@export var EARTHWALL:PackedScene = preload("res://Test_Objects/test_earthwall.tscn")
@export var LIGHTNING:PackedScene = preload("res://Test_Objects/test_lightning.tscn")
@export var WIND:PackedScene = preload("res://Test_Objects/test_wind.tscn")
@export var TORNADO:PackedScene = preload("res://Test_Objects/test_tornado.tscn")
@export var FLAMETHROWER:PackedScene = preload("res://Test_Objects/test_flamethrower.tscn")
@export var FIREBALL:PackedScene = preload("res://Test_Objects/test_fireball.tscn")
@export var STORM:PackedScene = preload("res://Test_Objects/test_storm.tscn")
@export var WAVE:PackedScene = preload("res://Test_Objects/test_wave.tscn")
@export var PUNCH:PackedScene = preload("res://Test_Objects/test_punch.tscn")
@export var TURBULENCE:PackedScene = preload("res://Test_Objects/test_turbulence.tscn")

@export var health:int = 100
@export var speed:int = 5
@export var slideSpeed:int = 12
var slideMaxSpeed:int = 20
@export var dropSpeed:int = 25
var currentSpeed:float = 0
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration:int = 14
@export var maxFallSpeed:int = 10
@export var jump_impulse:int = 10
var isDashing:bool = false
var dashSpeed:int = 25
var dashDirection:Vector3 = Vector3.ZERO

@export var selected_element:int = 1

@export var lightning_mana:int = 100
@export var earth_mana:int = 100
@export var wind_mana:int = 100
@export var ice_mana:int = 100
@export var fire_mana:int = 100

var mvmtType:int = 0

var flyManaTick:float = 0.2
var flyManaTickTracker:float = 0

var slideManaTick:float = 0.2
var slideManaTickTracker:float = 0

var windEnabled:bool = false
var windManaTick:float = 0.2
var windManaTickTracker:float = 0
var wind:Area3D

var flightEnabled:bool = false

#var fakeFireball:Area3D
#var fireballCharging:bool = false
#var fireballMaxRadius:float = 0.3
#var fireballChargeRate:float = 0.1

var flameEnabled:bool = false
var flamethrowSpeed:float = 0.0835
var flamethrowTrack:float = 0
var flamethrowManaTick:float = 0.05
var flamethrowManaTickTrack:float = 0

var primaryShootReady:bool = true
var primaryShootElement:manaType = manaType.LIGHTNING
var secondaryShootReady:bool = true
var secondaryShootElement:manaType = manaType.LIGHTNING
enum manaType {LIGHTNING, EARTH, WIND, ICE, FIRE}

@onready var neck:Node3D = $Neck
@onready var camera:Camera3D = $Neck/Camera3D
var direction:Vector3

var onGroundLast:bool = true
var target_velocity:Vector3 = Vector3.ZERO

func _enter_tree() -> void:
	var tempTween:Tween = create_tween()
	tempTween.tween_property($Neck/Camera3D/Sprite2D, "modulate", Color(0.06, 0.06, 1), 0)

func cast_primary(element:manaType) -> void:
	primaryShootReady = false
	if element == manaType.LIGHTNING:
		primaryShootElement = manaType.LIGHTNING
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Right_Hand.png")
		($PrimaryCastTime as Timer).wait_time = 0.05
		($PrimaryCastTime as Timer).start()
	elif element == manaType.EARTH:
		primaryShootElement = manaType.EARTH
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Punch_Prep.png")
		($PrimaryCastTime as Timer).wait_time = 0.15
		($PrimaryCastTime as Timer).start()
	elif element == manaType.WIND:
		primaryShootElement = manaType.WIND
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Right_Hand.png")
		($PrimaryCastTime as Timer).wait_time = 0.2
		($PrimaryCastTime as Timer).start()
	elif element == manaType.ICE:
		primaryShootElement = manaType.ICE
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Right_Hand.png")
		($PrimaryCastTime as Timer).wait_time = 0.3
		($PrimaryCastTime as Timer).start()
	elif element == manaType.FIRE:
		primaryShootElement = manaType.FIRE
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Flick_Prep.png")
		($PrimaryCastTime as Timer).wait_time = 0.15
		($PrimaryCastTime as Timer).start()

func cast_secondary(element:manaType) -> void:
	secondaryShootReady = false
	if element == manaType.LIGHTNING:
		secondaryShootElement = manaType.LIGHTNING
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Left_Hand.png")
		($SecondaryCastTime as Timer).wait_time = 0.5
		($SecondaryCastTime as Timer).start()
	elif element == manaType.EARTH:
		secondaryShootElement = manaType.EARTH
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Left_Hand.png")
		($SecondaryCastTime as Timer).wait_time = 0.35
		($SecondaryCastTime as Timer).start()
	elif element == manaType.WIND:
		secondaryShootElement = manaType.WIND
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Left_Hand.png")
		($SecondaryCastTime as Timer).wait_time = 0.2
		($SecondaryCastTime as Timer).start()
	elif element == manaType.ICE:
		secondaryShootElement = manaType.ICE
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Left_Hand.png")
		($SecondaryCastTime as Timer).wait_time = 0.3
		($SecondaryCastTime as Timer).start()
	elif element == manaType.FIRE:
		secondaryShootElement = manaType.FIRE
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Closed_Left_Hand.png")
		($SecondaryCastTime as Timer).wait_time = 0.4
		($SecondaryCastTime as Timer).start()

func shoot(type:PackedScene) -> void:
	if type == LIGHTNING:
		($Neck/Camera3D/RayCast3D as RayCast3D).force_raycast_update()
		if ($Neck/Camera3D/RayCast3D as RayCast3D).is_colliding():
			if manaChange(0, manaType.LIGHTNING, lightning_mana):
				var hit_object:Node3D = ($Neck/Camera3D/RayCast3D as RayCast3D).get_collider()
				var position3D:Vector3 = ($Neck/Camera3D/RayCast3D as RayCast3D).get_collision_point()
				var lightning:test_lightning = LIGHTNING.instantiate()
				lightning.rotation = Vector3(sin(camera.rotation.x), neck.rotation.y, 90)
				lightning.position = self.position
				(lightning as test_lightning).distanceToTravel = rangeTo(hit_object)
				lightning.target = hit_object
				#lightning.position = -transform.basis.z.normalized().z + (lightning.texture.get_size().x)/2
				get_tree().current_scene.add_child(lightning)
		#($PrimaryCastTime as Timer).start()
	elif type == PROJECTILE:
		if manaChange(10, manaType.ICE, ice_mana):
			var projectile:Area3D = PROJECTILE.instantiate()
			#projectile.position = self.position
			projectile.position = Vector3(self.position.x - 0.6*sin(neck.get_rotation().y), self.position.y, 
										self.position.z - 0.6*cos(neck.get_rotation().y))
			projectile.rotation.y = neck.get_rotation().y
			projectile.rotation.x = camera.get_rotation().x - 1.53589
			get_tree().current_scene.add_child(projectile)
		#($PrimaryCastTime as Timer).start()
	elif type == WIND:
		if manaChange(10, manaType.WIND, wind_mana):
			windEnabled = true
			wind = WIND.instantiate()
			get_tree().current_scene.add_child(wind)
			#($PrimaryCastTime as Timer).one_shot = false
			#($PrimaryCastTime as Timer).start()
	elif type == EARTHQUAKE:
		#var space_state:PhysicsDirectSpaceState3D = get_world_3d().get_direct_space_state()
		#var ray_query:PhysicsRayQueryParameters3D = getIntersectionPoint()
		#var position3D:Vector3 = Vector3.ZERO
		#if (space_state.intersect_ray(ray_query) != {}):
			#if manaChange(50, manaType.EARTH, earth_mana):
				#position3D = space_state.intersect_ray(ray_query).get("position")
				#var earthquake:Area3D = EARTHQUAKE.instantiate()
				#earthquake.position = position3D
				#get_tree().current_scene.add_child(earthquake)
		($Neck/Camera3D/RayCast3D as RayCast3D).force_raycast_update()
		if ($Neck/Camera3D/RayCast3D as RayCast3D).is_colliding():
			if manaChange(50, manaType.EARTH, earth_mana):
				var position3D:Vector3 = ($Neck/Camera3D/RayCast3D as RayCast3D).get_collision_point()
				var earthquake:Area3D = EARTHQUAKE.instantiate()
				get_tree().current_scene.add_child(earthquake)
				earthquake.global_position = position3D
				#($SecondaryCastTime as Timer).start()
	elif type == EARTHWALL:
		if manaChange(20, manaType.EARTH, earth_mana):
			var earthwall:StaticBody3D = EARTHWALL.instantiate()
			earthwall.position = Vector3(self.position.x - 2*sin(neck.get_rotation().y), self.position.y - 3, 
										self.position.z - 2*cos(neck.get_rotation().y))
			earthwall.rotation.y = neck.get_rotation().y
			get_tree().current_scene.add_child(earthwall)
			#($SecondaryCastTime as Timer).start()
	elif type == TORNADO:
		if manaChange(30, manaType.WIND, wind_mana):
			var tornado:Area3D = TORNADO.instantiate()
			tornado.position = Vector3(self.position.x - 3*sin(neck.get_rotation().y), self.position.y + 2.2, 
										self.position.z - 3*cos(neck.get_rotation().y))
			tornado.rotation.y = neck.get_rotation().y
			get_tree().current_scene.add_child(tornado)
			#($SecondaryCastTime as Timer).start()
	elif type == FLAMETHROWER:
			var flamethrower:Area3D = FLAMETHROWER.instantiate()
			flamethrower.position = self.position
			flamethrower.rotation.y = neck.get_rotation().y
			get_tree().current_scene.add_child(flamethrower)
			#($SecondaryCastTime as Timer).start()
	elif type == FIREBALL:
		#var space_state:PhysicsDirectSpaceState3D = get_world_3d().get_direct_space_state()
		#var ray_query:PhysicsRayQueryParameters3D = getIntersectionPoint()
		#var position3D:Vector3 = Vector3.ZERO
		#if (space_state.intersect_ray(ray_query) != {}):
			#if manaChange(10, manaType.FIRE, fire_mana):
				#position3D = space_state.intersect_ray(ray_query).get("position")
				#var fireball:Area3D = FIREBALL.instantiate()
				#fireball.position = position3D
				#get_tree().current_scene.add_child(fireball)
		($Neck/Camera3D/RayCast3D as RayCast3D).force_raycast_update()
		if ($Neck/Camera3D/RayCast3D as RayCast3D).is_colliding():
			if manaChange(10, manaType.FIRE, fire_mana):
				var position3D:Vector3 = ($Neck/Camera3D/RayCast3D as RayCast3D).get_collision_point()
				var fireball:Area3D = FIREBALL.instantiate()
				#fireball.global_position = position3D
				get_tree().current_scene.add_child(fireball)
				fireball.global_position = position3D
		#($PrimaryCastTime as Timer).start()
	elif type == STORM:
		($Neck/Camera3D/RayCast3D as RayCast3D).force_raycast_update()
		if ($Neck/Camera3D/RayCast3D as RayCast3D).is_colliding():
			if manaChange(50, manaType.LIGHTNING, lightning_mana):
				var position3D:Vector3 = ($Neck/Camera3D/RayCast3D as RayCast3D).get_collision_point()
				var storm:Area3D = STORM.instantiate()
				storm.position = Vector3(position3D.x, position3D.y + 10, 
									 	position3D.z)
				get_tree().current_scene.add_child(storm)
			#($SecondaryCastTime as Timer).start()
	elif type == WAVE:
		if manaChange(50, manaType.ICE, ice_mana):
			var wave:Area3D = WAVE.instantiate()
			wave.position = Vector3(self.position.x - 1*sin(neck.get_rotation().y), self.position.y - 0.75, 
										self.position.z - 1*cos(neck.get_rotation().y))
			wave.rotation.y = neck.get_rotation().y + 3.14159
			get_tree().current_scene.add_child(wave)
			#($SecondaryCastTime as Timer).start()
	elif type == PUNCH:
		if manaChange(5, manaType.EARTH, earth_mana):
			var punch:Area3D = PUNCH.instantiate()
			punch.position = Vector3(self.position.x - 1*sin(neck.get_rotation().y)*cos(camera.get_rotation().x), 
										self.position.y + 0.5 + 1*sin(camera.get_rotation().x), 
											self.position.z - 1*cos(neck.get_rotation().y)*cos(camera.get_rotation().x))
			punch.rotation = Vector3(camera.get_rotation().x, neck.get_rotation().y, 0)
			(punch as test_punch).playerSpeed = currentSpeed
			get_tree().current_scene.add_child(punch)
		#($PrimaryCastTime as Timer).start()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#get_tree().paused = false
		if event.is_action_pressed("primary_fire"):
			if primaryShootReady:
				if selected_element == 1:
					cast_primary(manaType.LIGHTNING)
				elif selected_element == 2:
					cast_primary(manaType.EARTH)
				elif selected_element == 3:
					cast_primary(manaType.WIND)
				elif selected_element == 4:
					cast_primary(manaType.ICE)
				elif selected_element == 5:
					cast_primary(manaType.FIRE)
		elif event.is_action_pressed("secondary_fire"):
			if secondaryShootReady:
				if selected_element == 1:
					cast_secondary(manaType.LIGHTNING)
				elif selected_element == 2:
					cast_secondary(manaType.EARTH)
				elif selected_element == 3:
					cast_secondary(manaType.WIND)
				elif selected_element == 4:
					cast_secondary(manaType.ICE)
				elif selected_element == 5:
					cast_secondary(manaType.FIRE)
		elif event.is_action_released("primary_fire"):
			if primaryShootElement == manaType.WIND:
				if windEnabled:
					windEnabled = false
					wind.queue_free()
					windManaTickTracker = 0
				($PrimaryCastTime as Timer).stop()
				_reset_hand()
		elif event.is_action_released("secondary_fire"):
			if secondaryShootElement == manaType.FIRE:
				flameEnabled = false
				flamethrowTrack = 0
				($SecondaryCastTime as Timer).stop()
				_reset_left_hand()
	elif event is InputEventKey:
		if event.is_action_pressed("select_lightning"):
			changeElement(manaType.LIGHTNING)
		elif event.is_action_pressed("select_earth"):
			changeElement(manaType.EARTH)
		elif event.is_action_pressed("select_wind"):
			changeElement(manaType.WIND)
		elif event.is_action_pressed("select_water"):
			changeElement(manaType.ICE)
		elif event.is_action_pressed("select_fire"):
			changeElement(manaType.FIRE)
		elif event.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			#get_tree().paused = true
		elif event.is_action_pressed("slide"):
			if manaChange(10, manaType.LIGHTNING, lightning_mana):
				isDashing = true
				($DashTimer as Timer).start()
				dashDirection = direction
				alignDashEffect()
		elif event.is_action_released("slide"):
			updateMvmtEffect(0)
		elif event.is_action_pressed("jump"):
			if is_on_floor():
				target_velocity.y = jump_impulse
			else:
				flightEnabled = true
		elif event.is_action_released("jump"):
			flightEnabled = false
			updateMvmtEffect(0)
		elif event.is_action_pressed("aux"):
			if is_on_floor():
				shoot(EARTHWALL)
		elif event.is_action_released("ctrl"):
			slideSpeed = 12
			updateMvmtEffect(0)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-(event as InputEventMouseMotion).relative.x * 0.01)
			camera.rotate_x(-(event as InputEventMouseMotion).relative.y  * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func _physics_process(delta:float) -> void:
	#Wind calculations
	if windEnabled:
		windManaTickTracker += delta
		if windManaTickTracker >= windManaTick:
			if !manaChange(1, manaType.WIND, wind_mana, false):
				windEnabled = false
				wind.queue_free()
			windManaTickTracker = 0
		wind.position = Vector3(self.position.x - 1*sin(neck.get_rotation().y), self.position.y, 
									self.position.z - 1*cos(neck.get_rotation().y))
		wind.rotation.y = neck.get_rotation().y + 3.14159
		#wind.rotation.x = camera.get_rotation().x - 1.53589
	#Flamethrower calculations
	if flameEnabled:
		flamethrowTrack += delta
		flamethrowManaTickTrack += delta
		if flamethrowManaTickTrack >= flamethrowManaTick:
			if !manaChange(1, manaType.FIRE, fire_mana, false):
				flameEnabled = false
				flamethrowTrack = 0
			flamethrowManaTickTrack = 0
		if flamethrowTrack >= flamethrowSpeed:
			shoot(FLAMETHROWER)
			flamethrowTrack = 0
	
	# We create a local variable to store the input direction.
	var input_dir := Input.get_vector("move_left", "move_right", "move_fwd", "move_back")
	direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		if Input.is_action_pressed("ctrl"):
			target_velocity.y = -dropSpeed
		elif flightEnabled:
			flyManaTickTracker += delta
			if mvmtType != 1:
				updateMvmtEffect(1)
			if flyManaTickTracker >= flyManaTick:
				if manaChange(2, manaType.WIND, wind_mana, false):
					target_velocity.y = 0
				else:
					target_velocity.y = target_velocity.y - (fall_acceleration * delta)
				flyManaTickTracker = 0
			elif wind_mana == 0 or wind_mana == 1:
				target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		else:
			#Test static function for falling
			#MovementScript.normalFall(fall_acceleration, target_velocity, delta, maxFallSpeed)
			if target_velocity.y <= -maxFallSpeed:
				target_velocity.y = -maxFallSpeed
			else:
				target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	# Ground Velocity
	if Input.is_action_pressed("ctrl"):
		if is_on_floor() and !onGroundLast: #IMPLEMENTER LE SYSTEME DE DETECTION DE TOUCHE
			shoot(TURBULENCE)
		if is_on_floor() and ($DashTimer as Timer).is_stopped(): 
			slideManaTickTracker += delta #Ice must be valid to start but not to keep up
			if mvmtType != 2:
				updateMvmtEffect(2)
			if slideManaTickTracker >= slideManaTick:
				if manaChange(2, manaType.ICE, ice_mana, false):
					target_velocity.x = direction.x * slideSpeed
					target_velocity.z = direction.z * slideSpeed
					if slideSpeed < slideMaxSpeed:
						slideSpeed += 1
				else:
					target_velocity.x = direction.x * speed
					target_velocity.z = direction.z * speed
				slideManaTickTracker = 0
	else: 
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
	currentSpeed = sqrt(pow(target_velocity.x,2) + pow(target_velocity.z,2)) # Garde la somme de vitesse pour punch
	# Moving the Character
	if !($DashTimer as Timer).is_stopped():
		velocity = Vector3(dashDirection.x * dashSpeed, dashDirection.y * dashSpeed, 
							dashDirection.z * dashSpeed)
	else:
		velocity = target_velocity
	move_and_slide()

func manaChange(cost:int, element:manaType, elementMana:int, isManaAdded:bool = true) -> bool:
	if canRemoveMana(cost, elementMana):
		removeMana(cost, element)
		updateManaUI(element)
		refillMana(element, isManaAdded)
		return true
	else: 
		print("Out of mana")
		return false

func refillMana(element:manaType, isManaAdded:bool, amount:int = 3) -> void:
	if !isManaAdded:
		return
	if element != manaType.LIGHTNING:
		addMana(amount, manaType.LIGHTNING)
	if element != manaType.EARTH:
		addMana(amount, manaType.EARTH)
	if element != manaType.WIND:
		addMana(amount, manaType.WIND)
	if element != manaType.ICE:
		addMana(amount, manaType.ICE)
	if element != manaType.FIRE:
		addMana(amount, manaType.FIRE)

func manaPotionDrank(amount:int) -> void:
	addMana(amount, manaType.LIGHTNING)
	addMana(amount, manaType.EARTH)
	addMana(amount, manaType.WIND)
	addMana(amount, manaType.ICE)
	addMana(amount, manaType.FIRE)

func healthPotionDrank(amount:int) -> void:
	health += amount
	if health >= 100:
		health = 100
	updateHealthUI()

func removeMana(cost:int, element:manaType) -> void:
	if element == manaType.LIGHTNING:
		lightning_mana -= cost
	elif element == manaType.EARTH:
		earth_mana -= cost
	elif element == manaType.WIND:
		wind_mana -= cost
	elif element == manaType.ICE:
		ice_mana -= cost
	elif element == manaType.FIRE:
		fire_mana -= cost

func addMana(toAdd:int, element:manaType) -> void:
	if element == manaType.LIGHTNING:
		lightning_mana += toAdd
		if lightning_mana > 100:
			lightning_mana = 100
	elif element == manaType.EARTH:
		earth_mana += toAdd
		if earth_mana > 100:
			earth_mana = 100
	elif element == manaType.WIND:
		wind_mana += toAdd
		if wind_mana > 100:
			wind_mana = 100
	elif element == manaType.ICE:
		ice_mana += toAdd
		if ice_mana > 100:
			ice_mana = 100
	elif element == manaType.FIRE:
		fire_mana += toAdd
		if fire_mana > 100:
			fire_mana = 100
	updateManaUI(element)

func canRemoveMana(toRemove:int, elementMana:int) -> bool:
	if elementMana - toRemove < 0:
		return false
	else:
		return true

func changeElement(element:manaType) -> void:
	var tempTween:Tween = create_tween()
	if element == manaType.LIGHTNING:
		selected_element = 1
		tempTween.tween_property($Neck/Camera3D/Sprite2D, "modulate", Color(0.06, 0.06, 1), 0)
	elif element == manaType.EARTH:
		selected_element = 2
		tempTween.tween_property($Neck/Camera3D/Sprite2D, "modulate", Color(0.98, 0.416, 0), 0)
	elif element == manaType.WIND:
		selected_element = 3
		tempTween.tween_property($Neck/Camera3D/Sprite2D, "modulate", Color(0.22, 1, 0), 0)
	elif element == manaType.ICE:
		selected_element = 4
		tempTween.tween_property($Neck/Camera3D/Sprite2D, "modulate", Color(0.18, 1, 1), 0)
	elif element == manaType.FIRE:
		selected_element = 5
		tempTween.tween_property($Neck/Camera3D/Sprite2D, "modulate", Color(1, 0.105, 0), 0)

func updateManaUI(element:manaType) -> void:
	if element == manaType.LIGHTNING:
		(get_node("Neck/Camera3D/LightningManaUI") as TextureProgressBar).value = lightning_mana
		(get_node("Neck/Camera3D/LightningManaLabel") as Label).text = str(lightning_mana)
	if element == manaType.EARTH:
		(get_node("Neck/Camera3D/EarthManaUI") as TextureProgressBar).value = earth_mana
		(get_node("Neck/Camera3D/EarthManaLabel") as Label).text = str(earth_mana)
	if element == manaType.WIND:
		(get_node("Neck/Camera3D/WindManaUI") as TextureProgressBar).value = wind_mana
		(get_node("Neck/Camera3D/WindManaLabel") as Label).text = str(wind_mana)
	if element == manaType.ICE:
		(get_node("Neck/Camera3D/IceManaUI") as TextureProgressBar).value = ice_mana
		(get_node("Neck/Camera3D/IceManaLabel") as Label).text = str(ice_mana)
	if element == manaType.FIRE:
		(get_node("Neck/Camera3D/FireManaUI") as TextureProgressBar).value = fire_mana
		(get_node("Neck/Camera3D/FireManaLabel") as Label).text = str(fire_mana)

func updateHealthUI() -> void:
	if health == 0:
		(get_node("Neck/Camera3D/HealthLabel") as Label).text = "!!GAME OVER!!"
	else:
		(get_node("Neck/Camera3D/HealthLabel") as Label).text = str(health)

func updateMvmtEffect(effect:int) -> void:
	if effect == 0: #Normal Movement
		($MvmtEffect as MeshInstance3D).visible = false
		(($MvmtEffect as MeshInstance3D).mesh.surface_get_material(0) as BaseMaterial3D).set("albedo_texture", null)
		mvmtType = 0
		($MvmtEffectTimer as Timer).stop()
	elif effect == 1: #Wind Flight
		($MvmtEffect as MeshInstance3D).visible = true
		(($MvmtEffect as MeshInstance3D).mesh.surface_get_material(0) as BaseMaterial3D).set("albedo_color", Color(0.41,0.74,0.18,1))
		(($MvmtEffect as MeshInstance3D).mesh.surface_get_material(0) as BaseMaterial3D).set("albedo_texture", load("res://Test_Assets/AbilitySprites/Flight_Wind1.png"))
		mvmtType = 1
		($MvmtEffectTimer as Timer).start()
	elif effect == 2: #Ice Skating
		($MvmtEffect as MeshInstance3D).visible = true
		(($MvmtEffect as MeshInstance3D).mesh.surface_get_material(0) as BaseMaterial3D).set_albedo(Color(0,255,255,0.05))
		(($MvmtEffect as MeshInstance3D).mesh.surface_get_material(0) as BaseMaterial3D).set("albedo_texture", null)
		mvmtType = 2

func isDamaged(dmgType:int, strength:int, dmgDir:Vector3 = Vector3.ZERO) -> void:
	health -= strength
	if health <= 0:
		health = 0
	updateHealthUI()

func rangeTo(target:Node3D) -> float:
	var catheteX:float = pow(target.position.x - self.position.x, 2)
	var catheteY:float = pow(target.position.y - self.position.y, 2)
	var catheteZ:float = pow(target.position.z - self.position.z, 2)
	var distance:float = sqrt(catheteX+catheteY+catheteZ)
	return distance

func getIntersectionPoint() -> PhysicsRayQueryParameters3D:
	var position2D:Vector2 = get_viewport().get_mouse_position()
	var forwardTest:Vector3 = Vector3(-sin(neck.rotation.y), sin(camera.rotation.x), -cos(neck.rotation.y))
	var ray_query:PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(
						camera.project_ray_origin(position2D),
						camera.project_ray_origin(position2D) +
						forwardTest * 1000000)
	return ray_query 

func placeInFront(distanceFromFront:int) -> Vector3:
	return(Vector3(self.position.x - distanceFromFront*sin(neck.get_rotation().y), self.position.y + 8, 
									 self.position.z - distanceFromFront*cos(neck.get_rotation().y)))

func alignDashEffect() -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_fwd", "move_back")
	#print(input_dir)
	var inversed:int = 1
	print(1*sin(neck.get_rotation().y))
	($DashEffect as Node3D).rotation.y = neck.get_rotation().y
	if input_dir.y < 0:
		($DashEffect as Node3D).position = Vector3.ZERO
	elif input_dir.y == 0:
		if input_dir.x == 1:
			inversed = -1
	elif input_dir.y > 0:
		($DashEffect as Node3D).position.z -= 1*cos(neck.get_rotation().y) #Verifier comment faire fonctionner
		($DashEffect as Node3D).rotation.y = neck.get_rotation().y + 3.1416
		inversed = -1
	if input_dir.x == 1 or input_dir.x == -1:
		($DashEffect as Node3D).rotation.y = neck.get_rotation().y + (1.578*inversed)
	elif input_dir.x < 0:
		($DashEffect as Node3D).rotation.y += (0.7854*inversed)
	elif input_dir.x > 0:
		($DashEffect as Node3D).rotation.y -= (0.7854*inversed)
	($DashEffect as Node3D).visible = true
	for child in $DashEffect.get_children():
		(child as AnimatedSprite3D).play()
	
func _mvmt_effect_rotate() -> void:
	($MvmtEffect as MeshInstance3D).rotation.y -= 0.785
	($MvmtEffectTimer as Timer).start()

func _primary_fire() -> void:
	if primaryShootElement == manaType.LIGHTNING:
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Shooting_Right_Hand.png")
		shoot(LIGHTNING)
		($HandReset as Timer).wait_time = 0.5
		($HandReset as Timer).start()
	elif primaryShootElement == manaType.EARTH:
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Punch_Full.png")
		shoot(PUNCH)
		($HandReset as Timer).wait_time = 0.2
		($HandReset as Timer).start()
	elif primaryShootElement == manaType.WIND:
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Shooting_Right_Hand.png")
		windEnabled = true
		if windEnabled:
			shoot(WIND)
	elif primaryShootElement == manaType.ICE:
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Shooting_Right_Hand.png")
		shoot(PROJECTILE)
		($HandReset as Timer).wait_time = 0.2
		($HandReset as Timer).start()
	elif primaryShootElement == manaType.FIRE:
		($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Flick_Full.png")
		shoot(FIREBALL)
		($HandReset as Timer).wait_time = 0.3
		($HandReset as Timer).start()

func _secondary_fire() -> void:
	if secondaryShootElement == manaType.LIGHTNING:
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Secondary_Left_Hand.png")
		shoot(STORM)
		($LeftHandReset as Timer).wait_time = 0.5
		($LeftHandReset as Timer).start()
	elif secondaryShootElement == manaType.EARTH:
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Secondary_Left_Hand.png")
		shoot(EARTHQUAKE)
		($LeftHandReset as Timer).wait_time = 0.2
		($LeftHandReset as Timer).start()
	elif secondaryShootElement == manaType.WIND:
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Secondary_Left_Hand.png")
		shoot(TORNADO)
		($LeftHandReset as Timer).wait_time = 0.2
		($LeftHandReset as Timer).start()
	elif secondaryShootElement == manaType.ICE:
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Secondary_Left_Hand.png")
		shoot(WAVE)
		($LeftHandReset as Timer).wait_time = 0.2
		($LeftHandReset as Timer).start()
	elif secondaryShootElement == manaType.FIRE:
		($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Fire_Full.png")
		if manaChange(10, manaType.FIRE, fire_mana):
			flameEnabled = true
			if flameEnabled:
				shoot(FLAMETHROWER)

func _reset_hand() -> void:
	($Neck/Camera3D/RightHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Hand_Main.png")
	primaryShootReady = true

func _reset_left_hand() -> void:
	($Neck/Camera3D/LeftHand as Sprite2D).texture = load("res://Test_Assets/PlayerSprites/Hand_Main_Left.png")
	secondaryShootReady = true

func _on_dash_timer_timeout() -> void:
	isDashing = false
	slideSpeed = 7
	($DashEffect/TopRight as AnimatedSprite3D).stop()
	($DashEffect as Node3D).visible = false
	($DashEffect as Node3D).rotation = Vector3.ZERO
	($DashEffect as Node3D).position = Vector3.ZERO

func obsoleteCodeDONOTUSE() -> void:
	pass
#----Vollees de tests----
#---Earthquake Raycasting---
#print("Ray Origin: ", camera.project_ray_origin(position2D))
#print("Ray Normal: ", camera.project_ray_normal(position2D))
#print("Rotation: ", Vector3(-sin(neck.rotation.y), sin(camera.rotation.x), -cos(neck.rotation.y)))
#print("Collider: ", space_state.intersect_ray(ray_query).get("collider"))
#print("Camera rotation: ", camera.rotation)
#print("Neck rotation: ", neck.rotation)
#print("Forward Test: ", forwardTest)
#print(ray_query.from, " -> ", ray_query.to)
#print("Position d'envoi: ", self.position)
#print(space_state.intersect_ray(ray_query).get("position"))
#print("Position d'arrivee: ", camera.project_ray_origin(position2D) + forwardTest)

#----OBSOLETE CODE----
	#if direction != Vector3.ZERO:
	#	direction = direction.normalized()
	#Fireball Calc
	#elif fireballCharging:
		#((fakeFireball.get_node("MeshInstance3D") as MeshInstance3D).mesh as SphereMesh).radius += 
																#fireballChargeRate*delta
		#((fakeFireball.get_node("MeshInstance3D") as MeshInstance3D).mesh as SphereMesh).height = 
					#((fakeFireball.get_node("MeshInstance3D") as MeshInstance3D).mesh as SphereMesh).radius *2
		#if ((fakeFireball.get_node("MeshInstance3D") as MeshInstance3D).mesh as 
				#SphereMesh).radius > fireballMaxRadius:
			#((fakeFireball.get_node("MeshInstance3D") as MeshInstance3D).mesh as SphereMesh).radius = 
					#fireballMaxRadius
		#fakeFireball.position = Vector3(self.position.x - 1*sin(neck.get_rotation().y), self.position.y, 
									#self.position.z - 1*cos(neck.get_rotation().y))	
#--OLD MOVEMENT--
# We check for each move input and update the direction accordingly.
	#if Input.is_action_pressed("move_right"):
	#	direction.x += 1
	#if Input.is_action_pressed("move_left"):
	#	direction.x -= 1
	#if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
	#	direction.z += 1
	#if Input.is_action_pressed("move_fwd"):
	#	direction.z -= 1
	#if Input.is_action_just_pressed("primary_fire"):
		#shoot(direction)
		#var look_dir:Vector3 = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#var look_dir:Vector3 = (-neck.transform.basis.z).normalized()
		#shoot(look_dir)
	#--OLD LIGHTNING--
	#var space_state:PhysicsDirectSpaceState3D = get_world_3d().get_direct_space_state()
		#var ray_query:PhysicsRayQueryParameters3D = getIntersectionPoint()
		#if (space_state.intersect_ray(ray_query) != {}):
			#if manaChange(0, manaType.LIGHTNING, lightning_mana):
				#var hit_object:Node3D = space_state.intersect_ray(ray_query).get("collider")
				#var lightning:test_lightning = LIGHTNING.instantiate()
				#lightning.rotation = Vector3(sin(camera.rotation.x), neck.rotation.y, 90)
				#lightning.position = self.position
				#(lightning as test_lightning).distanceToTravel = rangeTo(hit_object)
				#lightning.target = hit_object
				#print(hit_object.global_position)
				#lightning.position = -transform.basis.z.normalized().z + (lightning.texture.get_size().x)/2
				#get_tree().current_scene.add_child(lightning)
