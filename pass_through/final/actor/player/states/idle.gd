extends "state.gd"
	
func setup(actor, previous_state):
	actor.velocity.x = 0
	actor.emit_signal("perform_action", "idle")
	
func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		if actor.has_node("pass_through") and Input.is_action_pressed(actor.down):
			actor.set_collision_mask_bit(1, false)
		else:
			actor.jump()
	
	if event.is_action_pressed(actor.right):
		actor.direction = 1
		actor.walk()
	elif event.is_action_pressed(actor.left):
		actor.direction = -1
		actor.walk()

func process(actor, delta):
	actor.velocity.y += actor.GRAVITY
	if actor.velocity.y > actor.FALL_THRESHOLD:
		actor.fall()
	