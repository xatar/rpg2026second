class_name State_Charge_Attack extends State

@export var charge_duration:float = 1.0
@export var move_speed:float = 80.0
@export var sfx_chrage : AudioStream
@export var sfx_spin : AudioStream


var timer : float = 0.0
var walking : bool = false
var is_attacking : bool = false
var particles : ParticleProcessMaterial

@onready var idle: State_Idle = $"../idle"
@onready var charge_hurt_box: HurtBox = %ChargeHurtBox
@onready var charge_spin_hurt_box: HurtBox = %ChargeSpinHurtBox

func _ready() :
	print("charge attack")
	pass
	
func Enter() -> void:
	timer = charge_duration
	is_attacking = false
	walking = false
	charge_hurt_box.monitoring = true
		
	pass
func init() ->void:
	
	pass 
func Exit() -> void:
	charge_hurt_box.monitoring = false
	charge_spin_hurt_box.monitoring = false
	pass
	
func Process (_delta: float) -> State:
	#handle timer, when the timer is complete do something
	if timer > 0 :
		timer -= _delta
		if timer <= 0:
			timer = 0
			
		
	#detect, walking or no
	#move the player
	if is_attacking == false:
		if player.direction == Vector2.ZERO:
			walking = false
			player.UpdateAnimation("charge")
		elif player.SetDirection() or walking == false:
			walking = true
			player.UpdateAnimation("charge_walk")
			pass
		
	player.velocity = player.direction * move_speed
	
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput (_event: InputEvent) -> State:
	if _event.is_action_released("attack"):
		if timer > 0:
			return idle
		elif is_attacking == false:
			charge_attack()
	return null
func charge_attack()->void:
	is_attacking = true
	player.animation_player.play("charge_attack")
	player.animation_player.seek(get_spin_frame())
	var _duration : float = player.animation_player.current_animation_length
	player.make_invulnerable(_duration)
	charge_spin_hurt_box.monitoring = true
	await get_tree().create_timer(_duration*0.875).timeout
	print ("charge attack")
	#play animation
	StateMachine.ChangeState(idle)
	pass
	
func get_spin_frame()->float:
	var interval :float = 0.05
	match player.cardinal_direction:
		Vector2.DOWN:
			return interval * 0
		Vector2.UP:
			return interval * 4
		_:
			return interval * 6	
