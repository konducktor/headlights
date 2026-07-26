extends GameSounds


@export var step: AudioStreamPlayer
@export var hurt: AudioStreamPlayer
@export var knife: AudioStreamPlayer


var is_walking: bool


func _ready() -> void:
	is_walking = false


func _on_player_started_walking() -> void:
	is_walking = true


func _on_player_stopped_walking() -> void:
	is_walking = false


func _process(_delta: float) -> void:
	if is_walking:
		play_sound(step, random_pitch(0.8, 1.2))


func _on_health_component_took_damage(_amount: int) -> void:
	play_sound(hurt, random_pitch())


func _on_health_component_max_health_decreased(_amount: int) -> void:
	play_sound(hurt, random_pitch())
	play_sound(knife, random_pitch())
