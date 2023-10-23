extends Label

var duration = 1  # The duration of the interpolation in seconds
var elapsed_time = 0
var starting_alpha = 0
var target_alpha = 1
var breath = false
var duration2 = 1
var elapsed_time_2 = 0
var timer
var timer_start = false
func _ready():
	timer = $Timer
	
func _process(delta):
	await get_tree().create_timer(1.3).timeout
	if breath == false:
		elapsed_time_2 = 0
		if timer_start == false:
			timer.start()
			timer_start = true
		elapsed_time += delta
		if elapsed_time < duration:
			# Interpolate the alpha value from 0 to 1
			modulate.a = lerp(target_alpha, starting_alpha, elapsed_time / duration)
			


	if breath == true:
		elapsed_time = 0
		elapsed_time_2 += delta
		if elapsed_time_2 < duration2:
			# Interpolate the alpha value from 0 to 1
			modulate.a = lerp(starting_alpha, target_alpha, elapsed_time_2 / duration2)
		else:
			# Ensure the final alpha value is exactly 1
			breath = false


func change():
	timer_start = false
	breath = true
