import random

# Define the chess piece movement rules
piece_moves = {
    'K': [(1, 0), (-1, 0), (0, 1), (0, -1)],
    'Q': [(1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (-1, 1), (1, -1), (-1, -1)],
    'R': [(1, 0), (-1, 0), (0, 1), (0, -1)],
    'B': [(1, 1), (-1, 1), (1, -1), (-1, -1)],
    'N': [(2, 1), (1, 2), (-2, 1), (1, -2), (-1, 2), (2, -1), (-1, -2), (-2, -1)],
    'P': [(1, 0), (1, 1), (1, -1)]
}

num_pieces = 0
array_size = int(input("How Big Is the Array:"))

# Define the available chess pieces
available_pieces = ['K', 'P', 'R', 'B', 'B', 'N', 'N', 'P', 'P']

difficulty = input("Easy, Medium, Hard?: ")

if difficulty.lower() == "easy":
    num_pieces = 4
elif difficulty.lower() == "medium":
    num_pieces = 5
elif difficulty.lower() == "hard":
    num_pieces = 8

board = [[' ' for _ in range(array_size)] for _ in range(array_size)]

# Randomly select the first piece from the available pieces
initial_piece = random.choice(available_pieces)
print(initial_piece)
available_pieces.remove(initial_piece)
selected_pieces = random.sample(available_pieces, num_pieces)

# Function to check if a piece can be placed at a given position
def is_valid_move(row, col, piece):
    # Check if the position is already occupied
    if board[row][col] != ' ':
        return False

    # Pawn Movement
    if piece == 'P':
        if row == 0:  # If the pawn reaches the last row, it cannot move further
            return False
        if col > 0 and board[row-1][col-1] == 'P':
            return True
        if col < array_size - 1 and board[row-1][col+1] == 'P':
            return True

    # Rook Movement
    if piece == 'R':
        if any(board[row][i] != ' ' for i in range(array_size) if i != col):
            return True
        if any(board[i][col] != ' ' for i in range(array_size) if i != row):
            return True

    # Bishop Movement
    if piece == 'B':
        if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col-1, -1, -1))):
            return True
        if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col+1, array_size))):
            return True
        if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col-1, -1, -1))):
            return True
        if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col+1, array_size))):
            return True

    # Knight Movement
    if piece == 'N':
        knight_moves = [
            (row-2, col-1), (row-2, col+1),
            (row-1, col-2), (row-1, col+2),
            (row+1, col-2), (row+1, col+2),
            (row+2, col-1), (row+2, col+1)
        ]
        return any(0 <= i < array_size and 0 <= j < array_size and board[i][j] != ' ' for i, j in knight_moves)

    # Queen Movement (Combining Rook and Bishop)
    if piece == 'Q':
        if any(board[row][i] != ' ' for i in range(array_size) if i != col):
            return True
        if any(board[i][col] != ' ' for i in range(array_size) if i != row):
            return True
        if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col-1, -1, -1))):
            return True
        if any(board[i][j] != ' ' for i, j in zip(range(row-1, -1, -1), range(col+1, array_size))):
            return True
        if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col-1, -1, -1))):
            return True
        if any(board[i][j] != ' ' for i, j in zip(range(row+1, array_size), range(col+1, array_size))):
            return True

    # King Movement
    if piece == 'K':
        king_moves = [
            (row-1, col-1), (row-1, col), (row-1, col+1),
            (row, col-1), (row, col+1),
            (row+1, col-1), (row+1, col), (row+1, col+1)
        ]
        return any(0 <= i < array_size and 0 <= j < array_size and board[i][j] != ' ' for i, j in king_moves)

    return False

# Function to place the remaining pieces on the board
def place_remaining_pieces():
    for i in range(1, num_pieces):
        placed = False
        while not placed:
            row = random.randint(0, (array_size - 1))
            col = random.randint(0, (array_size - 1))
            piece = selected_pieces[i]
            if is_valid_move(row, col, piece):
                board[row][col] = piece
                placed = True

# Function to move a piece on the board
def move_piece():
    print("Enter source row and column (e.g., 1 2):")
    source_row, source_col = map(int, input().split())
    print("Enter destination row and column (e.g., 3 4):")
    dest_row, dest_col = map(int, input().split())

    source_piece = board[source_row][source_col]
    dest_piece = board[dest_row][dest_col]

    if is_valid_move(dest_row, dest_col, source_piece):
        board[dest_row][dest_col] = source_piece
        board[source_row][source_col] = ' '
        return True
    else:
        if dest_piece != ' ':
            print(f"You have overridden {dest_piece} with {source_piece}.")
            board[dest_row][dest_col] = source_piece
            board[source_row][source_col] = ' '
            return True
        else:
            print("Invalid move. Try again.")
            return False

# Place the initial piece on the board
row = random.randint(0, array_size - 1)
col = random.randint(0, array_size - 1)
board[row][col] = initial_piece

# Place the remaining pieces on the board
place_remaining_pieces()

# Display the initial board
for i, row in enumerate(board, start=1):
    print(f'{" ".join(cell if cell != " " else "." for cell in row)}')

# Allow the player to make moves
while True:
    if move_piece():
        for i, row in enumerate(board, start=1):
            print(f'{" ".join(cell if cell != " " else "." for cell in row)}')
