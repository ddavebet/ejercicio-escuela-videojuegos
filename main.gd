extends Control

@onready var intro_music: AudioStreamPlayer = $IntroMusic

func _ready() -> void:
	intro_music.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://game.tscn")
