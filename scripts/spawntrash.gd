extends Node

var trash = preload("res://scenes/trash.tscn")
var sprites = [preload("res://assets/trash/trash1.png"), preload("res://assets/trash/trash2.png"), preload("res://assets/trash/trash3.png")]

func spawn_garbage(zone1 : int, zone2 : int, zone3 : int) -> void:
	for i in zone1:
		var trash_instance = trash.instantiate()
		add_child(trash_instance)
		trash_instance.global_position = Vector2(randf_range(-4500, 4500), randf_range(700, 1500))
		trash_instance.get_node("Sprite2D").set_texture(sprites.pick_random())
	for j in zone2:
		var trash_instance = trash.instantiate()
		add_child(trash_instance)
		trash_instance.global_position = Vector2(randf_range(-4500, 4500), randf_range(1500, 2500))
		trash_instance.get_node("Sprite2D").set_texture(sprites.pick_random())
	for k in zone3:
		var trash_instance = trash.instantiate()
		add_child(trash_instance)
		trash_instance.global_position = Vector2(randf_range(-4500, 4500), randf_range(2500, 3150))
		trash_instance.get_node("Sprite2D").set_texture(sprites.pick_random())

func lose_trash(position : Vector2, count : int):
	for l in count:
		var trash_instance = trash.instantiate()
		add_child(trash_instance)
		trash_instance.global_position = Vector2(randf_range(position.x - 150, position.x + 150), randf_range(position.y - 150, position.y + 150))
		trash_instance.get_node("Sprite2D").set_texture(sprites.pick_random())

func _ready() -> void:
	spawn_garbage(35, 50, 75)
