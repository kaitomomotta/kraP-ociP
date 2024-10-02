extends StaticBody2D

@export var STRENGTH = 100
var vector : Vector2 = Vector2(-STRENGTH, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = $Area2D.get_overlapping_bodies()
	for body in bodies:
		if body is CharacterPlatforming: 
			body.velocity += vector
			body.move_and_slide()
	pass
