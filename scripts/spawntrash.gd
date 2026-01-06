extends Node

var trash = preload("res://scenes/trash.tscn")

func spawn_garbage() -> void:
	var trash_instance = trash.instantiate()
	add_child(trash_instance)
	trash_instance.global_position = Vector2(randf_range(-5000, 5000), randf_range(700, 2000))
	#trash_instance.get_node("Sprite2D").texture = "res://assets/trash/trash" + str(randi_range(1, 2)) + ".png"

func _ready() -> void:
	for i in 100:
		spawn_garbage()
