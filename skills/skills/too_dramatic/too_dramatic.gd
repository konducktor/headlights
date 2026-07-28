extends Skill
class_name SkillTooDramatic


func apply() -> void:
	context.attack.weapon.damage += 2


func remove() -> void:
	context.attack.weapon.damage -= 2
	super()
