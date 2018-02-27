extends Sprite

var is_happy = true

func change_mood():
	if is_happy:
		texture = load("res://happy_pig.png")
	else:
		texture = load("res://sad_pig.png")