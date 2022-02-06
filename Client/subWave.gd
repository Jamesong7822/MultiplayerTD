extends Resource

# This class type allows for more dynamic wave spawning
# for groups of different enemy classes within a wave

class_name subWaves

export (Array, Resource) var subWavesManager setget set_subWaves

func _ready():
	pass

func set_subWaves(value):
	var arraySize = value.size()
	subWavesManager.resize(arraySize)
	subWavesManager = value
	for i in subWavesManager.size():
		if not subWavesManager[i]:
			subWavesManager[i] = subWaveResource.new()
			subWavesManager[i].resource_name = "Group %s" % (i+1)
