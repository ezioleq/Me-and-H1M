extends KinematicBody2D

export (PackedScene) var Bullet

var rng = RandomNumberGenerator.new()

export var health = 10

export var shoot_dist = 60
export var shoot_rate = 1
export var shoot_bias = 0.25
var poor_shoot_timer = 0

var move_speed = 0
export var max_speed = 12
export var min_speed = 4

var stop_dist = 0
export var min_stop_dist = 70
export var max_stop_dist = 160

export var slow_down = 0.93
var velocity = Vector2()
var acceleration = Vector2()

var dist_to_player = 0

func _ready():
	rng.randomize()
	$Animator.play("Fly")
	move_speed = rng.randi_range(min_speed, max_speed)
	stop_dist = rng.randi_range(min_stop_dist, max_stop_dist)
	shoot_rate += rng.randf_range(-shoot_bias, shoot_bias)
	pass

func _process(delta):
	poor_shoot_timer += delta

	dist_to_player = position.distance_to(PlayersManager.mech_pos)
	look_at(PlayersManager.mech_pos)

	if dist_to_player > stop_dist:
		var vel = global_position.direction_to(PlayersManager.mech_pos)
		accelerate(vel * move_speed)

	velocity += acceleration
	move_and_collide(velocity * delta)

	velocity *= slow_down
	acceleration = Vector2.ZERO

	if poor_shoot_timer >= shoot_rate:
		shoot()
		poor_shoot_timer = 0

	if health <= 0:
		destroy()

	pass

func accelerate(dir):
	acceleration += dir

func shoot():
	var b = Bullet.instance()
	owner.add_child(b)
	b.position = self.global_position
	b.rotation = rotation
	$ShootPlayer.play()
	pass

func damage(val):
	health -= val

func destroy():
	queue_free()
	pass
