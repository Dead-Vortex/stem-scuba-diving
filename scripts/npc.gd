extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@onready var button : Sprite2D = $ButtonPrompt
@export var player : CharacterBody2D
@onready var shop_ui : Control = $Shop
var is_player_interactable : bool = false
var is_player_interacting : bool = false

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
		
	shop_ui.visible = true

func close_shop() -> void:
	is_player_interacting = false
	button.visible = true
	shop_ui.visible = false


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
	player.money += player.trash * 2 * 1000
	player.trash = 0

func _on_flipper_bought() -> void:
	if player.money >= 10:
		player.money -= 10
		player.swim_speed += 10

func _on_oxygen_bought() -> void:
	if player.money >= 30:
		player.money -= 30
		player.oxygen = player.max_oxygen + 15
		player.max_oxygen += 15
