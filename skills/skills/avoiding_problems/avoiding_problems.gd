extends Skill
class_name AvoidingProblems


func apply() -> void:
	context.player.started_dashing.connect(_on_player_started_dashing)
	context.player.stopped_dashing.connect(_on_player_stopped_dashing)


func remove() -> void:
	context.player.started_dashing.disconnect(_on_player_started_dashing)
	context.player.stopped_dashing.disconnect(_on_player_stopped_dashing)
	
	context.health.set_invincibility(false)
	super()


func _on_player_started_dashing() -> void:
	context.health.set_invincibility(true)


func _on_player_stopped_dashing() -> void:
	context.health.set_invincibility(false)
