class_name test_abstract_projectile extends Area3D

var direction:Vector3
var pPosition:Vector3
var angle:Vector3

func changeSpriteY() -> void:
	angle = getPlayerAngleY()
	var frame:int = 0
	if findPosition(angle.x)==1: #Front Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 1
			($AnimatedSprite3D as AnimatedSprite3D).frame = 2 #Back
			($AnimatedSprite3D as Node3D).rotation.x = 1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 8 #FrontBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 10 #BackTop
			($AnimatedSprite3D as Node3D).rotation.x = 2.3562 #135 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 7 #FrontTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 9 #BackBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
	elif findPosition(angle.x)==5: #Back Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 2
			($AnimatedSprite3D as AnimatedSprite3D).frame = 1 #Front
			($AnimatedSprite3D as Node3D).rotation.x = 1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 10 #BackTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 8 #FrontBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 9 #BackBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 7 #FrontTop
			($AnimatedSprite3D as Node3D).rotation.x = 2.3562 #135 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
	elif (findPosition(angle.x)==2 and !isOnRight(angle.z)): #FrontLeft Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 3
			($AnimatedSprite3D as AnimatedSprite3D).frame = 5 #BackLeft
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 1.5708 #90 deg
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 13 #FrontLeftBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 15 #BackTopLeft
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = 2.5307 #145 deg
			($AnimatedSprite3D as Node3D).rotation.z = 2.1817 #125 deg
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 11 #FrontLeftTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 17 #BackLeftBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.6632 #38 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0.9599 #55 deg
	elif (findPosition(angle.x)==2 and isOnRight(angle.z)): #FrontRight Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 4 
			($AnimatedSprite3D as AnimatedSprite3D).frame = 6 #Back Right
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = -1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 14 #FrontRightBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 18 #BackRightBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = -2.5307 #145 deg
			($AnimatedSprite3D as Node3D).rotation.z = -2.1817 #125 deg
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 12 #FrontRightTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 16 #BackRightTop
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = -0.6632 #38 deg
			($AnimatedSprite3D as Node3D).rotation.z = -0.9599 #55 deg
	elif findPosition(angle.x)==3: #Sides Switched
		($AnimatedSprite3D as AnimatedSprite3D).frame = 0
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as Node3D).rotation.x = 0
			($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
		elif findPosition(angle.y)==2:
			if isOnRight(angle.z):
				($AnimatedSprite3D as Node3D).rotation.x = 0
				($AnimatedSprite3D as Node3D).rotation.y = 0.7854 #45 deg
				($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
			else:
				($AnimatedSprite3D as Node3D).rotation.x = 0
				($AnimatedSprite3D as Node3D).rotation.y = 2.3562 #135 deg
				($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
		elif findPosition(angle.y)==4:
			if isOnRight(angle.z):
				($AnimatedSprite3D as Node3D).rotation.x = 0
				($AnimatedSprite3D as Node3D).rotation.y = 2.3562 #135 deg
				($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
			else:
				($AnimatedSprite3D as Node3D).rotation.x = 0
				($AnimatedSprite3D as Node3D).rotation.y = 0.7854 #45 deg
				($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
		else:
			($AnimatedSprite3D as Node3D).rotation.x = 0
			($AnimatedSprite3D as Node3D).rotation.y = 0
			($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
	elif (findPosition(angle.x)==4 and !isOnRight(angle.z)): #BackLeft Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 5
			($AnimatedSprite3D as AnimatedSprite3D).frame = 3 #FrontLeft
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = -1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = -1.5708 #90 deg
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 17 #BackLeftBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 11 #FrontLeftTop
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = -0.6632 #38 deg
			($AnimatedSprite3D as Node3D).rotation.z = -0.9599 #55 deg
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 15 #BackLeftTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 13 #FrontLeftBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = -2.5307 #145 deg
			($AnimatedSprite3D as Node3D).rotation.z = -2.1817 #125 deg
	elif (findPosition(angle.x)==4 and isOnRight(angle.z)): #BackRight Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 6
			($AnimatedSprite3D as AnimatedSprite3D).frame = 4 #FrontRight
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 1.5708 #90 deg
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 18 #BackRightBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 12 #FrontRightTop
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.6632 #38 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0.9599 #55 deg
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 16 #BackRightTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 14 #FrontRightBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.5411 #31 deg
			($AnimatedSprite3D as Node3D).rotation.y = 2.5307 #145 deg
			($AnimatedSprite3D as Node3D).rotation.z = 2.1817 #125 deg

func changeSpriteZ() -> void:
	angle = getPlayerAngleZ()
	var frame:int = 0
	if findPosition(angle.x)==1: #Front Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 1
			($AnimatedSprite3D as AnimatedSprite3D).frame = 2 #Back
			($AnimatedSprite3D as Node3D).rotation.x = 0.0 #Arrange pour direction en z
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 8 #FrontBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 10 #BackTop
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #Arrange pour direction en z
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 7 #FrontTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 9 #BackBottom
			($AnimatedSprite3D as Node3D).rotation.x = -0.7854 #Arrange pour direction en z
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
	elif findPosition(angle.x)==5: #Back Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 2
			($AnimatedSprite3D as AnimatedSprite3D).frame = 1 #Front
			($AnimatedSprite3D as Node3D).rotation.x = 0.0 #Arrange pour direction en z
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 10 #BackTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 8 #FrontBottom
			($AnimatedSprite3D as Node3D).rotation.x = -0.7854 #Arrange pour direction en z
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 9 #BackBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 7 #FrontTop
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #Arrange pour direction en z
			($AnimatedSprite3D as Node3D).rotation.y = 0.0
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
	elif (findPosition(angle.x)==2 and !isOnRight(angle.z)): #FrontLeft Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 3
			($AnimatedSprite3D as AnimatedSprite3D).frame = 5 #BackLeft
			($AnimatedSprite3D as Node3D).rotation.x = 0.0 
			($AnimatedSprite3D as Node3D).rotation.y = 0.7854 
			($AnimatedSprite3D as Node3D).rotation.z = 0 
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 13 #FrontLeftBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 15 #BackTopLeft
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 
			($AnimatedSprite3D as Node3D).rotation.y = 0.7854 
			($AnimatedSprite3D as Node3D).rotation.z = 0 
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 11 #FrontLeftTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 17 #BackLeftBottom
			($AnimatedSprite3D as Node3D).rotation.x = -0.7854 
			($AnimatedSprite3D as Node3D).rotation.y = 0.7854 
			($AnimatedSprite3D as Node3D).rotation.z = 0 
	elif (findPosition(angle.x)==2 and isOnRight(angle.z)): #FrontRight Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 4 
			($AnimatedSprite3D as AnimatedSprite3D).frame = 6 #Back Right
			($AnimatedSprite3D as Node3D).rotation.x = 0.0 
			($AnimatedSprite3D as Node3D).rotation.y = -0.7854 
			($AnimatedSprite3D as Node3D).rotation.z = 0.0
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 14 #FrontRightBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 18 #BackRightBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 
			($AnimatedSprite3D as Node3D).rotation.y = -0.7854 
			($AnimatedSprite3D as Node3D).rotation.z = 0 
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 12 #FrontRightTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 16 #BackRightTop
			($AnimatedSprite3D as Node3D).rotation.x = -0.7854 
			($AnimatedSprite3D as Node3D).rotation.y = -0.7854 
			($AnimatedSprite3D as Node3D).rotation.z = 0 
	elif findPosition(angle.x)==3: #Sides Switched
		($AnimatedSprite3D as AnimatedSprite3D).frame = 0
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as Node3D).rotation.x = 0
			($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0
		elif findPosition(angle.y)==2:
			if isOnRight(angle.z):
				($AnimatedSprite3D as Node3D).rotation.x = -0.7854
				($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
				($AnimatedSprite3D as Node3D).rotation.z = 0
			else:
				($AnimatedSprite3D as Node3D).rotation.x = 0.7854
				($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
				($AnimatedSprite3D as Node3D).rotation.z = 0
		elif findPosition(angle.y)==4:
			if isOnRight(angle.z):
				($AnimatedSprite3D as Node3D).rotation.x = 0.7854
				($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
				($AnimatedSprite3D as Node3D).rotation.z = 0
			else:
				($AnimatedSprite3D as Node3D).rotation.x = -0.7854
				($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
				($AnimatedSprite3D as Node3D).rotation.z = 0
		else:
			($AnimatedSprite3D as Node3D).rotation.x = 1.5708
			($AnimatedSprite3D as Node3D).rotation.y = 1.5708 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0
	elif (findPosition(angle.x)==4 and !isOnRight(angle.z)): #BackLeft Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 5
			($AnimatedSprite3D as AnimatedSprite3D).frame = 3 #FrontLeft
			($AnimatedSprite3D as Node3D).rotation.x = 0 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = -0.7854 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0 #90 deg
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 17 #BackLeftBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 11 #FrontLeftTop
			($AnimatedSprite3D as Node3D).rotation.x = -0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = -0.7854 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0 #90 deg
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 15 #BackLeftTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 13 #FrontLeftBottom
			($AnimatedSprite3D as Node3D).rotation.x = --0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = -0.7854 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0 #90 deg
	elif (findPosition(angle.x)==4 and isOnRight(angle.z)): #BackRight Switched
		if findPosition(angle.y)==3:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 6
			($AnimatedSprite3D as AnimatedSprite3D).frame = 4 #FrontRight
			($AnimatedSprite3D as Node3D).rotation.x = 0 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.7854 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0 #90 deg
		elif findPosition(angle.y)==2:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 18 #BackRightBottom
			($AnimatedSprite3D as AnimatedSprite3D).frame = 12 #FrontRightTop
			($AnimatedSprite3D as Node3D).rotation.x = -0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.7854 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0 #90 deg
		elif findPosition(angle.y)==4:
			($AnimatedSprite3D as AnimatedSprite3D).frame = 16 #BackRightTop
			($AnimatedSprite3D as AnimatedSprite3D).frame = 14 #FrontRightBottom
			($AnimatedSprite3D as Node3D).rotation.x = 0.7854 #45 deg
			($AnimatedSprite3D as Node3D).rotation.y = 0.7854 #90 deg
			($AnimatedSprite3D as Node3D).rotation.z = 0 #90 deg

func isOnRight(angleZ:float) -> bool:
	return angleZ > 0.0

func findPosition(angle:float) -> int:
	if angle >= 0.75: 
		return 1 #Front of vector
	elif 0.75 > angle and angle >= 0.25:
		return 2 #Angled Front of vector
	elif 0.25 > angle and angle >= -0.25:
		return 3 #Side of vector
	elif -0.25 > angle and angle >= -0.75:
		return 4 #Angled Back of vector
	elif angle < -0.75:
		return 5 #Back of vector
	return 0

func getPlayerAngleY() -> Vector3:
	var playerVector:Vector3 = pPosition.direction_to(position).normalized()
	return Vector3(playerVector.dot(direction), playerVector.dot(transform.basis.z), 
					playerVector.dot(transform.basis.x)) #x = Front, y = UP, z = Right

func getPlayerAngleZ() -> Vector3:
	var playerVector:Vector3 = pPosition.direction_to(position).normalized()
	return Vector3(playerVector.dot(direction), playerVector.dot(transform.basis.y), 
				playerVector.dot(transform.basis.x))
					#playerVector.dot(transform.basis.x)) #x = Front, y = UP, z = Right
	#return Vector3(playerVector.dot(direction), playerVector.dot(transform.basis.z), 
					#playerVector.dot(transform.basis.x)) #x = Front, y = UP, z = Right
 
