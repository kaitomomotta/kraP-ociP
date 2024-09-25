extends CharacterBody2D

class_name Character

## Set this in the editor. 0 to 7 are controllers, -1 is keyboard and mouse.
@export var player_index : int = 0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	return