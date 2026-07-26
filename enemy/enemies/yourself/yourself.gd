extends Enemy


func _on_health_component_died() -> void:
	Global.level_finished.emit()
	super()
