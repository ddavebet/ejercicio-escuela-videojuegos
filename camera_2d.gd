extends Camera2D

var _decay: float = 0.8
var _max_offset: Vector2 = Vector2(100, 75)
var _max_roll: float = 0.1
var _trauma: float = 0
var _trauma_power: int = 2

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	if _trauma:
		_trauma = max(_trauma - _decay * delta, 0)
		_shake()

func add_trauma(amount: float) -> void:
	_trauma = min(_trauma + amount, 1)

func _shake() -> void:
	var amount: float = pow(_trauma, _trauma_power)
	rotation = _max_roll * amount * randf_range(-1, 1)
	offset.x = _max_offset.x * amount * randf_range(-1, 1)
	offset.y = _max_offset.y * amount * randf_range(-1, 1)
