extends TextureProgress

func _ready():
	self.max_value = PlayersManager.mech_health
	pass

func _process(delta):
	self.value = PlayersManager.mech_health
	pass
