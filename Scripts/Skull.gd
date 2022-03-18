extends Sprite

func _ready():
	visible = false
	pass

func _process(delta):
	if PlayersManager.battery_dead:
		$Animator.play("Scaling")
		visible = true
	pass
