extends Control

var characterScenes = {
	'K': "res://chess_scenes/pieces/King.tscn",
	'P': "res://chess_scenes/pieces/Pawn.tscn",
	'R': "res://chess_scenes/pieces/Rook.tscn",
	'B': "res://chess_scenes/pieces/Bishop.tscn",
	'N': "res://chess_scenes/pieces/Knight.tscn",
	# Add more characters and scene paths as needed
}

var cell_size_x = 128  # Adjust this value according to your grid or tile size
var cell_size_y = 128  # Adjust this value according to your grid or tile size

var num_pieces = 0
var array_size = 6

# Define the available chess pieces
var available_pieces = ['K', 'P', 'R', 'B', 'B', 'N', 'N', 'P', 'P', 'P', 'B', 'B', 'N', 'N', 'P', 'P']

var difficulty = "easy"
var board = []
var row
var col
var initial_piece
func _ready():
	if difficulty == "easy":
		num_pieces = 10
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
	#get first piece and erase
	initial_piece = available_pieces[0]
	available_pieces.erase(initial_piece)
	available_pieces = available_pieces.filter(func(value): return value != null)
	var scene_path = characterScenes[initial_piece]
	var character_instance = load(scene_path)
	print(scene_path)
	# Create an instance of the scene
	var character_node = character_instance.instantiate()

	# Add the character to your game scene (you may need to adjust the position)
	# For example, if you have a parent node for characters:
	add_child(character_node)
	#place first piece random
	print(initial_piece)
	row = randi() % (array_size - 1)
	col = randi() % (array_size - 1)
	board[row][col] = initial_piece
	character_node.position =  Vector2((col * cell_size_x) - 225, (row * cell_size_y) - 200)
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
	for i in range(0, num_pieces - 1):
		var placed = false
		while not placed:
			row = randi() % (array_size - 1)
			col = randi() % (array_size - 1)
			var piece = available_pieces[i]
			var original_row = row
			var original_col = col
			var found_valid_move = false
			
			if i == 0:
				# If the first piece is a Knight (N), the second piece must also be a Knight
#				if initial_piece == 'N':
#					piece = 'N'
#					available_pieces.erase(piece)
#					available_pieces = available_pieces.filter(func(value): return value != null)
#					print(available_pieces)
#				# If the first piece is a Rook (R), the second piece can be a Rook or a King
#				elif initial_piece == 'R':
#					var r_k_array = ['R', 'K']
#					piece = r_k_array[randi() % r_k_array.size()]
#					available_pieces.erase(piece)
#					available_pieces = available_pieces.filter(func(value): return value != null)
#				# If the first piece is a Bishop (B), the second piece can be a Bishop, Pawn, or King
#				elif initial_piece == 'B':
#					var b_p_k_array = ['B', 'P', 'K']
#					piece = b_p_k_array[randi() % b_p_k_array.size()]
#					available_pieces.erase(piece)
#					available_pieces = available_pieces.filter(func(value): return value != null)
#				# If the first piece is a Pawn (P), the second piece must be a King or Bishop
#				elif initial_piece == 'P':
#					var k_b_array = ['K', 'B']
#					piece = k_b_array[randi() % k_b_array.size()]
#					available_pieces.erase(piece)
#					available_pieces = available_pieces.filter(func(value): return value != null)
			#else:
				piece = available_pieces[i]
			# Try placing the piece at different positions until a valid move is found
			for f in range(array_size * array_size):
				if is_valid_move(row, col, piece):
					# If a valid move is found, place the piece and break the loop
					print(available_pieces)
					print(available_pieces[i])
					available_pieces.erase(available_pieces[i])
					print(available_pieces)
					available_pieces = available_pieces.filter(func(value): return value != null)
					available_pieces.append('Z')
					board[row][col] = piece

					placed = true
					found_valid_move = true
					var scene_path = characterScenes[piece]
					var character_instance = load(scene_path)
					print(scene_path)
					# Create an instance of the scene
					var character_node = character_instance.instantiate()

					# Add the character to your game scene (you may need to adjust the position)
					# For example, if you have a parent node for characters:
					character_node.position = Vector2((col * cell_size_x) - 225, (row * cell_size_y) - 200)
					add_child(character_node)

					break

				# Generate a new random position to try
				row = randi() % (array_size - 1)
				col = randi() % (array_size - 1)

			# If no valid move was found, reset the original position and try a different piece
			if not found_valid_move:
				print("no move found with" + available_pieces[i])
				row = original_row
				col = original_col
				i = i - 1
			else:
				# A valid move was found, so remove the piece from the available_pieces array
				
				print("move found")


