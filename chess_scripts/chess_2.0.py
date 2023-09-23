import random


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
#initial_piece = random.choice(available_pieces)
#selected_pieces = [initial_piece]
#available_pieces.remove(initial_piece)

initial_piece = random.choice(available_pieces)
print(initial_piece)
available_pieces.remove(initial_piece)
selected_pieces = random.sample(available_pieces, num_pieces)

# Function to check if a piece can be placed at a given position
def is_valid_move(row, col, piece):
    # Check if the position is already occupied
    if board[row][col] != ' ':
        return False
    
    # Check if the piece can capture any other piece
    for i in range(array_size):
        for j in range(array_size):
            if board[i][j] != ' ':
                if piece == 'K' and (abs(row - i) <= 1 and abs(col - j) <= 1):
                    return True
                elif piece == 'Q' and (row == i or col == j or abs(row - i) == abs(col - j)):
                    return True
                elif piece == 'R' and (row == i or col == j):
                    return True
                elif piece == 'B' and abs(row - i) == abs(col - j):
                    return True
                elif piece == 'N' and ((abs(row - i) == 2 and abs(col - j) == 1) or (abs(row - i) == 1 and abs(col - j) == 2)):
                    return True
                elif piece == 'P' and (row == i + 1 and abs(col - j) == 1):
                    return True

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
                if i == 0:
                    if initial_piece == 'N':
                        # If the first piece is N, the second piece must also be N
                        board[row][col] = 'N'
                    elif initial_piece == 'R':
                        # If the first piece is R, the second piece can be R or K
                        board[row][col] = random.choice(['R', 'K'])
                    elif initial_piece == 'B':
                        # If the first piece is B, the second piece can be B, P, or K
                        board[row][col] = random.choice(['B', 'P', 'K'])
                    elif initial_piece == 'P':
                        # If the first piece is P, the second piece must be K or B
                        board[row][col] = random.choice(['K', 'B'])
                else:
                    # For other pieces, place them without restrictions
                    board[row][col] = piece
                placed = True


# Place the initial piece on the board
row = random.randint(0, array_size - 1)
col = random.randint(0, array_size - 1)
board[row][col] = initial_piece

# Place the remaining pieces on the board
place_remaining_pieces()


for i, row in enumerate(board, start=1):
    print(f'{" ".join(cell if cell != " " else "." for cell in row)}')

