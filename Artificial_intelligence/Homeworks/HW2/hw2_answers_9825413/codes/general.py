import platform
from os import system
from termcolor import colored
from random import randint
from math import inf
# game types
HUMAN_VS_AI_GAME = 1
AI_VS_AI_GAME = 2
QUIT_GAME = 3

# game colors
G_player = 'G'
R_player = 'R'

# algorithms
MINIMAX_ALGORITHM = 1  # "minimax"
MINIMAX_AB_ALGORITHM = 2  # "minimax_ab"

HUMAN_PLAYER = "HUMAN"
AI_PLAYER = "AI1"


def clean():
    """
    Clears the console
    """
    os_name = platform.system().lower()
    if 'windows' in os_name:
        system('cls')
    else:
        system('clear')
