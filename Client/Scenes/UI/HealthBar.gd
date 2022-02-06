extends TextureProgress

const GREEN = preload("res://Assets/Enemies/Damage/barHorizontal_green.png")
const YELLOW = preload("res://Assets/Enemies/Damage/barHorizontal_yellow.png")
const RED = preload("res://Assets/Enemies/Damage/barHorizontal_red.png")

func _ready() -> void:
	pass
	
func _setMaxValue(newMaxValue: float) -> void:
	max_value = newMaxValue
	
func _updateValue(newValue: float) -> void:
	value = newValue
	_updateColours()

func _updateColours() -> void:
	if value < 0.3*max_value:
		texture_progress = RED
	elif value < 0.7*max_value:
		texture_progress = YELLOW
	else:
		texture_progress = GREEN
