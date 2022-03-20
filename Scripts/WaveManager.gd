extends Node2D

export (PackedScene) var Enemy

var current_wave = 0
var timer = 0
var wave_length = 0
var current_enemies_count = 0

export var spawn_dist = 200
export var spawn_bias = 100

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	pass

func _process(delta):
	timer += delta

	if timer >= wave_length:
		new_wave()
		spawn_enemies(current_enemies_count)
		current_wave += 1
		timer = 0

	pass

func new_wave():
	var enemies = int(round(current_wave * 0.75) + round(rng.randf())) - int(
		current_wave - rng.randf_range(0, current_wave * (current_wave % 3) * rng.randf())
	)
	var duration = int(enemies * 1.25) + rng.randi_range(0, 4)

	current_enemies_count = enemies
	wave_length = duration
	pass

func spawn_enemy(pos: Vector2):
	var e = Enemy.instance()
	e.position = pos
	get_tree().root.get_child(1).add_child(e)
	pass

func spawn_enemies(count):
	for i in range(count):
		var dist = spawn_dist + rng.randi_range(-spawn_bias, spawn_bias)
		var dir = Vector2(
			rng.randf_range(-1, 1),
			rng.randf_range(-1, 1)
		).normalized()
		var pos = dir * dist

		spawn_enemy(pos)
	pass
