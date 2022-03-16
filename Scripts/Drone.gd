extends KinematicBody2D

enum Direction {
	UP = 0,
	DOWN = 180,
	LEFT = -90,
	RIGHT = 90
}

export var move_speed = 20
export var rotate_speed = 10
export var slow_down = 0.93
var velocity = Vector2()
var acceleration = Vector2()

export var direction = Direction.UP

onready var mech = $"../Mechanic"

func _ready():
	$Animator.play("Fly")
	pass

func _process(delta):
	if PlayersManager.battery_dead:
		return
	
	var horizontal = Input.get_action_strength("p2_right") - Input.get_action_strength("p2_left")
	var vertical = Input.get_action_strength("p2_up") - Input.get_action_strength("p2_down")
	var dir = Vector2(horizontal, -vertical)

	if vertical > 0:
		direction = Direction.UP
	elif vertical < 0:
		direction = Direction.DOWN

	if horizontal > 0:
		direction = Direction.RIGHT
	elif horizontal < 0:
		direction = Direction.LEFT

	$Sprite.rotation_degrees = lerp(
		$Sprite.rotation_degrees,
		direction,
		rotate_speed * delta
	);

	var dist = position.distance_to(mech.position)
	PlayersManager.drone_mech_dist = dist

	if dist < PlayersManager.max_drone_dist:
		PlayersManager.lost_conn = false
		accelerate(dir.normalized() * move_speed)
	else:
		PlayersManager.lost_conn = true

	velocity += acceleration
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)

	velocity *= slow_down
	acceleration = Vector2.ZERO

	pass

func accelerate(dir):
	acceleration += dir
