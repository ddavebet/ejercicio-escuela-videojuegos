extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var camera: Camera2D = $Camera
@onready var gameover_anim_player: AnimationPlayer = $Gameover/AnimationPlayer

func _ready() -> void:
	player.player_hit.connect(Callable(self, "_on_player_hit"))
	player.lives_depleted.connect(Callable(self, "_on_gameover"))

func _process(delta: float) -> void:
	pass

func _on_player_hit() -> void:
	camera.add_trauma(0.2)

func _on_gameover() -> void:
	gameover_anim_player.play("gameover")
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()
