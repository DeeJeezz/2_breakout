extends StaticBody2D
class_name Brick

const FADE_OUT_DURATION: float = 0.25


@export var color: Color
@onready var sprite = $Sprite2D


func _ready() -> void:
	sprite.modulate = color


func destroy() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "modulate:a", 0, FADE_OUT_DURATION)
	tween.tween_callback(queue_free)
