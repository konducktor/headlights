extends Node2D
class_name EnemyStateMachine


@export var initial_state: EnemyState
@export var enemy: Enemy
@export var report_current_state: bool = false

var current_state: EnemyState


func _ready() -> void:
	for state in get_children():
		if state is not EnemyState:
			continue
		
		state.enemy = enemy
		state.player = Global.player
	
	if enemy.active:
		change_state(initial_state)


func _physics_process(delta: float) -> void:
	if not enemy.active:
		return
	
	if report_current_state:
		print(current_state.name)
	
	change_state(current_state.physics_update(delta))

func change_state(new_state: EnemyState) -> void:
	if new_state == null:
		return
	
	if current_state != null:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
