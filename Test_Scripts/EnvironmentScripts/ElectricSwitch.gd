class_name electricSwitch extends activator

var electified:bool = false
@export var connections:int = 0
var activeConnections:int = 0

func connectionActive() -> void:
	activeConnections += 1
	#print("Switch Got Electrified")
	if activeConnections == connections:
		illuminate(true)
		activate()

func connectionInactive() -> void:
	activeConnections -= 1
	#print("Switch Got Depowered")
	illuminate(false)
	deactivate()

func illuminate(switch:bool) -> void:
	($OmniLight3D as OmniLight3D).visible = switch
