class_name test_lightning extends Sprite3D

var ttl:float = 0.2 #time to live en secondes
var target:Node3D
var distanceToTravel:float
var strength:int = 10

func _enter_tree() -> void:
	self.region_rect.size = Vector2(distanceToTravel*100, 100)
	self.offset = Vector2((distanceToTravel*100)/2, 0)
	#print(self.region_rect.size)
	strike(target)

func _ready() -> void:
	print(distanceToTravel)
	if (distanceToTravel < 15):
		#(($GPUParticles3D as GPUParticles3D).material_overlay as ShaderMaterial).set_shader_parameter("DistanceToTarget", distanceToTravel)
		((($GPUParticles3D as GPUParticles3D).draw_pass_1 as ArrayMesh).surface_get_material(0) as ShaderMaterial).set_shader_parameter("DistanceToTarget", distanceToTravel)
	if (distanceToTravel > 15):
		($Extension as Node3D).visible = true

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func strike(cible:Node3D) -> void:
	if cible is test_enemy:
		(cible as test_enemy).isDamaged(strength, 0)
	elif cible is test_earthwall:
		(cible as test_earthwall).electrify()
	elif cible is test_float_crystal:
		(cible as test_float_crystal).isDamaged(5)
