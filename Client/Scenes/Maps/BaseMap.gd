extends Node2D

func _ready() -> void:
	pass
	
func addEnemy(enemy: Node2D):
	$Paths/Path.add_child(enemy)

func addTower(tower: Node2D):
	$Towers.add_child(tower)
