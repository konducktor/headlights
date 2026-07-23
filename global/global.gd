extends Node

signal player_died

signal player_health_changed(new_value: int)
signal player_took_damage(amount: int)
signal player_regenerated(amount: int)

signal player_max_health_changed(new_value: int)
signal player_max_health_increased(amount: int)
signal player_max_health_decreased(amount: int)
