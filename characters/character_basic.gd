extends CharacterBody2D

class_name CharacterPlatforming

signal leave

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var player: int
var input
var fan_vector: Vector2 = Vector2(0,0)

enum Directions {
	RIGHT,
	LEFT
}
var sprite_direction : Directions
var is_squatting: bool

@onready var sprite : Sprite2D = $Sprite2D

func init(player_num: int, device: int):
	player = player_num
	input = DeviceInput.new(device)
	sprite_direction = Directions.RIGHT

func _ready() -> void:
	Globals.player_characters[player] = self

func apply_fan_force(force: Vector2) -> void:
	fan_vector = force

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite.texture = preload("res://Pico-8 Platformer/character/airborn.png")
	elif is_squatting:
		sprite.texture = preload("res://Pico-8 Platformer/character/squat.png")
	else:
		sprite.texture = preload("res://Pico-8 Platformer/character/right.png")

	# Handle jump.
	if input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle squat
	if input.is_action_pressed("squat") and is_on_floor():
		is_squatting = true
	else:
		is_squatting = false
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = input.get_axis("left", "right")
	velocity.x = 0
	if direction:
		velocity.x += direction * SPEED
	else:
		velocity.x += move_toward(velocity.x, 0, SPEED)
	velocity += fan_vector

	# Apply the fan force
	move_and_slide()
	
	# Arrange sprite change
	if input.is_action_just_pressed("left") and sprite_direction == Directions.RIGHT:
		sprite_direction = Directions.LEFT
	if input.is_action_just_pressed("right") and sprite_direction == Directions.LEFT:
		sprite_direction = Directions.RIGHT
	sprite.flip_h = sprite_direction
