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
var previous_node : Array
var previous_node_position = []
var previous_node_row = []
var previous_node_col = []
var hidden_node : Array
var max_undo_steps = 3  # Maximum number of steps to undo

# Called when the node enters the scene tree for the first time.
func move_node():
	previous_node.append(first_piece_node)
	hidden_node.append(second_piece_node)
	previous_node_position.append(get_node(str(first_piece_node)).position)
	previous_node_row.append(first_row)
	previous_node_col.append(first_col)
	get_node(str(first_piece_node)).position = get_node(str(second_piece_node)).position
	get_node(str(first_piece_node) + "/TouchScreenButton").row = second_row
	get_node(str(first_piece_node) + "/TouchScreenButton").col = second_col
	



var action_history = []

var i = 0
var first_piece
var second_piece
func undo_move():

	if previous_node.size() > 0 and hidden_node.size() > 0:

		get_parent().get_node("Pieces").undo_move()
		first_piece = get_node("\"" + previous_node[0] + "\"")
		second_piece = get_node("\"" + hidden_node[0] + "\"")

		# Restore the position of the first piece to its previous position
		first_piece.position = previous_node_position[0]

		# Restore the row and column of the first piece
		first_piece.get_node("TouchScreenButton").row = previous_node_row[0]
		first_piece.get_node("TouchScreenButton").col = previous_node_col[0]

		# Unhide the second piece
		second_piece.show()

		# Remove the undone steps from the history lists
		previous_node.erase(0)
		hidden_node.erase(0)
		previous_node_position.erase(0)
		previous_node_row.erase(0)
		previous_node_col.erase(0)

	i += 1
