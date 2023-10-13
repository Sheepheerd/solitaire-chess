extends TouchScreenButton


var selected = false
var board
var row
var col
var piece_name
var has_set_paths = false

#var which_selection: int
func _ready():
	board = get_parent().get_parent().board


	
func _on_pressed():
	await get_tree().create_timer(.1).timeout
	get_parent().get_parent().player_clicked = true
	global_row_column.player_click = false
	#if get_parent().get_parent().has_selected_piece_one == false:
	if get_parent().get_parent().player_clicked == true && global_row_column.player_click == false:
		if get_parent().get_parent().has_selected_piece_one == false:
			global_row_column.first_piece_node = get_parent().get_path()
			global_row_column.first_row = row
			global_row_column.first_col = col
			get_parent().get_parent().source_piece_name = piece_name
			get_parent().get_parent().source_row = row
			get_parent().get_parent().source_col = col
			#await get_tree().create_timer(.5).timeout
			get_parent().get_parent().has_selected_piece_one = true
			
		elif get_parent().get_parent().has_selected_piece_one == true:
			global_row_column.second_piece_node = get_parent().get_path()
			global_row_column.second_row = row
			global_row_column.second_col = col
			get_parent().get_parent().dest_row = row
			get_parent().get_parent().dest_col = col
			get_parent().get_parent().move_piece()
			if (get_parent().get_parent().move_fail == false):
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




func _on_released():
	pass # Replace with function body.
