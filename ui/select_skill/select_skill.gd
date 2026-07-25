extends Control


@export var cards: Array[SkillSelectCard]

func _ready() -> void:
	visible = false
	GlobalSkills.select_skill.connect(_on_select_skill)
	GlobalSkills.apply_skill.connect(_on_apply_skill)


func _on_select_skill() -> void:
	var skills: Array[SkillData] = GlobalSkills.get_random_skills(3)
	
	for i in range(len(cards)):
		cards[i].set_card(skills[i])
	
	set_active(true)


func _on_apply_skill(_skill: SkillData) -> void:
	set_active(false)


func _on_skip_button_pressed() -> void:
	set_active(false)


func set_active(value: bool) -> void:
	visible = value
	Global.set_pause(value)
