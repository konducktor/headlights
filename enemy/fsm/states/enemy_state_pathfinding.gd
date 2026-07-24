@abstract
## Base class for all states that want to use pathfinging.
extends EnemyState
class_name EnemyStatePathfinding

@export var pathfinding_component: PathfindingComponent
@export var navigation_update_timer: Timer

func enter() -> void:
	navigation_update_timer.timeout.connect(_on_navigation_update)
	navigation_update_timer.start()
	super()


func exit() -> void:
	navigation_update_timer.timeout.disconnect(_on_navigation_update)
	super()

@abstract
func _on_navigation_update() -> void
