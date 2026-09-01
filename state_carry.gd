class_name State_Carry
extends State

@export var move_speed : float = 100.0
@export var throw_audio : AudioStream
@onready var idle: State_Idle = $"../idle"
@onready var stun: State_Stun = $"../stun"

var walking : bool = false
var throwable : Throwable




func _ready() :
	pass
	
func Enter() -> void:
	player.UpdateAnimation( "carry")
	walking = false
	
	pass
func init() ->void:
	
	pass 
func Exit() -> void:
	if throwable:
		#throw direction
		#where we stunned
		if StateMachine.next_state == stun:
			
			pass
		else:
			
			pass
			#drop 
		#else
		pass
	pass
	
func Process (_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		walking = false
		player.UpdateAnimation("carry")
	elif player.SetDirection() or walking == false:
		player.UpdateAnimation("carry_walk")
		walking = true
		
	player.velocity = player.direction * move_speed
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput (_event: InputEvent) -> State:
	if _event.is_action_pressed("attack") or _event.is_action_pressed("interact"):
		return idle
	return null
	
