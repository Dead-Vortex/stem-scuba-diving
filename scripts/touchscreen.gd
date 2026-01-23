extends CanvasLayer

func _ready() -> void:
	visible = true
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		get_node("/root/Node2D/Player/HUD").mobile()
		get_node("/root/Node2D/NPC").mobile()
		get_node("/root/Node2D/NPC2").mobile()
