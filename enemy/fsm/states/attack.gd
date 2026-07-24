@tool
## During this state the enemy tries to fire its weapon. Exit if the enemy is outside of range (controlled by min and max distances). Debug visuals are yellow.
extends EnemyState
class_name EnemyStateAttack


@export var min_distance: float
@export var max_distance: float
@export var attack_component: AttackComponent

@export var is_exit_if_no_los: bool = false
@export var los_component: LOSComponent

@export_group("Exits")
@export var exit_if_distance_far: EnemyState
@export var exit_if_distance_short: EnemyState
@export var exit_if_no_los: EnemyState


func physics_update(_delta: float) -> EnemyState:
	if is_exit_if_no_los and not los_component.is_los_between_points(enemy.position, player.body_pos()):
		return exit_if_no_los
	
	var distance: float = enemy.position.distance_to(player.body_pos())
	
	if distance >= max_distance:
		return exit_if_distance_far
	
	if distance <= min_distance:
		return exit_if_distance_short
	
	attack_component.point_in_direction(enemy.position.direction_to(player.body_pos()))
	attack_component.fire()
	
	return null


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, min_distance, Color.YELLOW, false, 1.0)
		draw_circle(Vector2.ZERO, max_distance, Color.YELLOW, false, 1.0)
