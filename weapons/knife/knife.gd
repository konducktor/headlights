extends DirectedWeapon
class_name Knife


const CLOSE_ATTACK_SCENE: PackedScene = preload("res://weapons/knife/knife_close_attack.tscn")

var _close_attack: Projectile
var _close_attack_timer: Timer

var _cooldown_timer: Timer


func _ready() -> void:
	_close_attack_timer = $CloseAttackTimer
	_close_attack_timer.timeout.connect(_on_close_attack_timer_timeout)
	
	_cooldown_timer = $CooldownTimer
	_cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	can_fire = true


func point_in_direction(vector: Vector2) -> void:
	rotation = vector.angle()


func fire() -> void:
	_close_attack = create_projectile(CLOSE_ATTACK_SCENE)
	_close_attack.direction_degrees = global_rotation_degrees
	
	get_tree().root.remove_child(_close_attack)
	add_child(_close_attack)
	_close_attack.position = Vector2.ZERO
	
	_close_attack_timer.start()
	can_fire = false


func _on_close_attack_timer_timeout() -> void:
	_close_attack.stop()
	_cooldown_timer.start()


func _on_cooldown_timer_timeout() -> void:
	can_fire = true
