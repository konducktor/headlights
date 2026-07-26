extends Control


var _previous_text: String

var _animation_player: AnimationPlayer
var _label: Label


func _ready() -> void:
	_animation_player = $AnimationPlayer
	_label = $MarginContainer/Label
	
	Global.tutorial_show.connect(_on_tutorial_show)


func show_tutorial_text(text: String) -> void:
	if text == _previous_text:
		return
	
	_label.text = text
	_animation_player.play("tutorial")
	
	_previous_text = text


func _on_tutorial_show(text: String) -> void:
	show_tutorial_text(text)
