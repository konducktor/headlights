extends DebugDrawing
class_name DebugPoint

var point: Vector2

func _init(in_point: Vector2, in_color: Color) -> void:
	point = in_point
	color = in_color
