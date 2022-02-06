extends PathFollow2D

export (float) var speed
export (float) var health
export (int) var level
export (float) var baseDamage

const DAMAGE_EFFECT = preload("res://Scenes/Enemies/DamageEffect.tscn")

var currentHealth
var isDead = false

signal reachEnd(damage)

func _ready() -> void:
	pass
	$HealthBar.set_as_toplevel(true)
	currentHealth = health
	# TODO: level scaling
	_levelScale()
	$HealthBar._setMaxValue(currentHealth)
	
	
	
func _physics_process(delta: float) -> void:
	$HealthBar.rect_position = global_position + Vector2(-25, -25)
	if not isDead:
		offset = offset + delta*speed
	if unit_offset > 1.0:
		# emit signal
		emit_signal("reachEnd", baseDamage)
		
func takeDamage(damage: float) -> void:
	currentHealth -= damage
	# update the healthbar
	$HealthBar._updateValue(currentHealth)
	# do a random spawn of the damage effect
	var offsetX = 0.8*(randf()*2-1)*$KinematicBody2D/CollisionShape2D.shape.radius
	var offsetY = 0.8*(randf()*2-1)*$KinematicBody2D/CollisionShape2D.shape.radius
	var randomPos = global_position + Vector2(offsetX, offsetY)
	$DamageEffect.global_position = randomPos
	$DamageEffect.showDamageEffect()
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
	

