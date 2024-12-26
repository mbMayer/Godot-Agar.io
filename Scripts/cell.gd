extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var random_color: Color


func _ready() -> void:
	#set random color
	random_color = Color(randf(), randf(), randf(), 1)
	randomize()
	modulate = random_color

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.cell_count += 1
		body.change_size(0.05) #Change size of player\enemy
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.owner is CharacterBody2D:
		area.owner.cell_count += 1
		area.owner.change_size(0.05) #Change size of player\enemy
		queue_free()
