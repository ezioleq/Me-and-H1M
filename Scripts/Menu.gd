extends Node2D

export (PackedScene) var GameScene

func _ready():
	pass

func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	pass

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	pass

func _on_Play_pressed():
	get_tree().change_scene_to(GameScene)
	pass

func _on_Exit_pressed():
	get_tree().quit(0)
	pass
