class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(TakeDamage)
	pass # Replace with function body.

func TakeDamage ( _damage: HurtBox) -> void: #_damage znamená že je to volitelná variable, může ale nemusí přijt
	queue_free(); #queue_free() zničí daný objekt
