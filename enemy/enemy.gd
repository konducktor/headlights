extends CharacterBody2D
class_name Enemy


@export var active: bool = false
@export var movement_speed: float

var player: Player


func _ready() -> void:
	player = Global.player


func _process(_delta: float) -> void:
	move_and_slide()
