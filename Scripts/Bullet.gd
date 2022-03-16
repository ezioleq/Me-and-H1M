extends Area2D

export var speed = 200

func _ready():
	pass
	
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	queue_free()
	pass

func _on_Timer_timeout():
	queue_free()
	pass
