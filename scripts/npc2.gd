extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@onready var button : Sprite2D = $ButtonPrompt
@export var player : CharacterBody2D
@onready var ui : Control = $Shop
@onready var ui_select = $"Shop/PanelContainer/Shop Selection"
@onready var ui_questions = $Shop/PanelContainer/Questions
var is_player_interactable : bool = false
var is_player_interacting : bool = false

func _process(_delta) -> void:
	if Input.is_action_just_pressed("interact") and is_player_interactable and !is_player_interacting:
		open_shop()

func open_shop() -> void:
	is_player_interacting = true
	button.visible = false
	if player.global_position.x > -255:
		player.facing = "left"
		player.sprite.flip_h = true
	else:
		player.facing = "right"
		player.sprite.flip_h = false
		
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
	player.money += round(player.trash * 2 * randf_range(0.9, 1.2))
	player.trash = 0
func _on_flipper_bought() -> void:
	if player.money >= 20:
		player.money -= 20
		player.swim_speed += 3

func _on_oxygen_bought() -> void:
	if player.money >= 75:
		player.money -= 75
		player.oxygen = player.max_oxygen + 15
		player.max_oxygen += 15
