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
var previous_node = []
var previous_node_position = []
var previous_node_row = []
var previous_node_col = []
var hidden_node = []
var max_undo_steps = 3  # Maximum number of steps to undo

# Called when the node enters the scene tree for the first time.
func move_node():
	get_node(str(first_piece_node)).position = get_node(str(second_piece_node)).position
	get_node(str(first_piece_node) + "/TouchScreenButton").row = second_row
	get_node(str(first_piece_node) + "/TouchScreenButton").col = second_col

	previous_node.append(first_piece_node)
	hidden_node.append(second_piece_node)
	previous_node_position.append(get_node(str(first_piece_node)).position)
	previous_node_row.append(first_row)
	previous_node_col.append(first_col)

var action_history = []

func undo_move():
	var num_steps_to_undo = min(previous_node.size(), max_undo_steps)

	for i in range(num_steps_to_undo):
		var first_piece = get_node(str(previous_node[i]))
		var second_piece = get_node(str(hidden_node[i]))

		# Restore the position of the first piece to its previous position
		first_piece.position = previous_node_position[i]

		# Restore the row and column of the first piece
		first_piece.get_node("TouchScreenButton").row = previous_node_row[i]
		first_piece.get_node("TouchScreenButton").col = previous_node_col[i]

		# Unhide the second piece
		second_piece.show()

	# Remove the undone steps from the history lists
	for i in range(num_steps_to_undo):
		previous_node.erase(0)
		hidden_node.erase(0)
		previous_node_position.erase(0)
		previous_node_row.erase(0)
		previous_node_col.erase(0)
