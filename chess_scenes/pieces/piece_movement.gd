extends TouchScreenButton


var selected = false
var board
var row
var col
var piece_name
#var which_selection: int
func _ready():
	board = get_parent().get_parent().board
	print(row)
	print(col)
	
func _on_pressed():
	get_parent().get_parent().player_clicked = true
	#if get_parent().get_parent().has_selected_piece_one == false:
	if get_parent().get_parent().player_clicked == true:
		if get_parent().get_parent().has_selected_piece_one == false:
			get_parent().get_parent().source_piece_name = piece_name
			get_parent().get_parent().source_row = row
			get_parent().get_parent().source_col = col
			await get_tree().create_timer(.5).timeout
			get_parent().get_parent().has_selected_piece_one = true
			print(get_parent().get_parent().source_row)
			print(get_parent().get_parent().source_col)
		elif get_parent().get_parent().has_selected_piece_one == true:
			get_parent().get_parent().dest_row = row
			get_parent().get_parent().dest_col = col
			get_parent().get_parent().move_piece()
			await get_tree().create_timer(.5).timeout
			get_parent().get_parent().has_selected_piece_one = false
			print(get_parent().get_parent().dest_row)
			print(get_parent().get_parent().dest_col)
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
	#selected = false
	pass
			# Place the piece on the grid here based on chess rules

	
func _process(delta):
	pass


