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
var selected_button : int
var education_modifier : float = 1
var correctness : bool = false
signal answered

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
	if player.trash != 0:
		ui_select.visible = false
		ui_questions.visible = true
		education_modifier = 1
		for _i in range(5):
			correctness = await(ask_question(randi_range(0, 1)))
			if correctness:
				education_modifier += 0.2
		print(str(int((education_modifier - 1) * 5)) + "/5 correct")
		close_shop()
		player.money += round(player.trash * education_modifier * randf_range(0.9, 1.2))
		player.trash = 0


func ask_question(index) -> bool:
	question_text.text = questions[index][0]
	var answers_temp = [questions[index][1], questions[index][2], questions[index][3], questions[index][4]]
	var correct_answer_temp = answers_temp[0]
	answers_temp.shuffle()
	quiz_b1.text = answers_temp[0]
	quiz_b2.text = answers_temp[1]
	quiz_b3.text = answers_temp[2]
	quiz_b4.text = answers_temp[3]
	await(answered)
	if (selected_button == 1 and quiz_b1.text == correct_answer_temp) or (selected_button == 2 and quiz_b2.text == correct_answer_temp) or (selected_button == 3 and quiz_b3.text == correct_answer_temp) or (selected_button == 4 and quiz_b4.text == correct_answer_temp):
		return(true)
	else:
		return(false)

func _on_answer_1_pressed() -> void:
	selected_button = 1
	answered.emit()

func _on_answer_2_pressed() -> void:
	selected_button = 2
	answered.emit()

func _on_answer_3_pressed() -> void:
	selected_button = 3
	answered.emit()

func _on_answer_4_pressed() -> void:
	selected_button = 4
	answered.emit()
