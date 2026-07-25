extends Control
class_name HeartUI


enum HeartTypes {
	FULL, HALF, NONE
}


@export var heart: TextureRect
@export var half_heart: TextureRect
@export var no_heart: TextureRect


func set_heart(type: HeartTypes) -> void:
	heart.visible = false
	half_heart.visible = false
	no_heart.visible = false
	
	match type:
		HeartTypes.FULL:
			heart.visible = true
		
		HeartTypes.HALF:
			half_heart.visible = true
		
		HeartTypes.NONE:
			no_heart.visible = true
