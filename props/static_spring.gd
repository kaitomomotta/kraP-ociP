extends StaticBody2D

@export var textureTriggered = preload("res://Pico-8 Platformer/character/right.png")
@export var texturePrimed = preload("res://Pico-8 Platformer/character/right.png")
@export var STRENGTH = 800
var triggered = false
@export var trigger_timer = 0

@onready var sprite : Sprite2D = $Sprite2D
@onready var area : Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	trigger_timer -= delta
	if trigger_timer <= 0:
		triggered = false
		sprite.texture = texturePrimed


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterPlatforming and !triggered:
		if body.velocity.y > STRENGTH:
			body.velocity += Vector2(0, -body.velocity.y)
		else:
			body.velocity += Vector2(0, -STRENGTH)
		triggered = true
		sprite.texture = textureTriggered
		trigger_timer = 0.5
		
