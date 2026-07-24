extends DebugDrawing
class_name DebugVector


var start_global_pos: Vector2
var vector: Vector2


func _init (in_start_global_pos: Vector2, in_vector: Vector2, in_color: Color) -> void:
	start_global_pos = in_start_global_pos
	vector = in_vector
	color = in_color
