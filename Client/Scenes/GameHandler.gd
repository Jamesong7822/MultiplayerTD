extends Node

export (String, FILE) var MAP
export (Array, Dictionary) var WAVES

var map
var buildMode = false
var buildTowerScene

func setMapScene(newMapScene: String) -> void:
	map = load(newMapScene).instance()
	map.name = "World"
	add_child(map)
	
func _ready() -> void:
	setMapScene(MAP)
	
func _start() -> void:
	$WaveHandler._startWave()
	
func _physics_process(delta: float) -> void:
	if buildMode:
		pass
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and buildMode:
		_exitBuildMode()
	if event.is_action_pressed("left_click") and buildMode:
		var built = buildTowerScene.placeTower()
		if built:
			_exitBuildMode()
	
func _enterBuildMode(towerScene:PackedScene) -> void:
	if not buildMode:
		buildMode = true
		buildTowerScene = towerScene.instance()
		map.addTower(buildTowerScene)
	
func _exitBuildMode() -> void:
	buildMode = false
	if not buildTowerScene.built:
		buildTowerScene.queue_free()
	
