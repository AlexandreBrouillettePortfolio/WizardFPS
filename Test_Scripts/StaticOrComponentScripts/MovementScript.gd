class_name MovementScript

static func normalFall(fall_acceleration:float, target_velocity:Vector3, delta:float, maxFallSpeed:float) -> float:
	if target_velocity.y <= -maxFallSpeed:
		return -maxFallSpeed
	else:
		return target_velocity.y - (fall_acceleration * delta)

static func enemyFallOptions(target_velocity:Vector3, inTornado:bool, isOnGround:bool, fall_acceleration:float, _delta:float, maxFallSpeed:float) -> float:
	if inTornado:
		return 1 #Modifier par valeur de la tornade
	elif isOnGround:
		return 0
	else:
		return normalFall(fall_acceleration, target_velocity, _delta, maxFallSpeed)
		#target_velocity.y = target_velocity.y - (fall_acceleration * _delta)

static func rangeTo(from:Vector3, target:Vector3) -> float:
	var catheteX:float = pow(target.x - from.x, 2)
	var catheteY:float = pow(target.y - from.y, 2)
	var catheteZ:float = pow(target.z - from.z, 2)
	var distance:float = sqrt(catheteX+catheteY+catheteZ)
	return distance
