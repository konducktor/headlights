@tool
## During this state the enemy pathfinds while has line of sight with the player. Exits if reached its target or los is lost. Debug visuals are red.
extends EnemyStatePathfinding
class_name EnemyStateChasing


@export var reach_threshhold: float
@export var target_scatter_radius: float = 0.0
@export var los_component: LOSComponent
@export var acceleration_component: AccelerationComponent

@export_group("Exits")
@export var exit_if_reached: EnemyState
@export var exit_if_los_lost: EnemyState

var rng := RandomNumberGenerator.new()


func physics_update(delta: float) -> EnemyState:
	if player == null:
		return null
	
	if not los_component.is_los_between_points(enemy.position, player.body_pos()):
		return exit_if_los_lost
	
	if enemy.position.distance_to(player.body_pos()) <= reach_threshhold:
		return exit_if_reached
	
	enemy.velocity = acceleration_component.smooth_vector(
		enemy.velocity, pathfinding_component.calc_direction() * enemy.movement_speed, delta
	)
	return null


func _on_navigation_update() -> void:
	pathfinding_component.set_target(player.body_pos() + _scatter_vector(target_scatter_radius))


func _scatter_vector(radius: float) -> Vector2:
	return Vector2.UP.rotated(rng.randf_range(-180.0, 180.0)) * radius

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, reach_threshhold, Color.RED, false, 1.0)
