extends Control

@onready var buttons: VBoxContainer = $MarginContainer/Buttons
@onready var credits: VBoxContainer = $"MarginContainer/Credits Screen"

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_credits_button_pressed() -> void:
	buttons.visible = false
	credits.visible = true


func _on_exit_credits_pressed() -> void:
	credits.visible = false
	buttons.visible = true
