extends CanvasLayer

@onready var textbox : RichTextLabel = $PanelContainer/HBoxContainer/MarginContainer/Textbox
var text_speed : float = 0.02
@onready var sprite : AnimatedSprite2D = $PanelContainer/AnimatedSprite2D
@onready var triangle = $PanelContainer/TriangleThing
signal progress_dialogue

func dialogue(text) -> void:
	textbox.visible_characters = 0
	textbox.text = text
	while textbox.visible_ratio != 1:
		await get_tree().create_timer(text_speed).timeout
		textbox.visible_characters += 1
	triangle.visible = true
	await(progress_dialogue)
	triangle.visible = false
	textbox.text = ""

func _ready() -> void:
	sprite.play("default")
	triangle.play("default")
	await(dialogue("ajsjdfaslkfasjlkdflkas;djf;laskdjfl;kasdjfl;kasdj;lasdjflkkassfjdl;asdkjf . auhsdf?DSAfasdF?asD?FasD?F?DS?Fasdfasdojfaslk;djf"))

func _input(event: InputEvent) -> void:
	emit_signal("progress_dialogue")
