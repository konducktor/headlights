extends CharacterBody2D
class_name Projectile


@export_range(-180.0, 180.0) var direction_degrees: float
@export var speed: float


var weapon: Weapon

var _living_timer: Timer
var _active: bool


func _ready() -> void:
	_active = false
	
	_living_timer = $LivingTimer
	_living_timer.start()
	_living_timer.timeout.connect(_on_living_timer_timeout)


func stop() -> void:
	queue_free()


func _physics_process(_delta: float) -> void:
	global_rotation_degrees = direction_degrees
	
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	move_and_slide()


func _on_living_timer_timeout() -> void:
	stop()


func hit(entity: CharacterBody2D) -> void:
	weapon.hit.emit(entity)
