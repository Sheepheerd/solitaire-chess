extends TouchScreenButton


var selected = false

func _on_pressed():
	selected = true
	
func _on_released():
	#selected = false
	pass
			# Place the piece on the grid here based on chess rules

func _process(delta):
	if selected:
		position = get_global_mouse_position()
	# Pawn Movement
#	if is_in_group("Pawn"):
#		if row == 0:  # If the pawn reaches the last row, it cannot move further
#			return False
#		if col > 0 and board[row-1][col-1] == 'P':
#			return True
#		if col < array_size - 1 and board[row-1][col+1] == 'P':
#			return True
#
#	# Rook Movement
#	if is_in_group("Rook"):
#		if any(board[row][i] != ' ' for i in range(array_size) if i != col):
#			return True
#		if any(board[i][col] != ' ' for i in range(array_size) if i != row):
#			return True
#
#	# Bishop Movement
#	if is_in_group("Bishop"):
#		if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col-1, -1, -1))):
#			return True
#		if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col+1, array_size))):
#			return True
#		if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col-1, -1, -1))):
#			return True
#		if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col+1, array_size))):
#			return True
#
#	# Knight Movement
#	if is_in_group("Knight"):
#		knight_moves = [
#			(row-2, col-1), (row-2, col+1),
#			(row-1, col-2), (row-1, col+2),
#			(row+1, col-2), (row+1, col+2),
#			(row+2, col-1), (row+2, col+1)
#		]
#		return any(0 <= i < array_size and 0 <= j < array_size and board[i][j] != ' ' for i, j in knight_moves)
#
#	# Queen Movement (Combining Rook and Bishop)
#	if is_in_group("Queen"):
#		if any(board[row][i] != ' ' for i in range(array_size) if i != col):
#			return True
#		if any(board[i][col] != ' ' for i in range(array_size) if i != row):
#			return True
#		if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col-1, -1, -1))):
#			return True
#		if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col+1, array_size))):
#			return True
#		if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col-1, -1, -1))):
#			return True
#		if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col+1, array_size))):
#			return True
#
#	# King Movement
#	if is_in_group("King"):
#		king_moves = [
#			(row-1, col-1), (row-1, col), (row-1, col+1),
#			(row, col-1), (row, col+1),
#			(row+1, col-1), (row+1, col), (row+1, col+1)
#		]
#		return any(0 <= i < array_size and 0 <= j < array_size and board[i][j] != ' ' for i, j in king_moves)



