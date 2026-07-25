extends Node


signal select_skill
signal apply_skill(skill: SkillData)


var all_skills: Array[SkillData]
var unused_skills: Array[SkillData]

var rng := RandomNumberGenerator.new()


func _ready() -> void:
	all_skills = load_all_skills("res://skills/skills/")
	unused_skills = all_skills


func reroll_skills() -> void:
	unused_skills = all_skills


func load_all_skills(path: String) -> Array[SkillData]:
	var out: Array[SkillData] = []
	
	var files: PackedStringArray = ResourceLoader.list_directory(path)
	for file in files:
		if file.ends_with("/"):
			out.append_array(load_all_skills(path + file))
		elif file.ends_with(".tres"):
			prints(path, file)
			var res := load(path + file)
			if res is SkillData:
				out.append(res as SkillData)
	
	return out


func get_random_skill() -> SkillData:
	var idx: int = rng.randi_range(0, len(unused_skills) - 1)
	return unused_skills[idx]


func pop_random_skill() -> SkillData:
	return unused_skills.pop_at(rng.randi_range(0, len(unused_skills) - 1))
