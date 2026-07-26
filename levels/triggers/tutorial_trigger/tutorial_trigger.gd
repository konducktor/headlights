extends Area2D


@export var text: String


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.tutorial_show.emit(text)
