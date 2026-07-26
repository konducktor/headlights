extends GameSounds


@export var home: AudioStreamPlayer


func _ready() -> void:
	Global.bossfight_started.connect(_on_bossfight_sterted)


func _on_bossfight_sterted(_enemy: Enemy) -> void:
	play_sound(home)
