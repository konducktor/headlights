extends Control
class_name HeartUI


enum HeartTypes {
	FULL, HALF, NONE, REMOVED
}


@export var heart: TextureRect
@export var half_heart: TextureRect
@export var no_heart: TextureRect

@export var animation_player: AnimationPlayer

var heart_type: HeartTypes


func set_heart(type: HeartTypes, previous_type: HeartTypes) -> void:
	heart_type = type
	
	heart.visible = false
	half_heart.visible = false
	no_heart.visible = false
	
	match type:
		HeartTypes.FULL:
			heart.visible = true
		
		HeartTypes.HALF:
			half_heart.visible = true
			
			if previous_type == HeartTypes.FULL:
				damage_heart()
		
		HeartTypes.NONE:
			no_heart.visible = true
			
			if previous_type == HeartTypes.HALF:
				damage_heart()
		
		HeartTypes.REMOVED:
			no_heart.visible = true
			dissolve_heart()
	
	if previous_type == HeartTypes.REMOVED and type != HeartTypes.REMOVED:
			restore_heart()


func dissolve_heart() -> void:
	animation_player.play("dissolve_heart")
	await animation_player.animation_finished
	queue_free()


func damage_heart() -> void:
	animation_player.play("damage_heart")


func restore_heart() -> void:
	animation_player.play("restore_heart")
