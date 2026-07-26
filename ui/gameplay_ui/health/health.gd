extends Control
class_name Health


@export var health_component: HealthComponent

@export var heart_ui_scene: PackedScene
@export var distance_between: float

var _heart_container: Node
var _setup: bool


func _ready() -> void:
	_heart_container = $MarginContainer/HeartContainer
	_setup = false


func _physics_process(_delta: float) -> void:
	if health_component == null || _setup:
		return
	
	health_component.health_changed.connect(_on_health_changed)
	health_component.max_health_changed.connect(_on_max_health_changed)
	setup_health_ui()
	
	_setup = true


func _on_health_changed(new_value: int) -> void:
	health_component.current_health = new_value
	setup_health_ui()


func _on_max_health_changed(new_value: int) -> void:
	health_component.max_health = new_value
	health_component.current_health = clamp(health_component.current_health, 0, health_component.max_health)
	setup_health_ui()


func setup_health_ui() -> void:
	var previous_hearts: Array[HeartUI.HeartTypes]
	for child in _heart_container.get_children():
		var heart := child as HeartUI
		previous_hearts.append(heart.heart_type)
		heart.queue_free()
	
	if len(previous_hearts) == 0:
		@warning_ignore("integer_division")
		for i in health_component.max_health / 2:
			previous_hearts.append(HeartUI.HeartTypes.REMOVED)
	
	var prev_heart_idx: int = 0
	
	@warning_ignore("integer_division")
	for i in (health_component.current_health / 2):
		_add_heart_to_container(HeartUI.HeartTypes.FULL, previous_hearts[prev_heart_idx])
		prev_heart_idx += 1
	
	if health_component.current_health % 2 != 0:
		_add_heart_to_container(HeartUI.HeartTypes.HALF, previous_hearts[prev_heart_idx])
		prev_heart_idx += 1
	
	@warning_ignore("integer_division")
	for i in ((health_component.max_health - health_component.current_health) / 2):
		_add_heart_to_container(HeartUI.HeartTypes.NONE, previous_hearts[prev_heart_idx])
		prev_heart_idx += 1
	
	for i in (len(previous_hearts) - prev_heart_idx):
		_add_heart_to_container(HeartUI.HeartTypes.REMOVED, previous_hearts[prev_heart_idx])


func _add_heart_to_container(type: HeartUI.HeartTypes, previous_type: HeartUI.HeartTypes) -> HeartUI:
	var heart: HeartUI = heart_ui_scene.instantiate()
	heart.set_heart(type, previous_type)
	_heart_container.add_child(heart)
	
	return heart
