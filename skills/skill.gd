@abstract
extends Node
class_name Skill


var context: SkillsContext


@abstract
func apply() -> void


@abstract
func remove() -> void
