extends GameSounds


@export var step_hospital: AudioStreamPlayer


var is_walking: bool


func _ready() -> void:
	is_walking = false


func _on_player_started_walking() -> void:
	is_walking = true


func _on_player_stopped_walking() -> void:
	is_walking = false


func _process(_delta: float) -> void:
	if is_walking:
		play_sound(step_hospital, random_pitch(0.8, 1.2))
