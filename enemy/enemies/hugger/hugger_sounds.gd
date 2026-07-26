extends GameSounds


@export var death: AudioStreamPlayer
@export var hurt: AudioStreamPlayer


func _on_health_component_died() -> void:
	play_sound(death, random_pitch())


func _on_health_component_took_damage(_amount: int) -> void:
	play_sound(hurt, random_pitch())
