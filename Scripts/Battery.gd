extends Area2D

var player_in: bool = false
var using: bool = false

var timer = 0
export var time_to_pick = 2
export var energy_added = 6

func _ready():
	$ProgressBar.visible = false
	$ProgressBar.percent_visible = false
	$ProgressBar.max_value = time_to_pick * 100
	pass

func _process(delta):
	using = Input.is_action_pressed("p1_use") and player_in
	$ProgressBar.visible = using
	
	if using:
		timer += delta
		$ProgressBar.value = timer * 100
		if timer >= time_to_pick:
			if not PlayersManager.battery_dead:
				PlayersManager.drone_health += energy_added
			queue_free()
	else:
		timer = 0

func _on_Battery_body_entered(body):
	if body.is_in_group("player"):
		player_in = true
	pass

func _on_Battery_body_exited(body):
	if body.is_in_group("player"):
		player_in = false
	pass
