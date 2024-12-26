extends Node

@export var cell : PackedScene
@export var count : int
var size

func _ready():
	spawn_cells()

#spawn cells
func spawn_cells():
	for i in count:  
		randomize()
		size = randf_range(0.5, 0.8)
		var c = cell.instantiate()
		c.scale = Vector2(size, size)
		call_deferred("add_child", c)
		c.position.x = randi_range(0, 2000)
		c.position.y = randi_range(0, 2000)
