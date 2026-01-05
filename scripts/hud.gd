extends Node

@onready var oxygen_display : RichTextLabel = $HBoxContainer/Oxygen
@onready var trash_display : RichTextLabel = $HBoxContainer/Trash
@export var player : CharacterBody2D

func _process(_delta : float) -> void:
	oxygen_display.text = str(player.oxygen)
	trash_display.text = str(player.trash)
