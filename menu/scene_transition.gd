extends CanvasLayer

func _ready() -> void:
	$ColorRect.visible = false

func load_scene(target_scene: String)->void:
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target_scene)
	$AnimationPlayer.play_backwards("fade")

func reload_scene()->void:
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().reload_current_scene()
	$AnimationPlayer.play_backwards("fade")
