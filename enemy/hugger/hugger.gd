extends Enemy
class_name Hugger


var player_hugged: bool


func _ready() -> void:
	player_hugged = false
	super()


func _on_enemy_state_grab_entered() -> void:
	player_hugged = true


func _on_enemy_state_chasing_entered() -> void:
	player_hugged = true



func _on_health_component_died() -> void:
	if player_hugged:
		player.free_from_stuck()
