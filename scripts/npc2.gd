extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@onready var button : Sprite2D = $ButtonPrompt
@export var player : CharacterBody2D
@onready var ui : Control = $Shop
@onready var info_text = $Shop/PanelContainer/VBoxContainer/HBoxContainer/InfoBox/ShopItemInfo
@onready var purchase_button = $Shop/PanelContainer/VBoxContainer/HBoxContainer/InfoBox/PurchaseButton
var purchase_text = "Buy (Ð"
var selected_item = "flipper"
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

func close_shop() -> void:
	is_player_interacting = false
	button.visible = true
	ui.visible = false

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
	
func _on_flipper_upgrade_selected() -> void:
	selected_item = "flipper"
	info_text.text = "Flipper Upgrade:\nIncreases Swim Speed by 5%"
	purchase_button.text = purchase_text + "20)"
	if player.money < 20:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false

func _on_trash_upgrade_selected() -> void:
	selected_item = "trash"
	info_text.text = "Trash Capacity Upgrade:\nIncreases amount of trash able to be carried at once by 4"
	purchase_button.text = purchase_text + "30)"
	if player.money < 30:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false

func _on_vacuum_upgrade_selected() -> void:
	selected_item = "vacuum"
	info_text.text = "Trash Vacuum Upgrade:\nSuck trash towards you to collect it faster"
	purchase_button.text = purchase_text + "40)"
	if player.money < 40:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false

func _on_oxygen_upgrade_selected() -> void:
	selected_item = "oxygen"
	info_text.text = "Oxygen Tank Upgrade:\nIncreases Oxygen capacity by 15 seconds"
	purchase_button.text = purchase_text + "50)"
	if player.money < 50:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false

func _on_purchased() -> void:
	if selected_item == "flipper":
		if player.money >= 20:
			player.money -= 20
			player.swim_speed += 5
	elif selected_item == "trash":
		if player.money >= 30:
			player.money -= 30
			player.max_trash += 4
	elif selected_item == "vacuum":
		if player.money >= 40:
			player.money -= 40
			player.vacuum_speed += 1
			player.vacuum_distance += 75
	elif selected_item == "oxygen":
		if player.money >= 50:
			player.money -= 50
			player.oxygen = player.max_oxygen + 15
			player.max_oxygen += 15
