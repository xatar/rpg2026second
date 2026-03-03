class_name BarredDoor extends Node2D

var is_open : bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func open_door()->void:
	animation_player.play("open_door")
	pass
func close_door()->void:
	#await get_tree().create_timer(2.0).timeout
	animation_player.play("closed_door")
	pass
