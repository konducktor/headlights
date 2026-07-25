extends Control
class_name SkillSelectCard


@export var name_label: Label
@export var desc_label: Label
@export var icon_texture: TextureRect

var skill_data: SkillData


func set_card(data: SkillData) -> void:
	skill_data = data
	
	name_label.text = data.name
	desc_label.text = data.description
	icon_texture.texture = data.icon


func _on_button_pressed() -> void:
	GlobalSkills.apply_skill.emit(skill_data)
