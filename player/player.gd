extends CharacterBody2D
class_name Player


enum PlayerState {
	DEFAULT, DASH, DIE
}

var player_state: PlayerState

@export_group("Movement")
@export var max_speed: float

@export_group("Dash")
@export var dash_speed: float
@export

var can_dash: bool
var dash_timer: Timer
var dash_cooldown_timer: Timer
var dash_direction: Vector2

var _attack_component: AttackComponent
var _acceleration_component: AccelerationComponent


func _ready() -> void:
	_attack_component = $AttackComponent
	
	_acceleration_component = $AccelerationComponent
	#_acceleration_component.time_to_max = time_to_max_speed
	#_acceleration_component.time_to_zero = time_to_zero
	
	dash_timer = $DashTimer
	dash_timer.timeout.connect(_on_dash_timer_timeout)
	
	can_dash = true
	dash_cooldown_timer = $DashCooldownTimer
	dash_cooldown_timer.timeout.connect(_on_dash_cooldown_timer_timeout)
	
	player_state = PlayerState.DEFAULT
	
	Global.player = self


func _physics_process(delta: float) -> void:
	point_weapon_in_direction(delta)
	
	var movement_dir: Vector2 = Input.get_vector(
		"player_left", "player_right", "player_up", "player_down")
	
	match player_state:
		PlayerState.DEFAULT:
			velocity = _acceleration_component.smooth_vector(velocity, movement_dir * max_speed, delta)
			
			if Input.is_action_just_pressed("player_dash") and can_dash:
				dash_direction = Vector2.RIGHT
				if movement_dir != Vector2.ZERO:
					dash_direction = movement_dir
				
				player_state = PlayerState.DASH
				dash_timer.start()
		
		PlayerState.DASH:
			velocity = dash_direction * dash_speed
	
	move_and_slide()


func point_weapon_in_direction(_delta: float) -> void:
	var attack_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	_attack_component.point_in_direction(attack_direction)
	
	if Input.is_action_just_pressed("player_fire_primary"):
		_attack_component.fire()


func _on_dash_timer_timeout() -> void:
	if player_state == PlayerState.DASH:
		player_state = PlayerState.DEFAULT
		
		can_dash = false
		dash_cooldown_timer.start()


func _on_dash_cooldown_timer_timeout() -> void:
	can_dash = true


func _on_health_component_died() -> void:
	player_state = PlayerState.DIE
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
