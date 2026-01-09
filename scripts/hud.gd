extends Node

@onready var oxygen_display : RichTextLabel = $HBoxContainer/Oxygen
@onready var trash_display : RichTextLabel = $HBoxContainer/Trash
@export var player : CharacterBody2D
var touch_ui = preload("res://scenes/mobile_ui.tscn")

func _ready() -> void:
	if OS.has_feature("mobile"):
		add_sibling(touch_ui.instantiate())

func _process(_delta : float) -> void:
	oxygen_display.text = str(player.oxygen)
	trash_display.text = str(player.trash)
