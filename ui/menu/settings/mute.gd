extends CheckBox

@export var audio_bus_name: String

var audio_bus_idx: int

func _ready() -> void:
	audio_bus_idx = 	AudioServer.get_bus_index(audio_bus_name)



func _on_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(audio_bus_idx, toggled_on)
