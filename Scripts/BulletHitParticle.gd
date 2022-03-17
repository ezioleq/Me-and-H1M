extends CPUParticles2D

func _ready():
	self.emitting = true
	pass

func _on_Timer_timeout():
	queue_free()
	pass
