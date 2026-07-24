@tool
extends Node2D


var drawings: Array[DebugDrawing]

func draw_point(point: Vector2, color: Color = Color.DARK_ORANGE) -> void:
	drawings.append(DebugPoint.new(point, color))
	queue_redraw()

func draw_vector(start_global_pos: Vector2, vector: Vector2, color: Color = Color.DARK_ORANGE) -> void:
	drawings.append(DebugVector.new(start_global_pos, vector, color))
	queue_redraw()


func _ready() -> void:
	z_index = 4096


func _draw() -> void:
	for drawing in drawings:
		if drawing is DebugPoint:
			draw_circle(drawing.point, 10.0, drawing.color)
		
		if drawing is DebugVector:
			draw_line(
				drawing.start_global_pos, 
				drawing.start_global_pos + drawing.vector, 
				drawing.color, 5.0
			)
	
	drawings = []
