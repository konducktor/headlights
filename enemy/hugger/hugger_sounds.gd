extends GameSounds


@export var death: AudioStreamPlayer


func _on_health_component_died() -> void:
	play_sound(death, random_pitch())
