extends Sprite

var is_happy = true

func change_mood():
	if is_happy:
		texture = load("res://happy_pig.png")
	else:
		texture = load("res://sad_pig.png")
	is_happy = not is_happy
	
#check for every time the player taps the spacebar
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		change_mood()
#when spacebar is tapped we will change the mood of the character