tool
extends Node

export (Array, Resource) var WaveManager setget set_WaveManager

var currentWave = 0
var numWaves
var numEnemyPaths
var currentPathFocus = 0


signal waveComplete
signal updateHUD

# custom CB function to edit the waveManager array size!
func set_WaveManager(value):
	WaveManager.resize(value.size())
	WaveManager = value
	for i in WaveManager.size():
		if not WaveManager[i]:
			WaveManager[i] = subWaves.new()
			WaveManager[i].resource_name = "wave %s" % (i+1)
#=======================================================#
func _ready():
	numWaves = WaveManager.size()
	connect("waveComplete", self, "on_wave_complete")
#	yield(get_tree().create_timer(3),"timeout")
#	var waveData = getWaveData()
#	if waveData:
#		spawnWave(waveData)

func _startWave() -> void:
	var waveData = getWaveData()
	if waveData:
		spawnWave(waveData)


func getWaveData():
	if currentWave >= WaveManager.size():
		return null
	var subWavesManager = WaveManager[currentWave].subWavesManager
	var waveData = []
	for group in subWavesManager:
		var groupDict = {}
		groupDict["numSubWaves"] = group.numSubWaves
		groupDict["subWaveSize"] = group.subWaveSize
		groupDict["spawnSpacing"] = group.spawnSpacing
		groupDict["subWaveSpacing"] = group.subWaveSpacing
		groupDict["postSubWaveSpacing"] = group.postSubWaveSpacing
		groupDict["enemyScene"] = group.getEnemyScene()
		waveData.append(groupDict)
	return waveData

func spawnWave(waveData):
	var numGroups = waveData.size()
	var groupCounter = 0
	for groupData in waveData:
		if groupCounter != numGroups-1:
			spawnGroup(groupData)
		else:
			spawnGroup(groupData, true)
		groupCounter += 1
	
func spawnGroup(groupData, isLastGroup=false):
	var numSubWaves = groupData["numSubWaves"]
	var subWaveSize = groupData["subWaveSize"]
	var spawnSpacing = groupData["spawnSpacing"]
	var subWaveSpacing = groupData["subWaveSpacing"]
	var postSubWaveSpacing = groupData["postSubWaveSpacing"]
	var enemyPackedScene = groupData["enemyScene"]
	for wave in range(numSubWaves):
		for groupSize in range(subWaveSize):
			spawnUnit(enemyPackedScene)
			yield(get_tree().create_timer(spawnSpacing), "timeout")
		yield(get_tree().create_timer(subWaveSpacing), "timeout")
	# After the wave wait for the post sub wave spacing
	yield(get_tree().create_timer(postSubWaveSpacing), "timeout")
	if isLastGroup:
		emit_signal("waveComplete")
	
func spawnUnit(enemy):
	var e = enemy.instance()
	var map = get_parent().map
	map.addEnemy(e)
	
func on_wave_complete() -> void:
	currentWave += 1
	emit_signal("updateHUD", currentWave)
