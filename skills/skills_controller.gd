extends Node


var context: SkillsContext
var container: Node

func _ready() -> void:
	context = $Context
	container = $Container
	
	GlobalSkills.apply_skill.connect(_on_apply_skill)
	
	for child in container.get_children():
		if child is Skill:
			child.context = context
			child.apply()


func add_skill(skill_data: SkillData) -> void:
	var skill: Skill = skill_data.skill.instantiate()
	container.add_child(skill)
	
	skill.skill_data = skill_data
	skill.context = context
	skill.apply()


func _on_apply_skill(skill: SkillData) -> void:
	context.health.change_max_health(-2)
	add_skill(skill)
