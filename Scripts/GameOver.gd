extends Control

var score = 0

var shown = false

func _ready():
	visible = false
	pass

func _process(delta):
	if PlayersManager.mech_dead and not shown:
		show()
		shown = true

func _on_Replay_pressed():
	get_tree().root.get_child(1).queue_free()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	pass

func show():
	score = PlayersManager.score
	$Score.text = str(score)
	visible = true
