@icon("res://npc_and_dialog/icons/npc_behavior.svg")
class_name NPCBehaviour extends Node2D

var npc : NPC

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p = get_parent()
	if p is NPC:
		npc = p as NPC
		npc.do_behaviour_enable.connect(start)
	pass # Replace with function body.

func start()->void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
