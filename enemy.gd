extends AnimatableBody2D

var direction: int = -1
var speed: Vector2 = Vector2(75, 0)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	sprite.flip_h = false

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(speed * direction * delta)
	if collision:
		_change_direction()

func _change_direction() -> void:
	direction *= -1
	sprite.flip_h = direction == 1
