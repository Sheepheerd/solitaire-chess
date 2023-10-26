extends Control

#var config
#func _ready():
#	config = ConfigFile.new()
#	var err = config.load("user://wins.cfg")
#
#
#
#func _on_pressed():
#	if config.get_value("tutorial", "has_played") == false:
#
#		get_tree().change_scene_to_file("res://chess_scenes/StartUI/how_to_play.tscn")
#	elif config.get_value("tutorial", "has_played") == true:
#		get_tree().change_scene_to_file("res://chess_scenes/StartUI/start_ui.tscn")
