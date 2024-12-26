extends CharacterBody2D
@onready var player_node: CharacterBody2D = $"../Player"
@onready var spawner: Node = $"../Spawner"
@onready var detection_area: Area2D = $DetectionArea
@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D


@export var color: Color
@export var speed = 200
var cell_count = 0

func _ready() -> void:
	#Set enemy color
	sprite_2d.modulate = color
	sprite_2d.material.set_shader_parameter("cols", color)

func _physics_process(delta: float) -> void:
	velocity.y = velocity.y * speed
	velocity.x = velocity.x * speed
	move_and_slide()
	label.text = str(cell_count)
	search()

#Behaviour for find cells and player
func search():
	if detection_area.has_overlapping_areas():
		var c = detection_area.get_overlapping_areas()
		velocity = position.direction_to(c[0].position) #Direction to first cell that overlaps detection area
	else:
		velocity = Vector2(0, 0)
	if detection_area.has_overlapping_bodies():
		var p = detection_area.get_overlapping_bodies()
		for i in p:
			if i.scale < scale:
				velocity = position.direction_to(i.position)  #Chase target if scale > target scale
	else:
		velocity = Vector2(0, 0)

#Size change function
func change_size(size):
	scale += Vector2(size, size)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.scale < scale:
		body.queue_free()
		spawner.spawn_cells() #Spawn cells if kill someone
	if body.scale == scale:
		pass
	if body.scale > scale:
		spawner.spawn_cells() #Spawn cells if get killed
		queue_free()
