extends Skill
class_name Painkiller


@export var base_invincibility_time: float
@export var additional_time: float

static var _timer: float


func apply() -> void:
	context.attack.weapon.hit.connect(_on_attack_hit)


func remove() -> void:
	context.attack.weapon.hit.disconnect(_on_attack_hit)
	super()


func _on_attack_hit(_entity: CharacterBody2D) -> void:
	context.health.set_invincibility(true)
	
	if _timer <= 0:
		_timer = base_invincibility_time
	else:
		_timer += additional_time


func _physics_process(delta: float) -> void:
	if _timer <= 0:
		return
	
	_timer -= delta
	
	if _timer <= 0:
		context.health.set_invincibility(false)
