class_name reverse_stone_door extends stone_door

func _physics_process(delta: float) -> void:
	if !activated and deltaY < (($MeshInstance3D as MeshInstance3D).mesh as BoxMesh).size.y*0.7*self.scale.y:
		deltaY += delta * self.scale.y
		position.y += delta * self.scale.y
	if activated and deltaY > 0:
		deltaY -= delta
		position.y -= delta
	if deltaY <= 0:
		deltaY = 0
	if deltaY >= (($MeshInstance3D as MeshInstance3D).mesh as BoxMesh).size.y*0.7*self.scale.y:
		deltaY = (($MeshInstance3D as MeshInstance3D).mesh as BoxMesh).size.y*0.7*self.scale.y
