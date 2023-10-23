extends TouchScreenButton


var selected = false
var board
var row
var col
var piece_name
var has_set_paths = false
var duration = 0.5  # The duration of the interpolation in seconds
var elapsed_time = 0
var starting_alpha = 0
var target_alpha = 1
var tween
var is_breathing = false
func _process(delta):
	elapsed_time += delta
	if elapsed_time < duration:
		# Interpolate the alpha value from 0 to 1
		modulate.a = lerp(starting_alpha, target_alpha, elapsed_time / duration)
	else:
		# Ensure the final alpha value is exactly 1
		modulate.a = target_alpha
#var which_selection: int
func _ready():


	#tween = get_tree().create_tween()
	board = get_parent().get_parent().board

	
func _on_pressed():
	await get_tree().create_timer(.1).timeout
	get_parent().get_parent().player_clicked = true
	global_row_column.player_click = false
	#if get_parent().get_parent().has_selected_piece_one == false:
	if get_parent().get_parent().player_clicked == true && global_row_column.player_click == false:
		if get_parent().get_parent().has_selected_piece_one == false:
			is_breathing = true
			piece_breath()
			global_row_column.first_piece_node = get_parent().get_path()

			global_row_column.first_row = row
			global_row_column.first_col = col
			get_parent().get_parent().source_piece_name = piece_name
			get_parent().get_parent().source_row = row
			get_parent().get_parent().source_col = col
			#await get_tree().create_timer(.5).timeout
			get_parent().get_parent().has_selected_piece_one = true
			
		elif get_parent().get_parent().has_selected_piece_one == true:
			get_node(global_row_column.first_piece_node).get_node("TouchScreenButton").is_breathing = false

			#get_node(global_row_column.first_piece_node).get_node("TouchScreenButton").piece_pop()
			global_row_column.second_piece_node = get_parent().get_path()
			global_row_column.second_row = row
			global_row_column.second_col = col
			get_parent().get_parent().dest_row = row
			get_parent().get_parent().dest_col = col
			get_parent().get_parent().move_piece()
			if (get_parent().get_parent().move_fail == false):
				get_node(global_row_column.first_piece_node).get_node("TouchScreenButton").piece_breath()
				has_set_paths = true
				if has_set_paths:
					get_parent().get_parent().get_parent().get_node("Pieces").fill_empty_spots()
					global_row_column.move_node()
					has_set_paths = false
				get_parent().get_parent().has_selected_piece_one = false
				#get_parent().queue_free()
				get_parent().hide()
				#await get_tree().create_timer(.5).timeout
			else:
				get_node(global_row_column.first_piece_node).get_node("TouchScreenButton").kill_tween()
				get_node(global_row_column.first_piece_node).scale = Vector2(1, 1)
				get_parent().get_parent().move_fail = false
				get_parent().get_parent().has_selected_piece_one = false
			global_row_column.player_click = true
			return
			#await get_tree().create_timer(.5).timeout
			#get_parent().get_parent().player_clicked = false
#func piece_selected(which_selection):
#	match which_selection:
#		1:
#			get_parent().get_parent().has_selected_piece_one = true
#		2:
#			get_parent().get_parent().has_selected_piece_one = false
#


func piece_breath():
	if is_breathing == true:
		#if tween:
			#tween.kill()
			#
			#print(tween)
		tween = create_tween()
		tween.tween_property(get_parent(), "scale", Vector2(1.3, 1.3), 0.5)
		tween.tween_property(get_parent(), "scale", Vector2(1, 1), 0.5)
		tween.set_loops()
	if is_breathing == false:
			tween.kill()
			tween = create_tween()
			get_parent().scale = Vector2(1, 1)
			tween.tween_property(get_parent(), "scale", Vector2(1.1, 1.1), 0.1)
			tween.tween_property(get_parent(), "scale", Vector2(1, 1), 0.1)
			#tween.kill()
	
func kill_tween():
	tween.stop()


#func piece_pop():
#	tween = create_tween()
#	tween.tween_property(get_parent(), "scale", Vector2(1.3, 1.3), 0.9)
#	tween.tween_property(get_parent(), "scale", Vector2(1, 1), 0.9)

		

func _on_released():
	pass # Replace with function body.
