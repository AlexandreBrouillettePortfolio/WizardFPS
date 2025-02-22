class_name activator extends Area3D

@export var activatableList:Array[activatable]

func activate() -> void:
	for thing in activatableList:
		(thing as activatable).activate()

func deactivate() -> void:
	for thing in activatableList:
		(thing as activatable).deactivate()
