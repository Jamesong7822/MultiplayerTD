extends Node2D

export (String) var towerName
export (int) var level
export (float) var damage

enum TOWER_TYPES {}
export (TOWER_TYPES) var towerType

var enemiesInRange = []
var target
var canBeBuilt = true
var built = false
var canShoot = true

func _ready() -> void:
	pass
	$AnimationPlayer.play("RESET")
	loadTowerStats()
	
func _process(delta: float) -> void:
	if built:
		selectTarget()
		aim()
		shoot()
	else:
		checkIfTowerCanBeBuilt()
		

func loadTowerStats():
	# load from autoload
	pass
	
func checkIfTowerCanBeBuilt() -> void:
	position = get_viewport().get_mouse_position()
	if canBeBuilt:
		modulate = Color(0,1,0)
	else:
		modulate = Color(1,0,0)
	
	
func placeTower() -> bool:
	print ("Place tower!")
	if canBeBuilt:
		built = true
		modulate = Color(1,1,1,1)
	return built

	
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
		# randomly rotate
		if $RandomLookAtTimer.is_stopped():
			$RandomLookAtTimer.start()
		return
	else:
		# target exists!
		$RandomLookAtTimer.stop()
	if not $AnimationPlayer.is_playing():
		$Turret.look_at(target.global_position)
		
func lookAtRandomAngle() -> void:
	var randomAngle = (randf()*2-1)*PI
	$Tween.interpolate_property($Turret, "rotation", 
		$Turret.rotation, randomAngle, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
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
		$AnimationPlayer.play("fire")

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


func _on_RandomLookAtTimer_timeout() -> void:
	pass # Replace with function body.
	lookAtRandomAngle()


func _on_BaseArea_body_entered(body: Node) -> void:
	pass # Replace with function body.
	canBeBuilt = false

func _on_BaseArea_body_exited(body: Node) -> void:
	pass # Replace with function body.
	canBeBuilt = true
