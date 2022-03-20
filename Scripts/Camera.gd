extends Camera2D

onready var drone = $"../Drone"
onready var mech = $"../Mechanic"

export var font = preload("res://Fonts/Roboto-Regular.tres")

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

	if Input.is_action_just_released("ui_cancel"):
		get_tree().root.get_child(1).queue_free()
		get_tree().change_scene("res://Scenes/Menu.tscn")

	update()
	pass

func _draw():
	var color = Color.white if not PlayersManager.lost_conn else Color.orange
	
	if PlayersManager.battery_dead:
		color = Color.indianred
	
	var mech_offset = mech.position + Vector2(0, -4)

	draw_line(mech_offset, drone.position, Color.black, 3, true)
	draw_line(mech_offset, drone.position, color, 1.2, true)
	
	if not PlayersManager.battery_dead:
		draw_string(font, center + Vector2(0, font.size), "%sm" % float(round( PlayersManager.drone_mech_dist) / 10), color)

	pass
