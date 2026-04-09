extends Node2D

const _BALL_SCENE_NAME: String = "res://scenes/ball.tscn"
const _MAIN_MENU_SCENE_NAME: String = "res://scenes/main_menu.tscn"
const _DEFAULT_START_SCORE: int = 0
const _MAX_HP: int = 3
const _BASE_SCORE: int = 700

@onready var ball_scene: PackedScene = preload(_BALL_SCENE_NAME)

@export var player_paddle: PlayerPaddle
@export var ball_spawn_position: Marker2D
@export var ui: UI

@export var loose_sfx: AudioStreamPlayer


var _current_ball: Ball
var _screen_size: Vector2
var _hp: int:
	set(value):
		_hp = value
		ui.set_hp(_hp)

var _current_score: int:
	set(value):
		_current_score = value
		ui.set_score(_current_score)


func _ready() -> void:
	# Setup constants.
	_screen_size = get_viewport_rect().size
	
	# Setup UI.
	_hp = _MAX_HP
	_current_score = 0
	
	# Setup gameplay signals.
	Signals.ceiling_touched.connect(_on_ceiling_touched)
	Signals.brick_destroyed.connect(_on_brick_destroyed)
	
	# Setup UI signals.
	Signals.resume_game.connect(_on_resume_game)
	Signals.restart_game.connect(_on_restart_game)
	Signals.exit_game.connect(_on_exit_game)
	

func _pause_game() -> void:
	get_tree().paused = true
	ui.show_menu()
	
	
func _on_resume_game() -> void:
	get_tree().paused = false
	ui.hide_menu()
	
	
func _on_restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	
func _on_exit_game() -> void:
	get_tree().quit()
	
	
func _on_brick_destroyed(brick: Brick) -> void:
	# Brick was destroyed by ball.
	# Destroying brick, adding score to player depending on brick row number.
	var brick_score_multiplier: int = brick.get_parent().get_index()
	_current_score += _BASE_SCORE / brick_score_multiplier
	brick.queue_free()
	
	
func _on_ceiling_touched() -> void:
	# Ball touched the ceiling. Reduce player paddle size.
	player_paddle.reduce_paddle()


func _launch_ball() -> void:
	var ball: Ball = ball_scene.instantiate()
	ball.global_position = ball_spawn_position.global_position
	add_child(ball)
	_current_ball = ball
	_current_ball.launch()


func _check_game_over() -> void:
	_hp -= 1
	

func _check_if_ball_leave_screen() -> void:
	if !_current_ball:
		return
		
	if _current_ball.position.y > _screen_size.y:
		_current_ball.queue_free()
		loose_sfx.play()
		_check_game_over()


func _handle_input() -> void:
	if Input.is_action_just_pressed("launch_ball"):
		if !_current_ball:
			_launch_ball()
			
	if !get_tree().paused:
		if Input.is_action_just_pressed("menu"):
			_pause_game()


func _process(_delta: float) -> void:
	_handle_input()
	_check_if_ball_leave_screen()
