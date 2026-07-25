extends CanvasLayer


var health_label: Label
var _player_health: int
var _player_max_health: int

func _ready() -> void:
	health_label = $Control/Health/MarginContainer/HealthLabel
	_player_health = 10
	_player_max_health = 10
	setup_health_label()
	Global.player_health_changed.connect(_on_player_health_changed)
	Global.player_max_health_changed.connect(_on_player_max_health_changed)


func _on_player_health_changed(new_value: int) -> void:
	_player_health = new_value
	setup_health_label()


func _on_player_max_health_changed(new_value: int) -> void:
	_player_max_health = new_value
	_player_health = clamp(_player_health, 0, _player_max_health)
	setup_health_label()


func setup_health_label() -> void:
	health_label.text = ""
	for i in _player_health:
		health_label.text += "<3 "
	for i in _player_max_health - _player_health:
		health_label.text += "0 "
