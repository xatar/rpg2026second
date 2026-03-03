class_name State_Walk extends State

@export var move_speed: float = 5000.0
@onready var idle: State = $"../idle"
@onready var attack: State = $"../attack"

func Enter() -> void:
	player.UpdateAnimation("walk")
	pass
	
func Exit() -> void:
	pass
	
func Process (delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed * delta
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput (_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
	return null
	
