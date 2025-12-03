extends CharacterBody2D
@export var speed = 260


func _physics_process(_delta):
	velocity = Vector2(Input.get_axis("walk_left", "walk_right") * speed, 0)
	move_and_slide()
