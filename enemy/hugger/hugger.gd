extends Enemy
class_name Hugger


var player_hugged: bool
var died: bool


func _ready() -> void:
	player_hugged = false
	died = false
	super()


func _on_enemy_state_grab_entered() -> void:
	if died:
		return
	
	player_hugged = true


func _on_enemy_state_chasing_entered() -> void:
	if died:
		return
	
	player_hugged = true



func _on_health_component_died() -> void:
	died = true
	player.free_from_stuck()
	
	super()
