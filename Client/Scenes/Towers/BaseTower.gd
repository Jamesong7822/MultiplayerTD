extends Node2D

export (String) var towerName
export (int) var level
export (float) var damage

enum TOWER_TYPES {}
export (TOWER_TYPES) var towerType

var enemiesInRange = []
var target

var canShoot = true

func _ready() -> void:
	pass
	loadTowerStats()
	
func _process(delta: float) -> void:
	selectTarget()
	aim()
	shoot()

func loadTowerStats():
	# load from autoload
	pass
	
func selectTarget():
	# get the furthest enemy on the track
	var maxOffset = 0
	var _target = null
	for i in enemiesInRange:
		if i.is_queued_for_deletion():
			continue
		else:
			var e = i.get_parent()
			if e.unit_offset > maxOffset:
				maxOffset = e.unit_offset
				_target = e
	target = _target
	
	
func aim():
	# turn to look at target
	if not target:
		# look at the mousepos
		var mousePos = get_viewport().get_mouse_position()
		$Turret.look_at(mousePos)
		return
	$Turret.look_at(target.global_position)
	
func shoot():
	# shoot
	if not canShoot:
		return
	if not target:
		return
	if canShoot:
		canShoot = false
		target.takeDamage(damage)
		$ReloadTimer.start()

func _on_Range_body_entered(body: Node) -> void:
	pass # Replace with function body.
	if not body in enemiesInRange:
		enemiesInRange.append(body)

func _on_Range_body_exited(body: Node) -> void:
	pass # Replace with function body.
	if body in enemiesInRange:
		enemiesInRange.erase(body)

func _on_ReloadTimer_timeout() -> void:
	pass # Replace with function body.
	canShoot = true
