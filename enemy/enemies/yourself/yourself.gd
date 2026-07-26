extends Enemy


var health_component: HealthComponent


func _ready() -> void:
	health_component = $HealthComponent
	visible = false


func _on_health_component_died() -> void:
	Global.level_finished.emit()
	super()


func activate() -> void:
	visible = true
	Global.bossfight_started.emit(self)
	super()
