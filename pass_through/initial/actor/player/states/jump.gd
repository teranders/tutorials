extends "state.gd"

export (int) var jump_height = 800
export (int) var max_jumps = 2

var in_air_speed = 400.0

onready var jumps = max_jumps setget set_jumps

func setup(actor, previous_state):
	in_air_speed = get_node("../walk").speed
	
	match previous_state.name:
		"idle":
			jumps = max_jumps
		"walk":
			jumps = max_jumps
		"fall":
			jumps = min(jumps, max_jumps - 1)
	
	if jumps < 1:
		return
	
	jumps -= 1
	actor.velocity.y = -jump_height
	actor.emit_signal("perform_action", "jump")

func input_process(actor, event):
	if event.is_action_pressed(actor.jump):
		actor.jump()
	elif event.is_action_released(actor.jump):
		actor.cancel_jump()
		
	if event.is_action_pressed(actor.right):
		actor.direction = 1
		actor.velocity.x = in_air_speed * actor.direction
	elif event.is_action_pressed(actor.left):
		actor.direction = -1
		actor.velocity.x = in_air_speed * actor.direction
	if event.is_action_released(actor.right):
		actor.direction = 1
		actor.velocity.x = 0
	elif event.is_action_released(actor.left):
		actor.direction = -1
		actor.velocity.x = 0

func process(actor, delta):
	actor.velocity.y += actor.GRAVITY
	if actor.velocity.y > actor.FALL_THRESHOLD:
		actor.fall()
	
	if not actor.has_method("handle_input"):
		return
	if Input.is_action_pressed(actor.right):
		actor.direction = 1
		actor.velocity.x = in_air_speed * actor.direction
	elif Input.is_action_pressed(actor.left):
		actor.direction = -1
		actor.velocity.x = in_air_speed * actor.direction
	
func set_jumps(value):
	jumps = value
	jumps = clamp(jumps, 0, max_jumps)
	