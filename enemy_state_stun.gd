class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

@export var next_state : EnemyState
var _damage_position: Vector2
var _animation_finished: bool = false
var _direction : Vector2

#what happens when we initialize this state
func init() -> void :
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass

#what happens when we enter this state	
func Enter() -> void:
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.invulnerable = true
	_animation_finished = false
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass
	
#what happens when we exit this state		
func Exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass
	
#what happens durint the _process update in this state
func process (_delta: float) -> EnemyState:
	
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
#what happens durint the _physics update in this state
func physics(_delta: float) -> EnemyState:
	return null
func _on_enemy_damaged(hurt_box : HurtBox)->void:
	_damage_position = hurt_box.global_position
	state_machine.change_state(self)
	pass
	
func _on_animation_finished(_a : String) -> void:
	_animation_finished = true
