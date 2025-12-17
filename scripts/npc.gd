extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@onready var button : Sprite2D = $ButtonPrompt
@export var player : CharacterBody2D
var is_player_interactable : bool = false
var is_player_interacting : bool = false

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_player_interactable:
		if !is_player_interacting:
			is_player_interacting = true
			button.visible = false
			interaction_menu()
		else:
			is_player_interacting = false

func interaction_menu():
	player.facing = "right"
	player.sprite.flip_h = false

func _player_enters_npc_interact_zone(body):
	if body == player:
		is_player_interactable = true
		button.visible = true

func _player_exits_npc_interact_zone(body):
	if body == player:
		is_player_interactable = false
		button.visible = false
