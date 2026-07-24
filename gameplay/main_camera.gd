extends Camera2D


var player: Player


func _ready() -> void:
	player = Global.player

func _process(delta: float) -> void:
	if player == null:
		player = Global.player
		return
	
	position = lerp(position, player.position, 0.9)
