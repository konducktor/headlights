extends Control


var _animation_player: AnimationPlayer
var _label: Label


func _ready() -> void:
	visible = false
	
	_animation_player = $AnimationPlayer
	_label = $Label
	
	await get_tree().process_frame # :(
	
	Global.player.got_stuck.connect(_on_player_got_stuck)
	Global.player.got_unstuck.connect(_on_player_got_unstuck)
	Global.bossfight_started.connect(_on_bossfight_started)


func _on_player_got_stuck() -> void:
	start()


func _on_player_got_unstuck() -> void:
	stop()


func _on_bossfight_started(_enemy: Enemy) -> void:
	start("YOURSELF")
	await get_tree().create_timer(3).timeout
	stop()


func start(text: String = "SPAM DASH") -> void:
	_label.text = text
	visible = true
	_animation_player.play("spam_dash")


func stop() -> void:
	visible = false
	_animation_player.stop()
