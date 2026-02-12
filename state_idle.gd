class_name State_Idle extends State
@onready var walk: State = $"../walk"
@onready var attack: State = $"../attack"

func Enter() -> void:
	player.UpdateAnimation("idle")
	$"../../Sprite2D/AttackEffectSprite".visible = false
	pass
	
func Exit() -> void:
	pass
	
func Process (_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput (_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
	return null
	
