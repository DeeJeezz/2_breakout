extends Node

# UI signals.
signal restart_game
signal exit_game
signal resume_game

# Gameplay signals.
signal ceiling_touched
signal brick_destroyed (brick: Brick)
