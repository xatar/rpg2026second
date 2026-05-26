@tool
@icon("res://npc_and_dialog/icons/answer_bubble.svg")
class_name DialogBranch extends DialogItem

@export var test: String = "ok..."

var dialog_items:Array[DialogItem]

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)
			
			
	pass # Replace with function body.
	
