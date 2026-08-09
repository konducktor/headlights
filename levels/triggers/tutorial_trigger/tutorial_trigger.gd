extends Area2D


@export_multiline var text: String


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.tutorial_show.emit(text)
