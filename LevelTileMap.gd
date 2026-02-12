class_name LevelTileMap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.ChangeTilemapBounds(GetTilemapBounds())
	pass # Replace with function body.


func GetTilemapBounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position*rendering_quadrant_size) #rendering_quadrant_size is the size of the rendering in the inspector of each tilemaplayer #position is always topleft corner
	)
	bounds.append(
		Vector2(get_used_rect().end*rendering_quadrant_size) #rendering_quadrant_size is the size of the rendering in the inspector of each tilemaplayer #end is the bottom right of the corner
	)
	return bounds
