extends Area2D

export var speed = 200
var is_from_player = false

func _ready():
	pass
	
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	var is_body_player = body.is_in_group("player")

	if not is_from_player and is_body_player:
		# Damage player
		queue_free()
	elif is_from_player and is_body_player:
		pass

func _on_Timer_timeout():
	queue_free()
	pass
