extends Node2D

export (PackedScene) var GameScene

func _ready():
	PlayersManager.set_script(null)
	PlayersManager.set_script(preload("res://Scripts/PlayersManager.gd"))
	pass

func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	pass

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	pass

func _on_Play_pressed():
	var s = GameScene.instance()
	get_tree().root.add_child(s)
	get_tree().change_scene_to(s)
	pass

func _on_Exit_pressed():
	get_tree().quit(0)
	pass
