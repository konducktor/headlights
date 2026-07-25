extends Skill
class_name SkillBullying


func apply() -> void:
	if context.attack.weapon is Knife:
		context.attack.weapon.deflect = true


func remove() -> void:
	if context.attack.weapon is Knife:
		context.attack.weapon.deflect = false
	
	super()
