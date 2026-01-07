extends Node

var trash = preload("res://scenes/trash.tscn")
var sprites = [preload("res://assets/trash/trash1.png"), preload("res://assets/trash/trash2.png")]

func spawn_garbage() -> void:
	var trash_instance = trash.instantiate()
	add_child(trash_instance)
	trash_instance.global_position = Vector2(randf_range(-5000, 5000), randf_range(700, 2000))
	trash_instance.get_node("Sprite2D").set_texture(sprites.pick_random())

func _ready() -> void:
	for i in 100:
		spawn_garbage()
