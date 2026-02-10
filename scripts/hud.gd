extends CanvasLayer

@onready var oxygen_display : RichTextLabel = $HBoxContainer/Oxygen
@onready var trash_display : RichTextLabel = $HBoxContainer/Trash
@onready var money_display : RichTextLabel = $HBoxContainer/Money
@export var player : CharacterBody2D

var is_mobile = false

@onready var tutorial_container : CenterContainer = $CenterContainer
@onready var tutorial_text : RichTextLabel = $CenterContainer/TutorialText

func _process(_delta : float) -> void:
	oxygen_display.text = (str(player.oxygen) + "/" + str(player.max_oxygen))
	trash_display.text = (str(player.trash) + "/" + str(player.max_trash))
	money_display.text = ("Ð" + str(player.money))

func mobile() -> void:
	is_mobile = true
	scale = Vector2(2, 2)
	tutorial_text.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	tutorial_container.size = Vector2(640, 100)

func tutorial() -> void:
	if !is_mobile:
		tutorial_text.text = "Use Arrow Keys or WASD to move"
	else:
		tutorial_text.text = "Use Joystick to move"
