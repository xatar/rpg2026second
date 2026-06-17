@tool
@icon ("res://npc_and_dialog/icons/question_bubble.svg")
class_name DialogChoice
extends DialogItem

var dialog_branches : Array[DialogBranch]


func _ready()->void:
	super()
	#if Engine.is_editor_hint():
		#return
	for c in get_children():
		if c is DialogBranch:
			dialog_branches.append(c)	


func _set_editor_display() -> void:
	#set the text based on related dialogtext node
	set_related_text()
	#set the dialog choice buttons
	if dialog_branches.size() < 2:
		return
	example_dialog.set_dialog_choice(self)
	pass
	
func set_related_text()->void:
	var _p = get_parent()
	var _t = _p.get_child(self.get_index()-1)
	
	if _t is DialogText:
		example_dialog.set_dialog_text(_t)
		example_dialog.content.visible_characters = -1
		
	pass
func _get_configuration_warnings() -> PackedStringArray:
	if _check_for_dialog_branches() == false:
		return ["requested at least 2 dialogbranch nodes"]
	else:
		return[]
	pass

func _check_for_dialog_branches()->bool:
	var _count : int = 0
	for c in get_children():
		if c is DialogBranch:
			_count += 1
			if _count >1:
				return true
	return false
	pass
