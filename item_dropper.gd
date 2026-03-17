@tool 
class_name ItemDropper
extends Node2D

const PICKUP = preload("res://item_pickup.tscn")
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var has_dropped_data: PersistentDataHandlerer = $PersistentDataHandlerer
var has_dropped:bool = false

@export var item_data:Itemdata : set = _set_item_data

func _set_item_data(value: Itemdata)->void:
	item_data = value
	_update_texture()
	
func _update_texture()->void:
	if Engine.is_editor_hint() == true:
		if item_data and sprite:
			sprite.texture = item_data.texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint() == true:
		_update_texture()
		return
		
	sprite.visible = false
	
	# FIX 2: Because the child node's _ready() runs before the parent's, 
	# has_dropped_data.value is already calculated! We don't need the signal.
	has_dropped = has_dropped_data.value


func drop_item()->void:
	if has_dropped == true:
		return
		
	has_dropped = true
	var drop = PICKUP.instantiate() as ItemPickup
	drop.item_data = item_data
	add_child(drop)
	drop.picked_up.connect(_on_drop_pickup)
	audio.play()
	
func _on_drop_pickup()->void:
	# FIX 1: Fixed the typo. Actually save the state!
	has_dropped_data.set_value()

# (You can completely delete func _on_data_loaded() as it's no longer needed)

func _process(delta: float) -> void:
	pass
