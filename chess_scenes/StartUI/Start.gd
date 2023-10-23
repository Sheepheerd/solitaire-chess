extends Control

var duration = 1  # The duration of the interpolation in seconds
var elapsed_time = 0
var starting_alpha = 0
var target_alpha = 1

#func _ready():
#	show()
func _process(delta):
	elapsed_time += delta
	if elapsed_time < duration:
		# Interpolate the alpha value from 0 to 1
		modulate.a = lerp(starting_alpha, target_alpha, elapsed_time / duration)
#	else:
#		# Ensure the final alpha value is exactly 1
#		modulate.a = target_alpha

