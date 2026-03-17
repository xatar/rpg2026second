class_name EnemyStateDestroy extends EnemyState

const PICKUP = preload("res://item_pickup.tscn")

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

@export_category("Item Drops")
@export var drops : Array[DropData]


var _damage_position:Vector2
var _direction : Vector2

#what happens when we initialize this state
func init() -> void :
	enemy.enemy_damaged.connect(_on_enemy_destroyed)
	pass

#what happens when we enter this state	
func Enter() -> void:
	_direction = enemy.global_position.direction_to(enemy.player.global_position)
	enemy.invulnerable = true
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	disable_hurt_box()
	drop_items()
	pass
	
#what happens when we exit this state		
func Exit() -> void:
	pass
	
#what happens durint the _process update in this state
func process (_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
#what happens durint the _physics update in this state
func physics(_delta: float) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurt_box : HurtBox)->void:
	_damage_position = hurt_box.global_position
	state_machine.change_state(self)
	pass
	
func _on_animation_finished(_a : String) -> void:
	enemy.queue_free()
	
func disable_hurt_box()->void:
	var hurt_box:HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
	
func drop_items() -> void:
	if drops.size() == 0:
		return
		
	# Store the result of our check once before the loops
	var enemy_counter_parent = get_enemy_counter_parent()
		
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
		var drop_count : int = drops[i].get_drop_count()
		
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			
			enemy.get_parent().call_deferred("add_child", drop)
			
			# Check if our variable is NOT null (meaning it IS an EnemyCounter)
			if enemy_counter_parent != null:
				drop.global_position = enemy.global_position - enemy_counter_parent.global_position
			else:
				drop.global_position = enemy.global_position
				
			# You had this line duplicated in both if/else, so we can just move it outside!
			drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(-0.9, 1.5)


# Renamed to make sense for returning a Node instead of a bool
func get_enemy_counter_parent() -> Node:
	# 1. 'owner' points to the root of the scene this node is saved in (the Slime)
	var slime_node = owner 
	
	# Make sure the slime node actually exists and is in the tree
	if slime_node == null or not slime_node.is_inside_tree():
		return null
		
	# 2. Get the Slime's parent
	var slimes_parent = slime_node.get_parent()
	
	if slimes_parent == null:
		return null
		
	# 3. Check if the parent is an EnemyCounter
	if slimes_parent is EnemyCounter:
		print("Slime's parent IS EnemyCounter!")
		return slimes_parent # Return the actual node so we can use its position!
	else:
		print("Slime's parent is NOT EnemyCounter. It is: ", slimes_parent.name)
		return null # Return null to represent 'false'
