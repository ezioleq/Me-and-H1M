extends Label

func _process(delta):
	self.text = str(PlayersManager.score)
	pass
