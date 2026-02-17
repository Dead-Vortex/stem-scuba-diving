extends CanvasLayer

@onready var oxygen_display : RichTextLabel = $HBoxContainer/Oxygen
@onready var trash_display : RichTextLabel = $HBoxContainer/Trash
@onready var money_display : RichTextLabel = $HBoxContainer/Money
@export var player : CharacterBody2D

var is_mobile = false

@onready var tutorial_container : CenterContainer = $CenterContainer
@onready var tutorial_text : RichTextLabel = $CenterContainer/TutorialText
var tutorial_finished = false
signal progress_dialogue
signal progress_dialogue2
signal progress_dialogue3
signal progress_dialogue4
signal progress_dialogue5
signal progress_dialogue6

func _ready() -> void:
	tutorial()

func _process(_delta : float) -> void:
	oxygen_display.text = (str(player.oxygen) + "/" + str(player.max_oxygen))
	trash_display.text = (str(player.trash) + "/" + str(player.max_trash))
	money_display.text = ("Ð" + str(player.money))
	
	if player.trash >= 6 and tutorial_finished == false:
		emit_signal("progress_dialogue3")
	if player.trash >= player.max_trash and tutorial_finished == false:
		emit_signal("progress_dialogue4")
	if player.global_position.y < 200 and tutorial_finished == false:
		emit_signal("progress_dialogue5")
	if player.money > 0 and tutorial_finished == false:
		emit_signal("progress_dialogue6")
	if (player.swim_speed > 200 or player.max_oxygen > 30 or player.max_trash > 8 or player.vacuum_toggle == true) and tutorial_finished == false:
		tutorial_text.visible = false
		tutorial_finished = true

func mobile() -> void:
	is_mobile = true
	scale = Vector2(2, 2)
	tutorial_text.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	tutorial_container.size = Vector2(640, 100)

func tutorial() -> void:
    if is_mobile == false:
	    tutorial_text.text = ("Use Arrow Keys or WASD to move"
	else:
	    tutorial_text.text = "Use Joystick to move")
	await(progress_dialogue)
	tutorial_text.text = "Collect trash from the ocean"
	await(progress_dialogue2)
	tutorial_text.text = "Watch your oxygen!"
	await(progress_dialogue3)
	tutorial_text.text = "You can only carry so much trash with you at once"
	await(progress_dialogue4)
	tutorial_text.text = "Your trash is full. Go back to the dock"
	await(progress_dialogue5)
	tutorial_text.text = "Go talk to the guy with a shell"
	await(progress_dialogue6)
	tutorial_text.text = "Use your Doubloons to buy upgrades from the bird"

func _input(event: InputEvent) -> void:
	if event.get_axis("left", "right") != 0 or event.is_action_pressed("jump"):
		emit_signal("progress_dialogue")

func _on_25_oxygen_tutorial() -> void:
	emit_signal("progress_dialogue2")
