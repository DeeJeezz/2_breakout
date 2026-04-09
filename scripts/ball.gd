extends RigidBody2D
class_name Ball

const THRUST: Vector2 = Vector2(0, -42500.0)
const IMPULSE: Vector2 = Vector2(0, 10)
const RANDOM_ROTATION_ANGLE: float = 30

const CEILING_GROUP_NAME: String = "ceiling"

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var brick_hit_sfx: AudioStreamPlayer = $SFX/BrickHitSFX
@onready var paddle_hit_sfx: AudioStreamPlayer = $SFX/PaddleHitSFX


func _ready() -> void:
	# Setup collision shape.
	if collision_shape.shape is CircleShape2D:
		collision_shape.shape.radius = sprite.texture.get_width() / 2


func launch() -> void:
	apply_central_force(THRUST.rotated(_get_random_angle_radians()))


func _get_random_angle_radians() -> float:
	return deg_to_rad(
		randf_range(
			-RANDOM_ROTATION_ANGLE, 
			RANDOM_ROTATION_ANGLE,
		),
	)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group(CEILING_GROUP_NAME):
		Signals.ceiling_touched.emit()

	if body is Brick:
		Signals.brick_destroyed.emit(body)
		apply_central_impulse(IMPULSE)
		brick_hit_sfx.pitch_scale = randf_range(0.9, 1.2)
		brick_hit_sfx.play()
	elif body is PlayerPaddle:
		paddle_hit_sfx.play()
