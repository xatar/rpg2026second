@tool
@icon("res://npc_and_dialog/icons/chat_bubbles.svg")
class_name DialogInteraction
extends Area2D

signal player_interacted
signal finished

@export var enabled : bool = true

var dialog_items : Array[DialogItem]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)
	pass # Replace with function body.

func _get_configuration_warnings() -> PackedStringArray:
	#check for dialog
	if _check_for_dialog_items() == false:
		return ["Requires at least one DialogItem node."]
	else:
		return[]
	pass
	
func _check_for_dialog_items()->bool:
	for c in get_children():
		if c is DialogItem:
			return true
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
