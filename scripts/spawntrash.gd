extends Node

var trash = preload("res://scenes/trash.tscn")
@export var initial_count : int = 100
var sprites = [preload("res://assets/trash/trash1.png"), preload("res://assets/trash/trash2.png"), preload("res://assets/trash/trash3.png")]

func spawn_garbage(count) -> void:
	for i in count:
		var trash_instance = trash.instantiate()
		add_child(trash_instance)
		trash_instance.global_position = Vector2(randf_range(-4500, 4500), randf_range(700, 2000))
		trash_instance.get_node("Sprite2D").set_texture(sprites.pick_random())

func _ready() -> void:
	spawn_garbage(initial_count)
