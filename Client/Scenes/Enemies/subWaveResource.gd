extends Resource

# This class type stores the specific stuff for each wave

class_name subWaveResource

enum ENEMY_TYPE {INFANTRTY}

export (int) var numSubWaves
export (ENEMY_TYPE) var enemyType
export (int) var subWaveSize
export (float) var spawnSpacing
export (float) var subWaveSpacing
export (float) var postSubWaveSpacing = 2.0

func _ready():
	pass

func getEnemyScene():
	var enemyScene
	match enemyType:
		ENEMY_TYPE.INFANTRTY:
			enemyScene = "res://Scenes/Enemies/BaseEnemy.tscn"
			
	return load(enemyScene)
