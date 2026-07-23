extends Area2D
class_name HurtboxComponent


@export var health_component: HealthComponent


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func take_damage(damage: int) -> void:
	health_component.take_damage(damage)


func _on_body_entered(body: Node2D) -> void:
	if (body is Projectile):
		take_damage(body.damage)
