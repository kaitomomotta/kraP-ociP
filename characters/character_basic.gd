extends CharacterBody2D

class_name CharacterPlatforming

signal leave

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var player: int
var input

enum Directions {
	RIGHT,
	LEFT
}
var sprite_direction : Directions


@onready var sprite : Sprite2D = $Sprite2D

func init(player_num: int, device: int):
	player = player_num
	input = DeviceInput.new(device)
	sprite_direction = Directions.RIGHT

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite.texture = preload("res://Pico-8 Platformer/character/airborn.png")
	else:
		sprite.texture = preload("res://Pico-8 Platformer/character/right.png")

	# Handle jump.
	if input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Arange sprite change
	if input.is_action_just_pressed("left") and sprite_direction == Directions.RIGHT:
		sprite_direction = Directions.LEFT
	if input.is_action_just_pressed("right") and sprite_direction == Directions.LEFT:
		sprite_direction = Directions.RIGHT
	sprite.flip_h = sprite_direction