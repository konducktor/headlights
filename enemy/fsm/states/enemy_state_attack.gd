extends EnemyState
class_name EnemyStateAttack


@export var min_distance: float
@export var max_distance: float
@export var attack_component: AttackComponent

@export_group("Exits")
@export var exit_if_distance_change: EnemyState


func physics_update(_delta: float) -> EnemyState:
	var distance: float = enemy.position.distance_to(player.position)
	if distance > max_distance or distance < min_distance:
		return exit_if_distance_change
	
	attack_component.point_in_direction(enemy.position.direction_to(player.position))
	attack_component.fire()
	
	return null
