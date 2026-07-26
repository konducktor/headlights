extends Control


var _animation_player: AnimationPlayer


func _ready() -> void:
	visible = false
	_animation_player = $AnimationPlayer
	
	await get_tree().process_frame # :(
	
	Global.player.got_stuck.connect(_on_player_got_stuck)
	Global.player.got_unstuck.connect(_on_player_got_unstuck)


func _on_player_got_stuck() -> void:
	start()


func _on_player_got_unstuck() -> void:
	stop()


func start() -> void:
	visible = true
	_animation_player.play("spam_dash")


func stop() -> void:
	visible = false
	_animation_player.stop()
