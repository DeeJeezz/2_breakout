extends Node2D

const _BALL_SCENE_NAME: String = "res://scenes/ball.tscn"
const _MAIN_MENU_SCENE_NAME: String = "res://scenes/main_menu.tscn"
const _DEFAULT_START_SCORE: int = 0
const _MAX_HP: int = 3

@onready var ball_scene: PackedScene = preload(_BALL_SCENE_NAME)

@export var player_paddle: PlayerPaddle
@export var ball_spawn_position: Marker2D
@export var ui: UI

var _current_ball: Ball
var _screen_size: Vector2
var _hp: int


func _ready() -> void:
	_screen_size = get_viewport_rect().size
	_hp = _MAX_HP
	ui.set_hp(_hp)


func _launch_ball() -> void:
	var ball: Ball = ball_scene.instantiate()
	ball.global_position = ball_spawn_position.global_position
	add_child(ball)
	_current_ball = ball
	_current_ball.launch()


func _check_game_over() -> void:
	_hp -= 1
	ui.set_hp(_hp)
	

func _check_if_ball_leave_screen() -> void:
	if !_current_ball:
		return
		
	if _current_ball.position.y > _screen_size.y:
		_current_ball.queue_free()
		_check_game_over()


func _handle_input() -> void:
	if Input.is_action_just_pressed("launch_ball"):
		if !_current_ball:
			_launch_ball()


func _process(_delta: float) -> void:
	_handle_input()
	_check_if_ball_leave_screen()
