extends Node
class_name AccelerationComponent


@export var time_to_max: float:
	get:
		return time_to_max
	set(value):
		_acceleration = -log(1.0 - _TARGET) / value
		time_to_max = value

@export var time_to_zero: float:
	get:
		return time_to_zero
	set(value):
		_friction = -log(1.0 - _TARGET) / value
		time_to_zero = value

const _TARGET: float = 0.99
var _acceleration: float
var _friction: float


func smooth_vector(current: Vector2, target: Vector2, delta: float) -> Vector2:
	return Vector2 (
		smooth_value(current.x, target.x, delta), 
		smooth_value(current.y, target.y, delta)
	)


func smooth_value(current: Variant, target: Variant, delta: float) -> Variant:
	var weight: float = 1.0 - exp(-(_acceleration if target else _friction) * delta)
	return lerp(current, target, weight)
