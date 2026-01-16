extends Node

var fish = preload("res://scenes/fish.tscn")
@export var initial_count : int = 20

func spawn_fish(count) -> void:
	for i in count:
		var fish_instance = fish.instantiate()
		add_child(fish_instance)
		fish_instance.global_position = Vector2(randf_range(-4500, 4500), randf_range(700, 2000))


func _ready() -> void:
	spawn_fish(initial_count)
