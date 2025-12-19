extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@onready var button : Sprite2D = $ButtonPrompt
@export var player : CharacterBody2D
@onready var shop_ui : Control = $Shop
var is_player_interactable : bool = false
var is_player_interacting : bool = false

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_player_interactable:
		if !is_player_interacting:
			is_player_interacting = true
			button.visible = false
			open_shop()
		else:
			is_player_interacting = false
			button.visible = true
			close_shop()

func open_shop():
	# Rotate player
	if player.global_position.x < 200:
		player.facing = "right"
		player.sprite.flip_h = false
	else:
		player.facing = "left"
		player.sprite.flip_h = true
		
	shop_ui.visible = true
	#scroll_text("Hello i am an npc :D")
func close_shop():
	shop_ui.visible = false
	
func scroll_text(text):
	$Shop/MarginContainer/RichTextLabel.text = text
	$Shop/MarginContainer/RichTextLabel.visible_characters = 0
	for _i in text.length():
		$Shop/MarginContainer/RichTextLabel.visible_characters += 1

func _player_enters_npc_interact_zone(body):
	if body == player:
		is_player_interactable = true
		button.visible = true

func _player_exits_npc_interact_zone(body):
	if body == player:
		is_player_interactable = false
		button.visible = false
