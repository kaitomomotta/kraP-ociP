extends Character

class_name CharacterPlatforming

func _physics_process(delta: float) -> void:
	super(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if MultiplayerInput.is_action_just_pressed(player_index, "jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
