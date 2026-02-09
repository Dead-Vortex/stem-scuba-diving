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

var flipper_price = 20
var flipper_upgrades = 0
var flipper_max = 20

var capacity_price = 30
var capacity_upgrades = 0

var vacuum_price = 40
var vacuum_upgrades = 0
var vacuum_max = 20

var oxygen_price = 50
var oxygen_upgrades = 0
var oxygen_max = 14

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
	if (selected_item == "flipper" and (player.money < flipper_price or flipper_upgrades == flipper_max)) or (selected_item == "trash" and player.money < capacity_price) or (selected_item == "vacuum" and (player.money < vacuum_price or vacuum_upgrades == vacuum_max)) or (selected_item == "oxygen" and (player.money < oxygen_price or oxygen_upgrades == oxygen_max)):
		purchase_button.disabled = true
	if ((selected_item == "flipper" and flipper_upgrades == flipper_max) or (selected_item == "vacuum" and vacuum_upgrades == vacuum_max) or (selected_item == "flipper" and oxygen_upgrades == oxygen_max)):
		purchase_button.text = "SOLD OUT"
		
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
	purchase_button.text = purchase_text + str(flipper_price) + ")"
	if player.money < flipper_price or flipper_upgrades == flipper_max:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false
	if flipper_upgrades == flipper_max:
		purchase_button.text = "SOLD OUT"

func _on_trash_upgrade_selected() -> void:
	selected_item = "trash"
	info_text.text = "Trash Capacity Upgrade:\nIncreases amount of trash able to be carried at once by 4"
	purchase_button.text = purchase_text + str(capacity_price) + ")"
	if player.money < capacity_price:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false

func _on_vacuum_upgrade_selected() -> void:
	selected_item = "vacuum"
	info_text.text = "Trash Vacuum Upgrade:\nSuck trash towards you to collect it faster"
	purchase_button.text = purchase_text + str(vacuum_price) + ")"
	if player.money < vacuum_price or vacuum_upgrades == vacuum_max:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false
	if vacuum_upgrades == vacuum_max:
		purchase_button.text = "SOLD OUT"

func _on_oxygen_upgrade_selected() -> void:
	selected_item = "oxygen"
	info_text.text = "Oxygen Tank Upgrade:\nIncreases Oxygen capacity by 15 seconds"
	purchase_button.text = purchase_text + str(oxygen_price) + ")"
	if player.money < oxygen_price or oxygen_upgrades == oxygen_max:
		purchase_button.disabled = true
	else:
		purchase_button.disabled = false
	if oxygen_upgrades == oxygen_max:
		purchase_button.text = "SOLD OUT"

func _on_purchased() -> void:
	if selected_item == "flipper":
		if player.money >= flipper_price:
			player.money -= flipper_price
			player.swim_speed += 5
			flipper_upgrades += 1
	elif selected_item == "trash":
		if player.money >= capacity_price:
			player.money -= capacity_price
			player.max_trash += 4
			capacity_upgrades += 1
	elif selected_item == "vacuum":
		if player.money >= vacuum_price:
			player.money -= vacuum_price
			player.vacuum_toggle = true
			player.vacuum_speed += 0.75
			player.vacuum_distance += 10
			vacuum_upgrades += 1
	elif selected_item == "oxygen":
		if player.money >= oxygen_price:
			player.money -= oxygen_price
			player.oxygen = player.max_oxygen + 15
			player.max_oxygen += 15
			oxygen_upgrades += 1
	if (selected_item == "flipper" and (player.money < flipper_price or flipper_upgrades == flipper_max)) or (selected_item == "trash" and player.money < capacity_price) or (selected_item == "vacuum" and (player.money < vacuum_price or vacuum_upgrades == vacuum_max)) or (selected_item == "oxygen" and (player.money < oxygen_price or oxygen_upgrades == oxygen_max)):
		purchase_button.disabled = true
	if ((selected_item == "flipper" and flipper_upgrades == flipper_max) or (selected_item == "vacuum" and vacuum_upgrades == vacuum_max) or (selected_item == "oxygen" and oxygen_upgrades == oxygen_max)):
		purchase_button.text = "SOLD OUT"

func mobile() -> void:
	ui.scale = Vector2(2, 2)
	ui.position += Vector2(-140, 70)
