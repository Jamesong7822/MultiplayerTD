extends PathFollow2D

export (float) var speed
export (float) var health
export (int) var level
export (float) var baseDamage

var currentHealth
var isDead = false

signal reachEnd(damage)

func _ready() -> void:
	pass
	currentHealth = health
	# TODO: level scaling
	_levelScale()
	
func _physics_process(delta: float) -> void:
	if not isDead:
		offset = offset + delta*speed
	if unit_offset > 1.0:
		# emit signal
		emit_signal("reachEnd", baseDamage)
		
func takeDamage(damage: float) -> void:
	currentHealth -= damage
	if currentHealth < 0:
		kill()
		
func kill() -> void:
	# TODO death effects
	$KinematicBody2D.queue_free()
	isDead = true
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
		
func _levelScale():
	pass
	

