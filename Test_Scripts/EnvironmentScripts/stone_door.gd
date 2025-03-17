class_name stone_door extends activatable

var deltaY:float = 0

func activate() -> void:
	print((($MeshInstance3D as MeshInstance3D).mesh as BoxMesh).size.y*self.scale.y)
	activated = true
	
func deactivate() -> void:
	activated = false

func _physics_process(delta: float) -> void:
	if activated and deltaY < (($MeshInstance3D as MeshInstance3D).mesh as BoxMesh).size.y*0.7*self.scale.y:
		deltaY += delta * self.scale.y
		position.y += delta * self.scale.y
	if !activated and deltaY > 0:
		deltaY -= delta
		position.y -= delta
	if deltaY <= 0:
		deltaY = 0
	if deltaY >= (($MeshInstance3D as MeshInstance3D).mesh as BoxMesh).size.y*0.7*self.scale.y:
		deltaY = (($MeshInstance3D as MeshInstance3D).mesh as BoxMesh).size.y*0.7*self.scale.y
