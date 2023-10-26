extends Control

var duration = .5  # The duration of the interpolation in seconds
var elapsed_time = 0
var starting_alpha = 0
var target_alpha = 1
var breath = false
var duration2 = .5
var elapsed_time_2 = 0

var config
func _ready():
	config = ConfigFile.new()
	var err = config.load("user://wins.cfg")
		
func _process(delta):
	if breath == false:
		get_tree().create_timer(1).timeout.connect(change)
		elapsed_time += delta
		if elapsed_time < duration:
			# Interpolate the alpha value from 0 to 1
			modulate.a = lerp(starting_alpha, target_alpha, elapsed_time / duration)
			


	if breath == true:
		elapsed_time_2 += delta
		if elapsed_time_2 < duration2:
			# Interpolate the alpha value from 0 to 1
			modulate.a = lerp(target_alpha, starting_alpha, elapsed_time_2 / duration2)
		else:
			# Ensure the final alpha value is exactly 1
			modulate.a = starting_alpha
			if config.get_value("tutorial", "has_played") == null:

				get_tree().change_scene_to_file("res://chess_scenes/StartUI/how_to_play.tscn")
			elif config.get_value("tutorial", "has_played") == true:
				get_tree().change_scene_to_file("res://chess_scenes/StartUI/start_ui.tscn")

func change():

	breath = true
