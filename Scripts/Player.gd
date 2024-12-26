extends CharacterBody2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var label: Label = $Label
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

@export var color: Color

@export var speed:int = 100
var cell_count: int = 0
var direction
var mouse_pos: Vector2

func _ready() -> void:
	#set Player color
	sprite_2d.material.set_shader_parameter("cols", color)
	self_modulate = color

func _physics_process(delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	direction = (mouse_pos - position).normalized()
	velocity = direction * speed
#	look_at(mouse_pos)
	move_and_slide()

	label.text = str(cell_count)
	if Input.is_action_pressed("MOUSE_BUTTON"):
		if texture_progress_bar.value > 0:
			speed = 400
			texture_progress_bar.value -= 1
		else:
			speed = 250
	else:
		texture_progress_bar.value += 0.5
		speed = 250

#player size and camera zoom
func change_size(size):
	self.scale += Vector2(size, size)
	if camera_2d.zoom >= Vector2(0.2, 0.2):
		camera_2d.zoom = lerp(camera_2d.zoom, camera_2d.zoom - Vector2(size, size), size)
		camera_2d.zoom = clamp(camera_2d.zoom, Vector2(0.2, 0.2), Vector2(1.0, 1.0))
