extends Skill
class_name SkillBlankPage


var _amount: int


func apply() -> void:
	_amount = context.health.max_health - context.health.current_health
	context.health.regenerate(_amount)
	queue_free()


func remove() -> void:
	context.health.change_health(-_amount)
