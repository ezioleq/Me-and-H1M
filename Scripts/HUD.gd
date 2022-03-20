extends Control

func _ready():
	pass

func _process(delta):
	if PlayersManager.mech_dead:
		visible = false
