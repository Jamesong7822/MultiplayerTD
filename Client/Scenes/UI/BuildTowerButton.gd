tool
extends TextureButton

export (PackedScene) var towerScene
export (Texture) var icon setget setTexture

func _ready() -> void:
	$MC/TextureRect.texture = icon

func setTexture(newTexture) -> void:
	icon = newTexture
	if Engine.editor_hint:
		$MC/TextureRect.texture = icon


func _on_BuildTowerButton_pressed() -> void:
	get_tree().get_nodes_in_group("GameHandler")[0]._enterBuildMode(towerScene)
