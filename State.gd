class_name State extends Node
# stores a reference of the player that this state belongs to
static var player: Player
static var StateMachine: PlayerStateMachine

func _ready() :
	pass
	
func Enter() -> void:
	pass
func init() ->void:
	
	pass 
func Exit() -> void:
	pass
	
func Process (_delta: float) -> State:
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput (_event: InputEvent) -> State:
	return null
	
