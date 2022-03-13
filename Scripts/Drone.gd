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

func _ready():
	$Animator.play("Fly")
	pass

func _process(delta):
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

	accelerate(dir.normalized() * move_speed)

	velocity += acceleration
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)

	velocity *= slow_down
	acceleration = Vector2.ZERO

	pass

func accelerate(dir):
	acceleration += dir
