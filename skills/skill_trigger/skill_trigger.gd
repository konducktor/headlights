extends Area2D
class_name SkillTrigger


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GlobalSkills.select_skill.emit()
		queue_free()
