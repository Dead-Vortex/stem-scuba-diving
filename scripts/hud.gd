extends Node

@onready var oxygen_display : RichTextLabel = $MarginContainer/Oxygen
@export var player : CharacterBody2D

func _process(_delta : float) -> void:
	oxygen_display.text = str(player.oxygen)
