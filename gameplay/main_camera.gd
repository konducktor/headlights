extends Camera2D


@export var transition_delay: float
@export var transition_duration: float

@export var level_start_pos: Marker2D
@export var level_start_zoom: float = 1.0

@export var player_zoom: float = 1.0


var _progress: float

func _ready() -> void:
	position = level_start_pos.position
	zoom = Vector2.ONE * level_start_zoom
	
	_progress = 0.0
	
	var twin := create_tween()
	twin.tween_property(self, "_progress", 1.0, transition_duration) \
		.set_delay(transition_delay) \
		.set_trans(Tween.TRANS_EXPO)


func _process(_delta: float) -> void:
	if _progress == 0.0:
		return
	
	if _progress == 1.0:
		position = Global.player.body_pos()
		return
	
	position = lerp(level_start_pos.position, Global.player.body_pos(), _progress)
	zoom = Vector2.ONE * lerp(level_start_zoom, player_zoom, _progress)
