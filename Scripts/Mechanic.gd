extends KinematicBody2D

enum Direction {
	UP = 0,
	DOWN = 180,
	LEFT = -90,
	RIGHT = 90
}

export var move_speed = 16
export var slow_down = 0.86
var velocity = Vector2()
var acceleration = Vector2()

export var direction = Direction.UP

func _ready():
	$Animator.play("idle_up")
	pass

func _process(delta):
	if PlayersManager.mech_dead:
		return

	var horizontal = Input.get_action_strength("p1_right") - Input.get_action_strength("p1_left")
	var vertical = Input.get_action_strength("p1_up") - Input.get_action_strength("p1_down")
	var dir = Vector2(horizontal, -vertical)

	if vertical > 0:
		direction = Direction.UP
	elif vertical < 0:
		direction = Direction.DOWN

	if horizontal > 0:
		direction = Direction.RIGHT
	elif horizontal < 0:
		direction = Direction.LEFT

	if dir.length() < 0.1:
		match direction:
			Direction.UP:
				$Animator.play("idle_up")
			Direction.DOWN:
				$Animator.play("idle_down")
			Direction.RIGHT:
				$Sprite.flip_h = false
				$Animator.play("idle_right")
			Direction.LEFT:
				$Sprite.flip_h = true
				$Animator.play("idle_right")
	else:
		match direction:
			Direction.UP:
				$Animator.play("walk_up")
			Direction.DOWN:
				$Animator.play("walk_down")
			Direction.RIGHT:
				$Sprite.flip_h = false
				$Animator.play("walk_right")
			Direction.LEFT:
				$Sprite.flip_h = true
				$Animator.play("walk_right")

	accelerate(dir.normalized() * move_speed)

	velocity += acceleration
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)

	velocity *= slow_down
	acceleration = Vector2.ZERO

	PlayersManager.mech_pos = position

	pass

func accelerate(dir):
	acceleration += dir
