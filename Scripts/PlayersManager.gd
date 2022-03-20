extends Node

var score = 0

var mech_health = 300
var drone_health = 30
var drone_max_health = 30

var drone_mech_dist = 0
var max_drone_dist = 140
var lost_conn = false
var battery_dead = false

var poor_energy_timer = 0
export var energy_per_sec = 1
var energy_max = drone_health

var poor_score_timer = 0
export var score_per_sec = 1

var poor_lose_timer = 0
export var health_lose_per_sec = 15

var mech_pos = Vector2()

func _ready():
	pass

func _process(delta):
	poor_energy_timer += delta
	poor_score_timer += delta

	if poor_energy_timer >= energy_per_sec:
		drone_health -= 1
		poor_energy_timer = 0

	if poor_score_timer >= score_per_sec:
		score += 1
		poor_score_timer = 0

	if drone_health <= 0:
		battery_dead = true

	if drone_health > drone_max_health:
		drone_health = drone_max_health

		poor_lose_timer += delta
		if poor_lose_timer >= 1:
			mech_health -= health_lose_per_sec
			poor_lose_timer = 0

	if mech_health <= 0:
		end_game()

	pass

func end_game():
	print("Game Over!")
	pass

func damage(val):
	mech_health -= val
