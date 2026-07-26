extends Node


@export var heart_ui_scene: PackedScene
@export var level_controller: LevelConrtoller

var _player_health: int
var _player_max_health: int

var _animation_player: AnimationPlayer
var _heart_container: HBoxContainer


func _ready() -> void:
	_animation_player = $AnimationPlayer
	_heart_container = $CanvasLayer/Control/Health/MarginContainer/HBoxContainer
	
	_player_health = 10
	_player_max_health = 10
	setup_health_ui()
	
	Global.player_health_changed.connect(_on_player_health_changed)
	Global.player_max_health_changed.connect(_on_player_max_health_changed)
	
	Global.paused.connect(_on_paused)
	Global.unpaused.connect(_on_unpaused)
	
	Global.level_finished.connect(_on_level_finished)


func _on_player_health_changed(new_value: int) -> void:
	_player_health = new_value
	setup_health_ui()


func _on_player_max_health_changed(new_value: int) -> void:
	_player_max_health = new_value
	_player_health = clamp(_player_health, 0, _player_max_health)
	setup_health_ui()


func setup_health_ui() -> void:
	var previous_hearts: Array[HeartUI.HeartTypes]
	for child in _heart_container.get_children():
		var heart := child as HeartUI
		previous_hearts.append(heart.heart_type)
		heart.queue_free()
	
	var prev_heart_idx: int = 0
	
	@warning_ignore("integer_division")
	for i in (_player_health / 2):
		_add_heart_to_container(HeartUI.HeartTypes.FULL, previous_hearts[prev_heart_idx])
		prev_heart_idx += 1
	
	if _player_health % 2 != 0:
		_add_heart_to_container(HeartUI.HeartTypes.HALF, previous_hearts[prev_heart_idx])
		prev_heart_idx += 1
	
	@warning_ignore("integer_division")
	for i in ((_player_max_health - _player_health) / 2):
		_add_heart_to_container(HeartUI.HeartTypes.NONE, previous_hearts[prev_heart_idx])
		prev_heart_idx += 1
	
	for i in (len(previous_hearts) - prev_heart_idx):
		_add_heart_to_container(HeartUI.HeartTypes.REMOVED, previous_hearts[prev_heart_idx])


func _add_heart_to_container(type: HeartUI.HeartTypes, previous_type: HeartUI.HeartTypes) -> HeartUI:
	var heart: HeartUI = heart_ui_scene.instantiate()
	heart.set_heart(type, previous_type)
	_heart_container.add_child(heart)
	
	return heart


func _on_paused() -> void:
	_animation_player.play("paused")


func _on_unpaused() -> void:
	_animation_player.play("unpaused")


func _on_level_finished() -> void:
	_animation_player.play("level_end")


func next_level() -> void:
	level_controller.next_level()
