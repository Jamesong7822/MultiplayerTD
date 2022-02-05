extends Node2D

func _ready() -> void:
	pass
	
func addEnemy(enemy: Node2D):
	$Paths/Path.add_child(enemy)
