extends Node2D

export (PackedScene) var Enemy

func _ready():
	$Animator.play("Spawn")
	pass

func _on_Timer_timeout():
	var e = Enemy.instance()
	e.position = position
	get_tree().root.get_child(0).add_child(e)
	pass


func _on_DestroyTimer_timeout():
	queue_free()
	pass
