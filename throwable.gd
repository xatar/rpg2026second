class_name Throwable
extends Area2D

@export var gravity_strength : float  = 980
@export var throw_speed : float = 400.0
@export var throw_height_strength : float = 100.0
@export var thow_starting_height : float = 49

var picked_up : bool = false
var throwalbe: Node2D #here will be stored the item which will be thrown like a pot
var throw_direction : Vector2 = Vector2.ZERO

var object_sprite : Sprite2D
var vertical_velocity : float = 0
var ground_height : float = 0
var animation_player : AnimationPlayer

@onready var hurt_box: HurtBox = $HurtBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_enter)
	area_exited.connect(_on_area_enter)
	throwalbe = get_parent()
	setup_hurt_box()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func player_interact()->void:
	#pick up one interactible only (when they overlap for example)
	if picked_up == false:
		#pickup throwable object
		disable_collisions( throwalbe)
		if throwalbe.get_parent():
			throwalbe.get_parent().remove_child(throwalbe)
		PlayerManager.player.held_item.add_child(throwalbe)
		throwalbe.position = Vector2.ZERO
		PlayerManager.player.pickup_item(self)
		area_entered.disconnect(_on_area_enter)
		area_exited.disconnect(_on_area_enter)
		pass
	pass
	
func disable_collisions(_node:Node)->void:
	for c in _node.get_children():
		if c == self:
			continue
		if c is CollisionShape2D:
			c.disabled = true
		else:
			disable_collisions(c)
func _on_area_enter(_a:Area2D)->void:
	PlayerManager.interact_pressed.connect(player_interact)
	pass
	
func _on_area_enxit(_a:Area2D)->void:
	PlayerManager.interact_pressed.disconnect(player_interact)
	pass
	
func setup_hurt_box()->void:
	hurt_box.monitoring = false
	for c in get_children():
		if c is CollisionShape2D:
			var _col:CollisionShape2D = c.duplicate()
			hurt_box.add_child(_col)
			_col.debug_color = Color(1,0,0,.5)
	
