extends RigidBody2D
class_name Ball

const THRUST: Vector2 = Vector2(0, -42500.0)
const IMPULSE: Vector2 = Vector2(0, 10)
const RANDOM_ROTATION_ANGLE: float = 30

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


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
	if body is Brick:
		body.destroy()
		apply_central_impulse(IMPULSE)
