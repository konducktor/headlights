extends Node
class_name LOSComponent


@export var ray: RayCast2D


func is_los_between_points(start: Vector2, end: Vector2) -> bool:
	ray.global_position = start
	ray.target_position = end - start
	
	return not ray.is_colliding()


func is_los_between_nodes(start: Node2D, end: Node2D) -> bool:
	ray.global_position = start.global_position
	ray.target_position = end.global_position - start.global_position
	
	return not ray.is_colliding()
