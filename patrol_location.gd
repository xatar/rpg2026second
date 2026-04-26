@tool
class_name PatrolLocation extends Node2D

@export var wait_time : float = 0.0:
	set(v):
		wait_time = v
		_update_wait_time_label()
		
		
var target_position : Vector2  = Vector2.ZERO

signal transform_changed

func _enter_tree()->void:
	set_notify_transform(true)
	
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		transform_changed.emit()

func _update_wait_time_label()->void:
	if Engine.is_editor_hint():
		$Sprite2D/Label2.text = "wait: " + str( wait_time ) + "s"
		 
	pass



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_position = global_position
	_update_wait_time_label()
	if Engine.is_editor_hint():
		return
	$Sprite2D.queue_free()
	
	
	pass # Replace with function body.

func update_label(_s:String)->void:
	$Sprite2D/Label.text = _s
	
func update_line(next_location:Vector2)->void:
	var line : Line2D = $Sprite2D/Line2D
	line.points[1] = next_location - position
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
