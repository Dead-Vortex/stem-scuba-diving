extends Node

@onready var oxygen_display : RichTextLabel = $HBoxContainer/Oxygen
@onready var trash_display : RichTextLabel = $HBoxContainer/Trash
@onready var money_display : RichTextLabel = $HBoxContainer/Money
@export var player : CharacterBody2D


func _process(_delta : float) -> void:
	oxygen_display.text = str(player.oxygen)
	trash_display.text = (str(player.trash) + "/" + str(player.max_trash))
	money_display.text = str(player.money)
