extends Area3D

func electrify() -> void:
	for collision in (self as Area3D).get_overlapping_areas():
		if collision is electricCircuit:
			if !(collision as electricCircuit).electrified:
				(collision as electricCircuit).electrify()
		if collision is electricSwitch:
			(collision as electricSwitch).connectionActive()
	($OmniLight3D as OmniLight3D).visible = true

func _on_timer_timeout() -> void:
	electrify()
