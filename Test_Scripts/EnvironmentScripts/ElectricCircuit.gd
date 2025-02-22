class_name electricCircuit extends Area3D

var electrified:bool = false

func electrify() -> void:
	if electrified:
		return
	#print("Circuit Got Electrified")
	electrified = true
	for collision in (self as Area3D).get_overlapping_areas():
		print(collision.name)
		if collision is electricCircuit:
			if !(collision as electricCircuit).electrified:
				(collision as electricCircuit).electrify()
		if collision is electricSwitch:
			(collision as electricSwitch).connectionActive()
		if collision is pillarSwitch:
			#print("pillarSwitch electrifying")
			(collision as pillarSwitch).electrify()
	($OmniLight3D as OmniLight3D).visible = true
	#($MeshInstance3D2 as MeshInstance3D).visible = true

func depower() -> void:
	if !electrified:
		return
	#print("Circuit Got Depowered")
	electrified = false
	for collision in (self as Area3D).get_overlapping_areas():
		if collision is electricCircuit:
			if (collision as electricCircuit).electrified:
				(collision as electricCircuit).depower()
		if collision is electricSwitch:
			(collision as electricSwitch).connectionInactive()
	($OmniLight3D as OmniLight3D).visible = false
	#($MeshInstance3D2 as MeshInstance3D).visible = false
