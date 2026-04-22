@tool
extends NPCBehaviour

const COLORS = [Color(1,0,0),Color(0,1,0),Color(0,0,1),Color(1,1,0),Color(1,0,1),Color(0,1,1),Color(1,0,0)]

@export var walk_speed : float = 30.0
var patrol_location : Array[PatrolLocation]
var current_location_index : int = 0
var target : PatrolLocation




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gather_patrol_locations()
	if Engine.is_editor_hint():
		child_entered_tree.connect(gather_patrol_locations)
		child_order_changed.connect(gather_patrol_locations)
		return
	pass # Replace with function body.
	super()
	if patrol_location.size() == 0:
		process_mode = Node.PROCESS_MODE_DISABLED
		return
	target = patrol_location[0]

func gather_patrol_locations(_n : Node = null)->void:
	patrol_location = []
	for c in get_children():
		if c is PatrolLocation:
			patrol_location.append(c)
			
	if Engine.is_editor_hint():
		if patrol_location.size()>0:
			for i in patrol_location.size():
				var _p = patrol_location[i] as PatrolLocation
				
				#if not _p.transform_changed.is_connected(gather_patrol_locations):
					#_p.transform_changed.connect(gather_patrol_locations)
				
				_p.update_label(str(i))
				_p.modulate = _get_color_by_index(i)
				
				#var _next : PatrolLocation
				#if i < patrol_location.size()-1:
					#_next = patrol_location[i + 1]
				#else:
					#_next = patrol_location[0]
				#_p.update_line(_next.postion)
		return
	pass
	
func _get_color_by_index(i : int )->Color:
	var color_count : int = COLORS.size()
	while i > color_count -1:
		i -= color_count
	return COLORS[i]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if npc.global_position.distance_to(target.target_postion) < 1:
		start()
	pass
	
func start()->void:
	if npc.do_behaviour == false or patrol_location.size()<2:
		return
	#Idle 
	npc.global_position = target.target_postion
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	var wait_time : float = target.wait_time
	current_location_index += 1
	if current_location_index >= patrol_location.size():
		current_location_index = 0
	target = patrol_location[current_location_index]
	await get_tree().create_timer(wait_time).timeout
	if npc.do_behaviour == false:
		return
	npc.state = "walk"
	var _dir = global_position.direction_to(target.target_postion)
	npc.direction = _dir
	npc.velocity = walk_speed * _dir
	npc.update_direction(target.target_postion)
	npc.update_animation()
	pass
