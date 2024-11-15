extends CharacterBody2D

signal player_hit()
signal lives_depleted()

const SPEED: float = 175
const JUMP_VELOCITY: float = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var detection_area: Area2D = $DetectionArea
@onready var lives_label: Label = $Lives/Label
@onready var hit_sfx: AudioStreamPlayer = $HitSFX

var _lives: int = 3
var _is_hit: bool = false

func _ready() -> void:
	detection_area.body_entered.connect(Callable(self, "_on_detection_area_body_entered"))
	sprite.animation_finished.connect(Callable(self, "_on_sprite_animation_finished"))

	lives_label.text = str(_lives)

func _physics_process(delta: float) -> void:
	if not _is_hit:
		var direction: float = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = SPEED * direction
			sprite.flip_h = direction == -1
			sprite.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			sprite.play("idle")

	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		hit_sfx.play()
		velocity = Vector2(0, 0)
		_is_hit = true
		_lives -= 1
		lives_label.text = str(_lives)
		player_hit.emit()
		if _lives > 0:
			sprite.play("hit")
			_play_hitstun_effect()
		else:
			lives_depleted.emit()
			sprite.play("dead")
			_play_hitstun_effect()
			collision_shape.set_deferred("disabled", true)
			detection_area.set_deferred("monitoring", false)

func _on_sprite_animation_finished() -> void:
	if sprite.animation == "hit":
		_is_hit = false

func _play_hitstun_effect() -> void:
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.25, true, false, true).timeout
	Engine.time_scale = 1
