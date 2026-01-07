extends Node2D

#func _process(delta: float) -> void:
#	global_position += Vector2(randf_range(-50, 50) * delta, randf_range(-50, 50) * delta)

func _on_trash_collected(body: Node2D) -> void:
	if body.name == "Player":
		body.trash += 1
		queue_free()
