extends Projectile


func _on_deflect_area_body_entered(body: Node2D) -> void:
	if body is not Projectile:
		return
	
	var projectile := body as Projectile
	var knife := weapon as Knife

	if knife.deflect:
		projectile.direction_degrees = direction_degrees
		projectile.weapon = weapon
		#print(projectile.weapon.entity)
