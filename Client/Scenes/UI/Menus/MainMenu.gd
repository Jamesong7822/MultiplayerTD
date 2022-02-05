extends Control

const GAMEHANDLER = preload("res://Scenes/GameHandler.tscn")



func _on_SinglePlayerButton_pressed() -> void:
	pass # Replace with function body.
	var gh = GAMEHANDLER.instance()
	get_tree().get_root().add_child(gh)
	hide()

func _on_MultiPlayerButton_pressed() -> void:
	pass # Replace with function body.
	
func _on_AboutButton_pressed() -> void:
	pass # Replace with function body.

func _on_QuitButton_pressed() -> void:
	pass # Replace with function body.
	get_tree().quit()


