extends Node

export (String, FILE) var MAP
export (Array, Dictionary) var WAVES

var map
var currentWave = 0

func setMapScene(newMapScene: String) -> void:
	map = load(newMapScene).instance()
	map.name = "World"
	add_child(map)
	
func _ready() -> void:
	setMapScene(MAP)
#	yield(get_tree().create_timer(2), "timeout")
#	sendWave([{"scene": "res://Scenes/Enemies/BaseEnemy.tscn"}])

#func sendWave(waveInformation: Array):
#	currentWave += 1
#	for seq in waveInformation:
#		var e = seq["scene"]
#		map.addEnemy(e)
	
