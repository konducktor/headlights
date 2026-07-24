extends Area2D
class_name HurtboxComponent


signal took_damage


@export var entity: CharacterBody2D
@export var health_component: HealthComponent


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func take_damage(damage: int) -> void:
	health_component.take_damage(damage)
	took_damage.emit()


func _on_body_entered(body: Node2D) -> void:
	if body is Projectile:
		var bullet := body as Projectile
		
		if not bullet.weapon.entity or not entity:
			return
		
		var cond1: bool = (bullet.weapon.entity is Player) and (entity is Enemy)
		var cond2: bool = (bullet.weapon.entity is Enemy) and (entity is Player)
		
		if cond1 or cond2:
			take_damage(body.damage)
