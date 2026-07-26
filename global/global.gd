extends Node


signal tutorial_show
signal level_finished

signal paused
signal unpaused

signal player_died
signal enemy_died

signal player_health_changed(new_value: int)
signal player_took_damage(amount: int)
signal player_regenerated(amount: int)

signal player_max_health_changed(new_value: int)
signal player_max_health_increased(amount: int)
signal player_max_health_decreased(amount: int)

signal bossfight_started(enemy: Enemy)


var player: Player

func _ready() -> void:
	player_died.connect(_on_player_died)


func _on_player_died() -> void:
	SceneTransition.reload_scene()


func set_pause(value: bool) -> void:
	get_tree().paused = value
	
	if value:
		paused.emit()
	else:
		unpaused.emit()
