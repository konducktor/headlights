extends Area2D


@export var required_enemies: Array[Enemy]

var _in_area: bool
var _killed_enemy_count: int


func _ready() -> void:
	_in_area = false
	_killed_enemy_count = 0
	
	for enemy in required_enemies:
		enemy.died.connect(_on_enemy_died)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_in_area = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		_in_area = false


func _on_enemy_died() -> void:
	_killed_enemy_count += 1
	
	if _killed_enemy_count == len(required_enemies):
		Global.level_finished.emit()
