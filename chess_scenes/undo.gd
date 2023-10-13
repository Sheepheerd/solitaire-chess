extends TouchScreenButton

var first_piece
var second_piece
var i = 0

func undo_move():
	if global_row_column.previous_node.size() > 0 and global_row_column.hidden_node.size() > 0:
		var pieceNodeName = global_row_column.previous_node[i]
		var hiddenNodeName = global_row_column.hidden_node[i]

		# Get references to the nodes
		first_piece = get_node(pieceNodeName)
		second_piece = get_node(hiddenNodeName)
		
		# Restore the position of the first piece to its previous position
		first_piece.position = global_row_column.previous_node_position[i]

		# Restore the row and column of the first piece
		var button = first_piece.get_node("TouchScreenButton")
		button.row = global_row_column.previous_node_row[i]
		button.col = global_row_column.previous_node_col[i]

		# Unhide the second piece
		second_piece.show()
		
		# Print the data for debugging (optional)
		
		
		# Remove the undone steps from the history lists
		global_row_column.previous_node.erase(i)
		global_row_column.hidden_node.erase(i)
		global_row_column.previous_node_position.erase(i)
		global_row_column.previous_node_row.erase(i)
		global_row_column.previous_node_col.erase(i)

		i += 1

