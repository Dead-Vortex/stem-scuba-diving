extends Node2D

func _on_trash_collected(body: Node2D) -> void:
	if body.name == "Player":
		body.trash += 1
		queue_free()
