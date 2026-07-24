extends CharacterBody2D
class_name Player


enum PlayerState {
	DEFAULT, DASH, DIE, STUCK
}

var player_state: PlayerState

@export var max_speed: float
@export var dash_speed: float
@export var dashes_to_escape: int

var can_dash: bool
var dash_timer: Timer
var dash_cooldown_timer: Timer
var dash_direction: Vector2

var dashes_while_stuck: int

var _attack_component: AttackComponent
var _acceleration_component: AccelerationComponent
var _hurtbox_collision: CollisionShape2D


func _ready() -> void:
	_attack_component = $AttackComponent
	_acceleration_component = $AccelerationComponent
	_hurtbox_collision = $HurtboxComponent/CollisionShape2D
	
	dash_timer = $DashTimer
	dash_timer.timeout.connect(_on_dash_timer_timeout)
	
	can_dash = true
	dash_cooldown_timer = $DashCooldownTimer
	dash_cooldown_timer.timeout.connect(_on_dash_cooldown_timer_timeout)
	
	player_state = PlayerState.DEFAULT
	
	Global.player = self


func _physics_process(delta: float) -> void:
	if player_state != PlayerState.STUCK:
		point_weapon_in_direction(delta)
	
	var movement_dir: Vector2 = Input.get_vector(
		"player_left", "player_right", "player_up", "player_down")
	
	match player_state:
		PlayerState.DEFAULT:
			velocity = _acceleration_component.smooth_vector(velocity, movement_dir * max_speed, delta)
			
			if Input.is_action_just_pressed("player_dash") and can_dash:
				dash(movement_dir)
		
		PlayerState.DASH:
			velocity = dash_direction * dash_speed
		
		PlayerState.STUCK:
			if Input.is_action_just_pressed("player_dash"):
				dashes_while_stuck += 1
				
				if dashes_while_stuck == dashes_to_escape:
					dash(movement_dir)
	
	move_and_slide()


func body_pos() -> Vector2:
	return _hurtbox_collision.global_position

func point_weapon_in_direction(_delta: float) -> void:
	var attack_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	_attack_component.point_in_direction(attack_direction)
	
	if Input.is_action_just_pressed("player_fire_primary"):
		_attack_component.fire()


func dash(direction: Vector2) -> void:
	dash_direction = Vector2.RIGHT
	if direction != Vector2.ZERO:
		dash_direction = direction
	
	player_state = PlayerState.DASH
	dash_timer.start()


func make_stuck() -> void:
	velocity = Vector2.ZERO
	player_state = PlayerState.STUCK
	dashes_while_stuck = 0


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
