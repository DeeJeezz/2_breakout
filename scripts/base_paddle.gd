extends StaticBody2D
class_name BasePaddle


const SPEED: float = 625.0
const _WALL_OFFSET: float = 7.5

@export var color: Color
@export var paddle_size: int = 3

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var _screen_size: Vector2
var _left_border: Vector2
var _right_border: Vector2
var _half_paddle_size: float


func _ready() -> void:
	# Setup constant values.
	_screen_size = get_viewport_rect().size
	# TODO: Переделать расчет коллайдера.
	_half_paddle_size = collision_shape.shape.size.x / 2
	_left_border = Vector2(
		_WALL_OFFSET + _half_paddle_size,
		position.y,
	)
	_right_border = Vector2(
		_screen_size.x - _WALL_OFFSET - _half_paddle_size,
		position.y,
	)
	


func clamp_movement() -> void:
	position = position.clamp(
		_left_border,
		_right_border,
	)
