extends Node2D

const _BALL_SCENE_NAME: String = "res://scenes/ball.tscn"
const _MAIN_MENU_SCENE_NAME: String = "res://scenes/main_menu.tscn"
const _DEFAULT_START_SCORE: int = 0

@onready var ball_scene: PackedScene = preload(_BALL_SCENE_NAME)

@export var ball_spawn_position: Marker2D
#@export var ui: UI


var _current_ball: Ball
#var _screen_size: Vector2


#func _ready() -> void:
	
	#_screen_size = get_viewport_rect().size
	
	# Setup UI.
	#ui.show_start_screen()
	#ui.set_left_player_score(_DEFAULT_START_SCORE)
	#ui.set_right_player_score(_DEFAULT_START_SCORE)
	
	# Connect signals.
	#Signals.resume_game.connect(_on_resume_game)
	#Signals.restart_game.connect(_on_restart_game)
	#Signals.exit_game.connect(_on_exit_game)


#func _pause_game() -> void:
	#get_tree().paused = true
	##ui.show_menu()
#
#
#func _on_resume_game() -> void:
	#get_tree().paused = false
	##ui.hide_menu()
	#
	#
#func _on_restart_game() -> void:
	#get_tree().paused = false
	#get_tree().reload_current_scene()
	#
	#
#func _on_exit_game() -> void:
	#get_tree().paused = false
	#get_tree().change_scene_to_file(_MAIN_MENU_SCENE_NAME)
#
#
func _launch_ball() -> void:
	var ball: Ball = ball_scene.instantiate()
	ball.global_position = ball_spawn_position.position
	add_child(ball)
	_current_ball = ball
	_current_ball.launch()
	
#
#
func _handle_input() -> void:
	if Input.is_action_just_pressed("launch_ball"):
		if !_current_ball:
			#ui.hide_start_screen()
			_launch_ball()
			
	#if Input.is_action_just_pressed("menu"):
		#_pause_game()


func _process(_delta: float) -> void:
	_handle_input()
	#_check_if_ball_leave_screen()
