extends Enemy
class_name Hugger


var enemy_state_machine: EnemyStateMachine


func _ready() -> void:
	enemy_state_machine = $EnemyStateMachine


func clear_grab_and_queue_free() -> void:
	if (enemy_state_machine.current_state is EnemyStateGrab) or (enemy_state_machine.current_state is EnemyStateAttack):
		Global.player.free_from_stuck()
	
	queue_free()
