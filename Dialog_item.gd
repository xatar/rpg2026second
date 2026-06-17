@tool
@icon ("res://npc_and_dialog/icons/chat_bubble.svg") 
class_name DialogItem 
extends Node


@export  var npc_info : NPCResource

var editor_selection : EditorSelection
var example_dialog : DialogSystemNode



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		editor_selection = EditorInterface.get_selection()
		editor_selection.selection_changed.connect(_on_selection_changed)
		print("test 1")
		return
	check_npc_data()
	print("test 1.1")
	pass # Replace with function body.
	
	
func _on_selection_changed()->void:
	if editor_selection == null:
		return
	var sel = editor_selection.get_selected_nodes()
	if is_instance_valid(example_dialog):
		example_dialog.queue_free()
	example_dialog = null
	if example_dialog != null:
		example_dialog.queue_free()
	print("test 2")	
	if not sel.is_empty() and self == sel[0]:
		example_dialog = load("res://dialog_system.tscn").instantiate() as DialogSystemNode
		print("test 3")
		if example_dialog == null:
			print("test 4")
			return
		self.add_child(example_dialog)
		example_dialog.offset = get_parent_global_position() + Vector2(-300, -100)
		check_npc_data()
		_set_editor_display()
			

func check_npc_data()->void:
	if npc_info == null:
		var p = self
		var _checking : bool = true
		while _checking == true:
			p = p.get_parent()
			if p:
				if p is NPC and p.npc_resource:
					npc_info = p.npc_resource
					_checking = false
			else:
				_checking = false
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
# This function traverses up the node tree to find the NPC's actual 2D position
func get_parent_global_position() -> Vector2:
	var p = self
	var _checking : bool = true
	while _checking == true:
		p = p.get_parent()
		if p:
			# Check if the parent has a 2D transform
			if p is Node2D:
				return p.global_position
		else:
			_checking = false
	return Vector2.ZERO

func _set_editor_display() -> void:
	pass
