extends Node2D
class_name PaddleBlock


@export var sprite: Sprite2D


func get_size() -> Vector2:
	return sprite.scale
