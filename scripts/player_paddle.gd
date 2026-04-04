extends BasePaddle
class_name PlayerPaddle


func _handle_input(delta: float) -> void:
	var input: float = Input.get_axis("move_left", "move_right")
	if input:
		position.x += input * delta * SPEED


func _process(delta: float) -> void:
	_handle_input(delta)
	clamp_movement()
