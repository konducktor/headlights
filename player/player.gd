extends CharacterBody2D
class_name Player


@export_group("Movement")
@export var max_speed: float
@export var time_to_max_speed: float
@export var time_to_zero: float

const _TARGET: float = 0.99
var _acceleration: float
var _friction: float

var _attack_component: AttackComponent


func _ready() -> void:
	_attack_component = $AttackComponent


func _physics_process(delta: float) -> void:
	move_player(delta)
	point_weapon_in_direction(delta)


func point_weapon_in_direction(delta: float) -> void:
	var attack_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	_attack_component.point_in_direction(attack_direction)
	
	if Input.is_action_just_pressed("player_fire_primary"):
		_attack_component.fire()


func move_player(delta: float) -> void:
	_acceleration = -log(1.0 - _TARGET) / time_to_max_speed
	_friction = -log(1.0 - _TARGET) / time_to_zero
	
	var direction: Vector2 = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	var velocity_weight_x: float = 1.0 - exp(-(_acceleration if direction.x else _friction) * delta)
	velocity.x = lerp(velocity.x, direction.x * max_speed, velocity_weight_x)
	
	var velocity_weight_y: float = 1.0 - exp(-(_acceleration if direction.y else _friction) * delta)
	velocity.y = lerp(velocity.y, direction.y * max_speed, velocity_weight_y)
	
	move_and_slide()


func _on_health_component_died() -> void:
	Global.player_died.emit()

func _on_health_component_health_changed(new_value: int) -> void:
	Global.player_health_changed.emit(new_value)

func _on_health_component_max_health_changed(new_value: int) -> void:
	Global.player_max_health_changed.emit(new_value)

func _on_health_component_max_health_decreased(amount: int) -> void:
	Global.player_max_health_decreased.emit(amount)

func _on_health_component_max_health_increased(amount: int) -> void:
	Global.player_max_health_increased.emit(amount)

func _on_health_component_regenerated(amount: int) -> void:
	Global.player_regenerated.emit(amount)

func _on_health_component_took_damage(amount: int) -> void:
	Global.player_took_damage.emit(amount)
