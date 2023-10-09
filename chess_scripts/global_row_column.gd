extends Node

var first_piece_node : String
var second_piece_node : String
var first_position : Vector2 = Vector2()
var second_position : Vector2 = Vector2()
var first_row
var first_col
var second_row
var second_col
var player_click = false
# Called when the node enters the scene tree for the first time.
func move_node():
	#get_node("/root/chess_script/Pieces/@Control@4").position = Vector2(0, 0)
	get_node(str(first_piece_node)).position = get_node(str(second_piece_node)).position
	
	
	get_node(str(first_piece_node) + "/TouchScreenButton").row = second_row
	get_node(str(first_piece_node) + "/TouchScreenButton").col = second_col
	
	#action_history.append((str(first_piece_node), get_node(str(first_piece_node)).position, str(second_piece_node), get_node(str(second_piece_node)).position))
	#pass
	
	
	#Fix new row and column when moved and hide old node
	
var action_history = []
func undo_move():
	
	pass
