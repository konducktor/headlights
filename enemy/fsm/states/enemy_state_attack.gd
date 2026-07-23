extends EnemyState
class_name EnemyStateAttack


@export var attack_component: AttackComponent

@export_group("Exits")
@export var exit_if_fired: EnemyState


func enter() -> void:
	attack_component.point_in_direction(enemy.position.direction_to(player.position))
	attack_component.fire()
	super()


func physics_update(_delta: float) -> EnemyState:
	return exit_if_fired
