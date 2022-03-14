extends Camera2D

onready var drone = $"../Drone"
onready var mech = $"../Mechanic"

var bounding_box = Rect2()

func _ready():
	pass

func _process(delta):
	bounding_box.position.x = (drone.position.x + mech.position.x) / 2
	bounding_box.position.y = (drone.position.y + mech.position.y) / 2
	bounding_box.size.x = (mech.position.x - drone.position.x)
	bounding_box.size.y = (mech.position.y - drone.position.y)
	bounding_box.position.x = bounding_box.position.x - bounding_box.size.x / 2
	bounding_box.position.y = bounding_box.position.y - bounding_box.size.y / 2
	update()
	
	pass
	
func _draw():
	if OS.is_debug_build():
		draw_rect(bounding_box, Color.hotpink)
	pass
