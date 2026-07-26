extends GameSounds


@export var swoosh: AudioStreamPlayer


func _on_knife_fired(_projectile: Projectile) -> void:
	play_sound(swoosh, random_pitch())
