from general import *

player1 = R_player
player2 = G_player
board = []
BOARD_SIZE = 25
is_human_first_player = True
num_repeat_algorithm = 0

BOARD_COLOR = 'magenta'
MESSAGES_COLOR1 = 'yellow'
MESSAGES_COLOR2 = 'cyan'


def board_game_init():
    global board
    board = []
    for _ in range(BOARD_SIZE):
        board.append(' ')
    return board

def show_welcome_messages():
    welcome_message_string = """
    ***********************************************************
    *  WELCOME to 5x5 COLORFULL Tic-Tac-Toe WITH A NEW LOOK!  *
    *       In this Game We use minimax algorithms =)         *
    *               HOPE YOU ENJOY IT =)                      *
    ***********************************************************

    """
    print(colored(welcome_message_string, MESSAGES_COLOR2))
    print(
        f"{colored('We have two colors :',MESSAGES_COLOR1)} {colored('Red','red')}/{colored('Green','green')}")

def get_player2(player1):
    if player1 == R_player:
        return G_player
    return R_player

def select_player_color(player_type):
    print(colored('Which Color would you like be used for {}?'.format(
        player_type), MESSAGES_COLOR2))
    print(colored("[1] RED", 'red'))
    print(colored("[2] GREEN", 'green'))
    selected_color = int(
        input(colored("Please choose either 1 or 2: ", MESSAGES_COLOR1)))
    if selected_color not in (1, 2):
        print("Please choose again.")
        return
    return R_player if selected_color == 1 else G_player

def get_game_type(argument):
    GAME_TYPES = {
        1: HUMAN_VS_AI_GAME,
        2: AI_VS_AI_GAME,
        3: QUIT_GAME,
    }

    return GAME_TYPES.get(argument, HUMAN_VS_AI_GAME)

def select_game_type():
    game_type_string = """
    Which type of Game Do You Like?
    [1] AI VS Human.
    [2] AI VS AI.
    [3] Exit the game.
    """
    print(colored(game_type_string, MESSAGES_COLOR2))
    selected_game_type = int(
        input(colored("Please choose either 1, 2, or 3: ", MESSAGES_COLOR1)))
    while selected_game_type not in (1, 2, 3):
        selected_game_type = int(
            input(colored("Please choose either 1, 2, or 3: ", MESSAGES_COLOR1)))

    return get_game_type(selected_game_type)

def select_game_algorithm():
    select_algorithm_string = """
    Which algorithm would you like to be used?
    [1] minimax
    [2] minimax with alpha&beta purning
    """
    print(colored(select_algorithm_string, MESSAGES_COLOR2))
    selected_algorithm = int(
        input(colored("Please choose either 1 or 2: ", MESSAGES_COLOR1)))
    if selected_algorithm not in (1, 2):
        print("Please choose again.")
        return
    return MINIMAX_ALGORITHM if selected_algorithm == 1 else MINIMAX_AB_ALGORITHM

def select_first_player():  # which of these players should play first? computer or human?
    global is_human_first_player
    select_first_player_message = """
    Which of these players should play first?
    [1] human
    [2] computer
    """
    print(colored(select_first_player_message, MESSAGES_COLOR1))
    first_player = input("Please choose either 1 or 2: ")

    if first_player not in ('1', '2'):
        print("Please choose again.")
        return

    if first_player == '1':
        is_human_first_player = True
    elif first_player == '2':
        is_human_first_player = False

def evaluate(board):
    """
    Function to heuristic evaluation of state.
    return: +1 if the player1 wins; -1 if the player2 wins; 0 draw
    """
    winner = check_win(board)

    if winner == player1:
        score = +1
    elif winner == player2:
        score = -1
    else:
        score = 0

    return score


def minimax(board, player, depth):
    if player == player1:
        best_value = -inf
    else:
        best_value = +inf

    if depth == 0 or is_game_over(board):
        score = evaluate(board)
        return None, score

    global num_repeat_algorithm
    num_repeat_algorithm += 1

    score = None
    best_move = None

    for i in range(BOARD_SIZE):
        if board[i] == ' ':
            board[i] = player
            _, score = minimax(board,
                               G_player if player == R_player else R_player,
                               depth - 1)
            board[i] = ' '
            if player == player1:  # maximaize-player1
                if score > best_value:
                    best_value = score
                    best_move = i
            else:
                if score < best_value:  # minimize-player2
                    best_value = score
                    best_move = i

    return best_move, best_value

def minimax_ab(board, player, depth, alpha=-inf, beta=inf):
    if depth == 0 or is_game_over(board):
        score = evaluate(board)
        return None, score

    global num_repeat_algorithm
    num_repeat_algorithm += 1

    best_move = None
    value = None

    for i in range(BOARD_SIZE):
        if board[i] == ' ':
            board[i] = player
            _, value = minimax_ab(board,
                                  G_player if player == R_player else R_player,
                                  depth - 1,
                                  alpha,
                                  beta)
            board[i] = ' '
            if (value is not None):
                if player == player1 and value > alpha:
                    alpha = value
                elif player == player2 and value < beta:
                    beta = value
                best_move = i

                if (alpha != -inf and beta != inf
                        and alpha >= beta if player == player1 else beta >= alpha):
                    break

    if player == player1:
        return best_move, alpha

    return best_move, beta


def get_colored_move(move_color):
    if move_color == G_player:
        return colored(move_color, 'green')
    elif move_color == R_player:
        return colored(R_player, 'red')
    else:
        return ' '

def print_board(board):
    if len(board) != BOARD_SIZE:
        print("Something's wrong with the board. len() != 25")
        return
    print()
    print()
    print(colored("             |       |       |       |      ", BOARD_COLOR))
    for i in range(5):
        print(
            f"         {get_colored_move(board[5*i])}   |   {get_colored_move(board[5*i+1])}   |   {get_colored_move(board[5*i+2])}   |   {get_colored_move(board[5*i+3])}   |   {get_colored_move(board[5*i+4])}   ")
        if i < 4:
            print(colored("      _______|_______|_______|_______|_______", BOARD_COLOR))
            print(colored("             |       |       |       |      ", BOARD_COLOR))

def check_win(board):
    """
    This function checks for all possible three-in-a-row wins on a
    5x5 tic-tac-toe board.
    """
    # Possible Horizontal Wins
    horizontal = [0, 1, 2, 5, 6, 7, 10, 11, 12, 15, 16, 17, 20, 21, 22]
    for i in horizontal:
        if (board[i] != ' '
           and board[i] == board[i + 1] == board[i + 2]):
            return board[i]

    # Possible Vertical wins
    for i in range(15):
        if (board[i] != ' '
           and board[i] == board[i + 5] == board[i + 10]):
            return board[i]

    # Possible Diagonal wins, left to right
    l_diagonal = [0, 1, 2, 5, 6, 7, 10, 11, 12]
    for i in l_diagonal:
        if (board[i] != ' '
           and board[i] == board[i + 5 + 1] == board[i + 10 + 2]):
            return board[i]

    # Possible Diagonal wins, right to left
    r_diagonal = [2, 3, 4, 7, 8, 9, 12, 13, 14]
    for i in r_diagonal:
        if (board[i] != ' '
           and board[i] == board[i + 5 - 1] == board[i + 10 - 2]):
            return board[i]

    # Possible draw
    draw = True
    for char in board:
        if char == ' ':
            draw = False

    if draw:
        return "draw"

    return ' '

def is_game_over(board):
    winner = check_win(board)
    return winner == G_player or winner == R_player

def ai_move(board, player, algorithm):  # max player
    global num_repeat_algorithm
    num_repeat_algorithm = 0

    if algorithm == MINIMAX_ALGORITHM:
        move, _ = minimax(board, player, 5)
        algorithm_str = "MINIMAX"

    elif algorithm == MINIMAX_AB_ALGORITHM:
        move, _ = minimax_ab(board, player, 8)
        algorithm_str = "alpha&beta MINIMAX"

    if move is None:
        print(colored(
            f'** in {algorithm_str} algorithm, move was none so a random number selected**'))
        move = randint(0, 24)

    board[move] = player
    print(colored(
        f"\nnumber of Calls to {algorithm_str} function is: {num_repeat_algorithm}", MESSAGES_COLOR1))

def is_player_move_valid(board, move):
    return 0 <= move <= 24 and board[move] not in (G_player, R_player)

def human_move(player_turn):
    move_message_str = f"""
    Where would you like to place your \'{player_turn}\'?
    Enter a number between 1 and 25.
    1 is top left and 25 is the bottom right.
    If you would like to quit, please enter \'q\'
    """
    print(colored(move_message_str, MESSAGES_COLOR1))
    move = -1
    while move == -1 or is_player_move_valid(board, move) == False:
        try:
            move = input(colored("Please enter your move: ", MESSAGES_COLOR2))
            if move == "q":
                return "q"
            move = int(move) - 1
            if not is_player_move_valid(board, move):
                move = -1
            else:
                board[move] = player_turn
                return
        except (KeyError, ValueError):
            print('enter a valid move.')
        except (EOFError, KeyboardInterrupt):
            print('Bye')
            exit()


def game(board, player1, player2, game_type, game_algorithm=""):
    global is_human_first_player
    turn = player1
    is_quit_game = False
    while not is_game_over(board):
        print(colored("\nThis is the current board state:", MESSAGES_COLOR1))
        print_board(board)
        print(colored(f"\n\tIt is \'{turn}\' player's move:", MESSAGES_COLOR2))
        if (game_type == HUMAN_VS_AI_GAME):
            if (turn == player1 and is_human_first_player):
                if human_move(turn) == "q":
                    is_quit_game = True
                    break
            elif (turn == player2):
                ai_move(board, turn, game_algorithm)
                is_human_first_player = True

        elif (game_type == AI_VS_AI_GAME):
            ai_move(board, turn, game_algorithm)

        if turn == player1:
            turn = player2
        else:
            turn = player1

    if is_quit_game:
        return

    winner = check_win(board)
    if winner in (G_player, R_player):
        print_board(board)
        winner_congrats(winner)
    elif winner == "draw":
        print("It's a draw!")
    return

def winner_congrats(winner):
    winning_message_string = f"""

    ############################
    ############################
          CONGRATULATIONS     
         {winner} WON THE GAME  
    ############################
    ############################

    """
    print(colored(winning_message_string, MESSAGES_COLOR1))


def play_agian():
    print("would you like to play agian?")
    print("[1] YES")
    print("[2] NO")
    answer = int(input("Please choose either 1 or 2: "))
    while answer not in (1, 2):
        print("Please choose again.")
        return
    return True if answer == 1 else False


def main():
    show_welcome_messages()
    while True:
        board = board_game_init()
        selected_game_type = select_game_type()
        clean()
        if selected_game_type == QUIT_GAME:
            break

        elif selected_game_type == HUMAN_VS_AI_GAME:  # HUMAN VS AI
            select_first_player()
            player1 = select_player_color(HUMAN_PLAYER)

        elif selected_game_type == AI_VS_AI_GAME:  # AI VS AI
            player1 = select_player_color(AI_PLAYER)

        player2 = get_player2(player1)
        clean()
        selected_game_algorithm = select_game_algorithm()
        clean()
        game(board, player1, player2, selected_game_type, selected_game_algorithm)
        another_round = play_agian()
        if another_round:
            clean()
            continue
        else:
            break

    clean()
    print(colored("\n\nGoodbye.\n\n", 'magenta'))


if __name__ == '__main__':
    clean()
    main()
