class_name test_float_crystal extends Area3D

var health:int = 15

func isDamaged(damage:int) -> void:
	health -= damage
	var tempTween:Tween = create_tween()
	tempTween.set_parallel(false)
	tempTween.tween_property($MeshInstance3D, "mesh:material:albedo_color", Color.RED, 0)
	tempTween.tween_property($MeshInstance3D, "mesh:material:albedo_color", Color.RED, 0.15)
	tempTween.tween_property($MeshInstance3D, "mesh:material:albedo_color", Color.WHITE, 0)
	if health <= 0:
		(get_node("..") as test_float_platform).fall()
		queue_free()
