@tool
class_name PatrolLocation extends Node2D

@export var wait_time : float = 0.0:
	set(v):
		wait_time = v
		_update_wait_time_label()
		
		

func _update_wait_time_label()->void:
	if Engine.is_editor_hint():
		$Sprite2D/Label2.text = "wait: " + str(wait_time) + "s"
		 
	pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
