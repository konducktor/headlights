extends Node
class_name LevelConrtoller


@export var levels_in_order: Array[PackedScene]
@export var after_finishing_all_levels_transition_to: String
@export_range(0, 2) var initial_level: int = 0
var current_level: int = 0


func _ready() -> void:
	current_level = initial_level
	spawn_level(levels_in_order[current_level])


func spawn_level(scene: PackedScene) -> Node2D:
	for child in get_children():
		child.queue_free()
	
	var level: Node2D = scene.instantiate() as Node2D
	add_child(level)
	
	return level


func next_level() -> void:
	current_level += 1
	
	if current_level == len(levels_in_order):
		SceneTransition.load_scene(after_finishing_all_levels_transition_to)
	else:
		spawn_level(levels_in_order[current_level])
