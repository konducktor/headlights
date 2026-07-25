extends Skill
class_name SkillHatredForSociety


@export_range(1.0, 10.0) var factor: float


func apply() -> void:
	context.health.damage_cooldown_timer.wait_time *= factor


func remove() -> void:
	context.health.damage_cooldown_timer.wait_time /= factor
	super()
