extends Node2D


var num_pieces = 0
var array_size = 4

# Define the available chess pieces
var available_pieces = ['K', 'P', 'R', 'B', 'B', 'N', 'N', 'P', 'P']

var difficulty = "easy"
var board = []
var row
var col
var initial_piece
func _ready():
	if difficulty == "easy":
		num_pieces = 6
	elif difficulty == "medium":
		num_pieces = 5
	elif difficulty == "hard":
		num_pieces = 8

	for _x in range(array_size):
		var row : Array = []
		for _y in range(array_size):
			row.append(' ')
		board.append(row)
	# Place the initial piece on the board
	randomize()
	available_pieces.shuffle()
	initial_piece = available_pieces[num_pieces - 1]
	available_pieces.erase(initial_piece)
	#available_pieces = available_pieces.resize(5)
	print(available_pieces)
	row = randi() % (array_size - 1)
	col = randi() % (array_size - 1)
	board[row][col] = initial_piece

	# Place the remaining pieces on the board


# Place the initial piece on the board
#	#initial_piece = available_pieces[randi() % available_pieces.size()]
#	print("Initial Piece:", initial_piece)
#	available_pieces.erase(initial_piece)
#	randomize()
#	available_pieces.shuffle()

	# Place the remaining pieces on the board
	place_remaining_pieces(initial_piece)

	for i in range(board.size()):
		var row_str = ''
		for j in range(board[i].size()):
			var cell = board[i][j]
			row_str += (str(cell if cell != ' ' else '.')) + ' '
		print(row_str)
# Function to check if a piece can be placed at a given position
func is_valid_move(row, col, piece):
	# Check if the position is already occupied
	if board[row][col] != ' ':
		return false
	
	# Check if the piece can capture any other piece
	for i in range(array_size):
		for j in range(array_size):
			if board[i][j] != ' ':
				if piece == 'K' and (abs(row - i) <= 1 and abs(col - j) <= 1):
					return true
				elif piece == 'Q' and (row == i or col == j or abs(row - i) == abs(col - j)):
					return true
				elif piece == 'R' and (row == i or col == j):
					return true
				elif piece == 'B' and abs(row - i) == abs(col - j):
					return true
				elif piece == 'N' and ((abs(row - i) == 2 and abs(col - j) == 1) or (abs(row - i) == 1 and abs(col - j) == 2)):
					return true
				elif piece == 'P' and (row == i + 1 and abs(col - j) == 1):
					return true

	return false

# Function to place the remaining pieces on the board
# Function to place the remaining pieces on the board
func place_remaining_pieces(initial_piece):
	for i in range(1, num_pieces):
		var placed = false
		while not placed:
			row = randi() % (array_size - 1)
			col = randi() % (array_size - 1)
			var piece = available_pieces[i]
			var original_row = row
			var original_col = col
			var found_valid_move = false
			
			if i == 1:
				# If the first piece is a Knight (N), the second piece must also be a Knight
				if initial_piece == 'N':
					piece = 'N'
				# If the first piece is a Rook (R), the second piece can be a Rook or a King
				elif initial_piece == 'R':
					var r_k_array = ['R', 'K']
					piece = r_k_array[randi() % r_k_array.size()]
				# If the first piece is a Bishop (B), the second piece can be a Bishop, Pawn, or King
				elif initial_piece == 'B':
					var b_p_k_array = ['B', 'P', 'K']
					piece = b_p_k_array[randi() % b_p_k_array.size()]
				# If the first piece is a Pawn (P), the second piece must be a King or Bishop
				elif initial_piece == 'P':
					var k_b_array = ['K', 'B']
					piece = k_b_array[randi() % k_b_array.size()]
			else:
				piece = available_pieces[i]
			# Try placing the piece at different positions until a valid move is found
			for f in range(array_size * array_size):
				if is_valid_move(row, col, piece):
					# If a valid move is found, place the piece and break the loop
					board[row][col] = piece
					placed = true
					found_valid_move = true
					break

				# Generate a new random position to try
				row = randi() % (array_size - 1)
				col = randi() % (array_size - 1)

			# If no valid move was found, reset the original position and try a different piece
			if not found_valid_move:
				row = original_row
				col = original_col
			else:
				# A valid move was found, so remove the piece from the available_pieces array
				available_pieces.erase(piece)
				available_pieces.append(piece)


