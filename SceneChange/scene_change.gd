extends Node
export(String, FILE, "*.tscn") var scene

func _ready():
	background.reset_modulate()
	$Slide.show()
	$Slide.slide(-1)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		background.set_modulate(Color("00ffff"))
		$CenterContainer/Label.set_text("reloading!")
		$Timer.start()
		yield($Timer, "timeout")
		$Slide.slide(1)
		yield($Slide, "finished_slide")
		get_tree().set_current_scene(background)