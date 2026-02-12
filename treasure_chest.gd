@tool
class_name TreasureChest extends Node2D

@export var item_data : Itemdata : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity

var is_open:bool = false
@onready var sprite: Sprite2D = $ItemSprite
@onready var label: Label = $Label
@onready var interact_area: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
	interact_area.area_entered.connect(_on_area_entered)
	interact_area.area_exited.connect(_on_area_exit)
	_update_label()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _set_item_data(value:Itemdata)->void:
	item_data = value
	_update_texture()
	_update_label()
	pass

func _set_quantity(value:int)->void:
	quantity = value
	_update_label()
	pass

func player_interact()->void:
	if is_open == true:
		return
	is_open == true
	animation_player.play("open_chest")
	if item_data and quantity > 0:
		PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
	else:
		printerr("No Items in Chest!")
		push_error("No Items in Chest! Chest Name: ", name)
	pass

func _on_area_entered(_area)->void:
	PlayerManager.interact_pressed.connect(player_interact)
	pass
	
func _on_area_exit(_area)->void:
	PlayerManager.interact_pressed.disconnect(player_interact)
	pass
	
func _update_texture()->void:
	if item_data:
		print("je tu textura")
		sprite.texture = item_data.texture
	else:
		print("neni tu textura")	
func _update_label()->void:
	if label:
		if quantity <= 1:
			label.text = ""
		else:
			label.text = "x" + str(quantity)
