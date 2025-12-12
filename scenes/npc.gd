extends Node2D

@onready var interact_zone : Area2D = $InteractZone
@export var player : CharacterBody2D
var is_player_interactable : bool = false
var is_player_interacting : bool = false

func _process(_delta):
	if Input.is_action_just_pressed("interact") and is_player_interactable:
		if !is_player_interacting:
			is_player_interacting = true
			interaction_menu()
		else:
			is_player_interacting = false

func interaction_menu():
	pass

func _player_enters_npc_interact_zone(body):
	if body == player:
		is_player_interactable = true

func _player_exits_npc_interact_zone(body):
	if body == player:
		is_player_interactable = false
