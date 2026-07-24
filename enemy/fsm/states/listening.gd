@tool
## During this state the enemy stands still and waits until the player is inside of its range and has line of sight. Debug visuals are green.
extends EnemyState
class_name EnemyStateListening


@export var found_radius: float
@export var found_if_has_los: bool = true
@export var los_component: LOSComponent

@export_group("Exits")
@export var exit_if_found: EnemyState


func physics_update(_delta: float) -> EnemyState:
	var distance: float = enemy.position.distance_to(player.body_pos())
	if distance <= found_radius:
		if los_component.is_los_between_points(player.body_pos(), enemy.position) or not found_if_has_los:
			return exit_if_found
	
	return null

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, found_radius, Color.GREEN, false, 1.0)
