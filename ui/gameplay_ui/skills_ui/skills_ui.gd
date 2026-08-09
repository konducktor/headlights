extends Control


var _skills_icon_container: Control


func _ready() -> void:
	_skills_icon_container = %SkillsIconContainer
	
	GlobalSkills.apply_skill.connect(_on_apply_skill)


func _on_apply_skill(skill: SkillData) -> void:
	var new_icon: TextureRect = TextureRect.new()
	new_icon.texture = skill.icon
	
	_skills_icon_container.add_child(new_icon)
