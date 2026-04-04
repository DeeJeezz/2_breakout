extends StaticBody2D
class_name BasePaddle


const SPEED: float = 600.0
const _WALL_OFFSET: float = 15.0

@export var paddle: Node2D
@export var collision_shape: CollisionShape2D
@export var color: Color

var _screen_size: Vector2
var _left_border: Vector2
var _right_border: Vector2
var _half_paddle_size: float


func _ready() -> void:
	# Setup collision size.
	var sprite: Sprite2D = paddle.get_child(0)
	collision_shape.shape.size = sprite.scale
	
	# Setup constant values.
	_screen_size = get_viewport_rect().size
	_half_paddle_size = collision_shape.shape.size.x / 2
	_left_border = Vector2(
		_WALL_OFFSET + _half_paddle_size,
		position.y,
	)
	_right_border = Vector2(
		_screen_size.x - _WALL_OFFSET - _half_paddle_size,
		position.y,
	)
	
	sprite.modulate = color
	


func clamp_movement() -> void:
	position = position.clamp(
		_left_border,
		_right_border,
	)
