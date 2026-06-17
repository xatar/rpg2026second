
@tool
@icon ("res://npc_and_dialog/icons/text_bubble.svg")
class_name DialogText
extends DialogItem

# Added a setter function (set_text) that runs every time you type in the inspector
@export_multiline var text : String = "Placeholder text" : set = _set_text



func _set_text(value: String) -> void:
	text = value
	# Update the preview in real-time when editing
	if Engine.is_editor_hint():
		if example_dialog != null:
			_set_editor_display()

# This is where we pass our node's data over to the visual UI
func _set_editor_display() -> void:
	example_dialog.set_dialog_text(self)
	
	# -1 forces all characters to display immediately without the typewriter effect
	example_dialog.content.visible_characters = -1
