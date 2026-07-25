extends Node


signal select_skill
signal apply_skill(skill: SkillData)


var all_skills: Array[SkillData]

var rng := RandomNumberGenerator.new()


func _ready() -> void:
	all_skills = load_all_skills("res://skills/skills/")


func load_all_skills(path: String) -> Array[SkillData]:
	var out: Array[SkillData] = []
	
	var files: PackedStringArray = ResourceLoader.list_directory(path)
	for file in files:
		if file.ends_with("/"):
			out.append_array(load_all_skills(path + file))
		elif file.ends_with(".tres"):
			var res := load(path + file)
			if res is SkillData:
				out.append(res as SkillData)
	
	return out


func get_random_skills(amount: int) -> Array[SkillData]:
	var indexes: Array[int] = []
	var out: Array[SkillData] = []
	
	for i in amount:
		var idx: int = rng.randi_range(0, len(all_skills) - 1)
		
		if idx in indexes:
			idx = (idx + i) % len(all_skills)
		
		indexes.append(idx)
		out.append(all_skills[idx])
	
	return out
