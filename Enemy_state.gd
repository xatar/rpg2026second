class_name EnemyState extends Node

##stores a references to the enemy that this state belongs to
var enemy : Enemy
var state_machine: EnemyStateMachine
#what happens when we initialize this state
func init() -> void :
	pass

#what happens when we enter this state	
func Enter() -> void:
	pass
	
#what happens when we exit this state		
func Exit() -> void:
	pass
	
#what happens durint the _process update in this state
func process (_delta: float) -> EnemyState:
	return null
	
#what happens durint the _physics update in this state
func physics(_delta: float) -> EnemyState:
	return null
	
