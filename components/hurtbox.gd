extends Area2D
class_name HurtboxComponent


signal took_damage(projectile: Projectile)


@export var entity: CharacterBody2D
@export var health_component: HealthComponent


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func take_damage(damage: int, projectile: Projectile = null) -> void:
	health_component.take_damage(damage)
	took_damage.emit(projectile)


func _on_body_entered(body: Node2D) -> void:
	if body is Projectile:
		var projectile := body as Projectile
		
		if not projectile.weapon or not entity:
			return
		
		var cond1: bool = (projectile.weapon.entity is Player) and (entity is Enemy)
		var cond2: bool = (projectile.weapon.entity is Enemy) and (entity is Player)
		
		if cond1 or cond2:
			take_damage(projectile.weapon.damage, projectile)
			projectile.hit(entity)
