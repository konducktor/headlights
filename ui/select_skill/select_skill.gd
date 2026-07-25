extends Control

@export var cards: Array[SkillSelectCard]

func _ready() -> void:
	visible = false
	GlobalSkills.select_skill.connect(_on_select_skill)
	GlobalSkills.apply_skill.connect(_on_apply_skill)


func _on_select_skill() -> void:
	for card in cards:
		var skill_data: SkillData = GlobalSkills.get_random_skill()
		card.set_card(skill_data)
	
	visible = true
	Global.set_pause(true)


func _on_apply_skill(_skill: SkillData) -> void:
	visible = false
	Global.set_pause(false)
