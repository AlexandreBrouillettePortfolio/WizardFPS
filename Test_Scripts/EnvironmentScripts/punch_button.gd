class_name punch_button extends activator

var isPunched:bool = false
var basePos:Vector3 = Vector3(0,0,0)

func _ready() -> void:
	basePos = global_position

func _on_area_entered(area: Area3D) -> void:
	if checkLegalButtonPress(area) and !isPunched:
		position += transform.basis.z * -0.1
		($PunchRegisterTimer as Timer).start()
		activate()

func checkLegalButtonPress(area:Area3D) -> bool:
	return area is test_punch or area is test_earthbox

func _on_punch_register_timer_timeout() -> void:
	print("Timer done")
	isPunched = true

func reset() -> void:
	deactivate()
	isPunched = false
	global_position = basePos
