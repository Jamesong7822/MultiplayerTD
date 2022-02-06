extends AnimatedSprite

func _ready() -> void:
	frame = 0
	hide()
	
func showDamageEffect() -> void:
	show()
	frame = 0
	play()


func _on_DamageEffect_animation_finished() -> void:
	pass # Replace with function body.
	frame = 0
	hide()
