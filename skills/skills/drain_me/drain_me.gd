extends Skill
class_name SkillDrainMe


@export var regenerate_amount: int


func apply() -> void:
	Global.enemy_died.connect(_on_enemy_died)


func remove() -> void:
	queue_free()


func _on_enemy_died() -> void:
	context.health.regenerate(regenerate_amount)
