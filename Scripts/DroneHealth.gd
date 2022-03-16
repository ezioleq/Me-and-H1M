extends TextureProgress

func _ready():
	self.max_value = PlayersManager.drone_health
	pass

func _process(delta):
	self.value = PlayersManager.drone_health
	pass
