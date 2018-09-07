extends "state.gd"

export (int) var speed = 400

func setup(actor, previous_state):
	actor.velocity.x = speed * actor.direction
	actor.emit_signal("perform_action", "walk")
	
func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		actor.jump()
	
	if event.is_action_pressed(actor.right):
		actor.direction = 1
	elif event.is_action_pressed(actor.left):
		actor.direction = -1

	if event.is_action_released(actor.right) and actor.direction == 1:
			if Input.is_action_pressed(actor.left):
				actor.direction = -1
			else:
				actor.idle()
	elif event.is_action_released(actor.left) and actor.direction == -1:
		if Input.is_action_pressed(actor.right):
			actor.direction = 1
		else:
			actor.idle()

func process(actor, delta):
	actor.velocity.y += actor.GRAVITY

	if actor.velocity.y > actor.FALL_THRESHOLD:
		actor.fall()
	
	if actor.get_slide_count() < 1:
		return
	var collision = actor.get_slide_collision(0)
	if abs(rad2deg(collision.normal.angle())) > 90:
		actor.velocity = Vector2(speed * actor.direction, 0)
