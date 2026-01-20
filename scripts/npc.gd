extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@onready var button : Sprite2D = $ButtonPrompt
@export var player : CharacterBody2D
@onready var ui : Control = $Shop
@onready var ui_select = $Shop/PanelContainer/VBoxContainer
@onready var ui_questions = $Shop/PanelContainer/Questions
var is_player_interactable : bool = false
var is_player_interacting : bool = false

var questions : Array = [
	# Format for adding new questions:
	# ["Question", "Correct Answer", "Incorrect 1", "Incorrect 2", "Incorrect 3"]
	# Add a comma after each question!
["What color is the ocean?", "Blue", "Purple", "Orange", "Merange"],
["What currency does this game use?", "Doubloons", "Dollars", "Euros", "Trash"],
]

@onready var question_text = $Shop/PanelContainer/Questions/RichTextLabel
@onready var quiz_b1 = $Shop/PanelContainer/Questions/Answers/Column1/Answer1
@onready var quiz_b2 = $Shop/PanelContainer/Questions/Answers/Column2/Answer2
@onready var quiz_b3 = $Shop/PanelContainer/Questions/Answers/Column1/Answer3
@onready var quiz_b4 = $Shop/PanelContainer/Questions/Answers/Column2/Answer4
var selected_answer : String

func _process(_delta) -> void:
	if Input.is_action_just_pressed("interact") and is_player_interactable and !is_player_interacting:
		open_shop()

func open_shop() -> void:
	is_player_interacting = true
	button.visible = false
	if player.global_position.x < 200:
		player.facing = "right"
		player.sprite.flip_h = false
	else:
		player.facing = "left"
		player.sprite.flip_h = true
		
	ui.visible = true
	ui_select.visible = true

func close_shop() -> void:
	is_player_interacting = false
	button.visible = true
	ui.visible = false
	ui_select.visible = false
	ui_questions.visible = false
	

func _player_enters_npc_interact_zone(body) -> void:
	if body == player:
		is_player_interactable = true
		button.visible = true

func _player_exits_npc_interact_zone(body) -> void:
	if body == player:
		is_player_interactable = false
		button.visible = false

func _on_exit_shop_button_pressed() -> void:
	close_shop()

func _on_trash_sold() -> void:
	ui_select.visible = false
	ui_questions.visible = true
	ask_question(randi_range(0, 1))
	player.money += round(player.trash * 2 * randf_range(0.9, 1.2))
	player.trash = 0


func ask_question(index):
	question_text.text = questions[index][0]
	var answers_temp = [questions[index][1], questions[index][2], questions[index][3], questions[index][4]]
	var correct_answer_temp = answers_temp[0]
	answers_temp.shuffle()
	quiz_b1.text = answers_temp[0]
	quiz_b2.text = answers_temp[1]
	quiz_b3.text = answers_temp[2]
	quiz_b4.text = answers_temp[3]
	await(quiz_b1.pressed or quiz_b2.pressed or quiz_b3.pressed or quiz_b4.pressed)
	if true:
		print("asddf?? idk what this code is bro")
	else:
		print("haha u gots wrong lmao")
