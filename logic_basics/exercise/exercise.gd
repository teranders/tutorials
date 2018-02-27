extends Sprite

#This exercise intents to show you how to use the three principles of logic
#to find and fix problems within an algorithm

#The intented behavior for this objects is that it will move, then rotate,
#then stop for 2 seconds and start all over again

enum {MOVE, ROTATE, STOP}
var current_state = MOVE setget set_state

func _ready():
	set_state(MOVE)
	
func set_state(new):
	if new == current_state:
		return
	if new == MOVE:
		move_pig()
	elif new == ROTATE:
		rotate_pig()
	else:
		stop_pig()

#You don't need to change anything below this line, but feel free to read it :)
func move_pig():
	$Tween.interpolate_property(self, "position", position,
		position + Vector2(100,0), 2.0, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	set_state(ROTATE)

func rotate_pig():
	$Tween.interpolate_property(self, "rotation", rotation,
		rotation + deg2rad(90), 2.0, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	set_state(STOP)
	
func stop_pig():
	$Timer.start()
	yield($Timer, "timeout")
	set_state(MOVE)