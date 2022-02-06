extends HBoxContainer

var gameHandler

func _ready() -> void:
	gameHandler = get_tree().get_nodes_in_group("GameHandler")[0]
	gameHandler.get_node("WaveHandler").connect("waveComplete", self, "_onWaveComplete")
	gameHandler.get_node("WaveHandler").connect("updateHUD", self, "_setWaveNum")

func _setWaveNum(newWaveNum: int) -> void:
	$Label.text = "Wave: %s" %(newWaveNum+1)

func _on_Play_pressed() -> void:
	pass # Replace with function body.
	gameHandler._start()
	$Play.disabled = true

func _onWaveComplete() -> void:
	$Play.disabled = false
