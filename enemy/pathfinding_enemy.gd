@abstract
extends Enemy
class_name PathfindingEnemy


var pathfinding_component: PathfindingComponent
var navigation_update_timer: Timer


func _ready() -> void:
	pathfinding_component = $PathfindingComponent
	#pathfinding_component.set_target(calc_pathfinding_target())
	
	navigation_update_timer = $NavigationUpdateTimer
	navigation_update_timer.timeout.connect(_on_navigation_update_timer_timeout)
	navigation_update_timer.start()
	
	super()


func _physics_process(_delta: float) -> void:
	velocity = pathfinding_component.calc_direction() * movement_speed
	move_and_slide()


func _on_navigation_update_timer_timeout() -> void:
	pathfinding_component.set_target(calc_pathfinding_target())
	navigation_update_timer.start()


@abstract
func calc_pathfinding_target() -> Vector2
