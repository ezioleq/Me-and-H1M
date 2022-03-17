extends Area2D

export (PackedScene) var Effect

export var speed = 200
export var damage = 2
var is_from_player = false

func _ready():
	pass
	
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	var is_body_player = body.is_in_group("player")
	var is_body_enemy = body.is_in_group("enemy")

	if not is_from_player and is_body_player:
		# Damage player
		PlayersManager.damage(damage)
		destroy()
	elif is_from_player and is_body_player:
		# Player's bullet ignores other player
		pass
	elif not is_from_player and is_body_enemy:
		# Enemy's bullet ignores other enemy
		pass
	elif is_from_player and is_body_enemy:
		# Player's bullet damage enemy
		if body.has_method("damage"):
			body.damage(damage)
			destroy()
			pass
	else:
		destroy()

func destroy():
	var e = Effect.instance()
	e.position = position
	get_tree().root.get_child(0).add_child(e)
	self.queue_free()

func _on_Timer_timeout():
	queue_free()
	pass
