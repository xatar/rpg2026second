class_name EnemyCounter extends Node2D

signal enemies_defeated



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	child_exiting_tree.connect(_on_enemy_desroyed)
	pass # Replace with function body.

func _on_enemy_desroyed(e:Node2D)->void:
	if e is Enemy:
		if enemy_count() <= 1:
			enemies_defeated.emit()
			
	pass
	
	
func enemy_count()->int:
	var _count : int = 0
	for c in get_children():
		if c is Enemy:
			_count += 1
	return _count
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
