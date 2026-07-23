extends EnemyState
class_name EnemyStateIdle


func enter() -> void:
	enemy.velocity = Vector2.ZERO
	super()
