extends Skill
class_name SkillDrainMe


@export_range(0.0, 1.0) var factor_chance_percent: float = 0
@export var regenerate_amount: int

var rng := RandomNumberGenerator.new()


static var chance: float = 0


func _ready() -> void:
	if chance == 0:
		chance = factor_chance_percent
	else:
		chance *= (1 + factor_chance_percent)


func apply() -> void:
	chance *= factor_chance_percent
	Global.enemy_died.connect(_on_enemy_died)


func _on_enemy_died() -> void:
	if rng.randf() <= chance:
		context.health.regenerate(regenerate_amount)
