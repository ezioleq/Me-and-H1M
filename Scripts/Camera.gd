extends Camera2D

onready var drone = $"../Drone"
onready var mech = $"../Mechanic"

export var camera_speed = 4.5
export var dist = 0
export var min_zoom_dist = 0.75
export var max_zoom_dist = 330

var bounding_box = Rect2()
var center = Vector2()

func _ready():
	pass

func _process(delta):
	bounding_box.size = (mech.position - drone.position)
	bounding_box.position = (drone.position + mech.position) / 2 - bounding_box.size / 2

	center = bounding_box.position + bounding_box.size / 2

	self.offset = lerp(self.offset, center, camera_speed * delta)
	
	dist = drone.position.distance_to(mech.position) / max_zoom_dist
	var zoom_factor = min_zoom_dist + (1 * dist)
	self.zoom = Vector2(zoom_factor, zoom_factor);

	update()
	pass

func _draw():
	if OS.is_debug_build():
		draw_rect(bounding_box, Color.hotpink, false)
		draw_line(mech.position, drone.position, Color.white, 1.2, true)
		draw_circle(center, 3, Color.aqua)
	pass