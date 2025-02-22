extends Area3D

var ttl:float = 0.5 #time to live en secondes

func _physics_process(delta: float) -> void:
	ttl -= delta
	if (ttl <= 0):
		queue_free()

func _on_body_entered(body: Node3D) -> void: #CHANGER LE ENEMY AI AVEC SUPER DE BASE CLASS QUI PERMET MVMT
	pass # Replace with function body.
