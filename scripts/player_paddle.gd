extends BasePaddle
class_name PlayerPaddle


const _PADDLE_BLOCK_OFFSET: float = 2


@onready var paddle_block_scene: PackedScene = preload("res://scenes/paddle_block.tscn")

@onready var paddle_blocks: Node2D = $PaddleBlocks


func _ready() -> void:
	# TODO: Убрать инстанс этого блока.
	var middle_block: PaddleBlock = paddle_block_scene.instantiate()
	
	var paddle_block_width: float = middle_block.get_size().x + _PADDLE_BLOCK_OFFSET
	var paddle_block_height: float = middle_block.get_size().y
	
	# TODO: Почему -1?
	var paddle_width: float = paddle_block_width * (paddle_size - 1)
	var half_distance: float = paddle_width / 2
	
	var current_position = -half_distance
	while current_position <= half_distance:
		var block: PaddleBlock = paddle_block_scene.instantiate()
		block.position.x = current_position
		paddle_blocks.add_child(block)
		current_position += paddle_block_width
		
	# TODO: Почему выше -1?
	collision_shape.shape.size = Vector2(
		paddle_width + paddle_block_width,
		paddle_block_height,
	)
			
	super._ready()


func _handle_input(delta: float) -> void:
	var input: float = Input.get_axis("move_left", "move_right")
	if input:
		position.x += input * delta * SPEED


func _process(delta: float) -> void:
	_handle_input(delta)
	clamp_movement()
