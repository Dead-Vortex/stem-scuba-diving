extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@onready var button : Sprite2D = $ButtonPrompt
@export var player : CharacterBody2D
@onready var ui : Control = $Shop
@onready var ui_select = $Shop/PanelContainer/VBoxContainer
@onready var ui_questions = $Shop/PanelContainer/Questions
var is_player_interactable : bool = false
var is_player_interacting : bool = false

var questions : Array = [["What color is mr kims heart", "Red", "Blue", "Black", "Not Applicable"], ["Who is henry jarvis", "leader of the uncivil american movement", "brother", "Felix Hart?", "australian turkey"]]
@onready var question_text = $Shop/PanelContainer/Questions/RichTextLabel
@onready var quiz_b1 = $Shop/PanelContainer/Questions/Answers/Column1/Answer1
@onready var quiz_b2 = $Shop/PanelContainer/Questions/Answers/Column2/Answer2
@onready var quiz_b3 = $Shop/PanelContainer/Questions/Answers/Column1/Answer3
@onready var quiz_b4 = $Shop/PanelContainer/Questions/Answers/Column2/Answer4

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
	quiz_b1.text = questions[index][1]
	quiz_b2.text = questions[index][2]
	quiz_b3.text = questions[index][3]
	quiz_b4.text = questions[index][4]
