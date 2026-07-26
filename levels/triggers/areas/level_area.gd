extends Area2D


@export var enemies_in_this_area: Array[Enemy]

var active: bool


func _ready() -> void:
	active = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player and active:
		set_all_enemies_activation(true)
		active = false


func set_all_enemies_activation(value: bool) -> void:
	for enemy in enemies_in_this_area:
		if enemy != null:
			enemy.active = value
