extends Skill
class_name SkillSpeedMultiplier


@export var factor: float


func apply() -> void:
	context.player.max_speed *= factor


func remove() -> void:
	context.player.max_speed /= factor
	super()
