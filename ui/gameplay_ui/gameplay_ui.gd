extends Node


@export var heart_ui_scene: PackedScene
@export var level_controller: LevelConrtoller

var _player_health: Health
var _yourself_health: Health

var _animation_player: AnimationPlayer


func _ready() -> void:
	_animation_player = $AnimationPlayer
	
	Global.paused.connect(_on_paused)
	Global.unpaused.connect(_on_unpaused)
	
	Global.level_finished.connect(_on_level_finished)
	Global.bossfight_started.connect(_on_bossfight_started)
	
	await get_tree().process_frame
	_yourself_health = $CanvasLayer/Control/YourselfHealth
	_player_health = $CanvasLayer/Control/PlayerHealth
	_player_health.health_component = Global.player.health_component


func _on_paused() -> void:
	_animation_player.play("paused")


func _on_unpaused() -> void:
	_animation_player.play("unpaused")


func _on_level_finished() -> void:
	_animation_player.play("level_end")


func _on_bossfight_started(enemy: Enemy) -> void:
	_yourself_health.health_component = enemy.health_component


func next_level() -> void:
	level_controller.next_level()
