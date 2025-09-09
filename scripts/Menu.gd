extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/CookingMaybeRevV1Official.play()
	await $Panel/CookingMaybeRevV1Official.finished
	while true:
		$Panel/CookingMaybeRevV3Official.play()
		await $Panel/CookingMaybeRevV3Official.finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/ParallaxBackground.scroll_offset.y += 10.0 * delta
	var mouse_pos = get_viewport().get_mouse_position()
	var button_center = $Panel/ExitButton.position + Vector2(224, 42) / 2
	var SCREEN_SIZE = Vector2(1280, 720)
	
	var dist = button_center.distance_to(mouse_pos)
	if dist < 120.0:
		var dir = (button_center - mouse_pos).normalized()
		$Panel/ExitButton.position += dir * 900.0 * delta  # 300 is speed
		$Panel/ExitButton.position.x = clamp($Panel/ExitButton.position.x, 0, SCREEN_SIZE.x - Vector2(224, 42).x)
		$Panel/ExitButton.position.y = clamp($Panel/ExitButton.position.y, 0, SCREEN_SIZE.y - Vector2(224, 42).y)


func _on_play_button_up() -> void:
	get_tree().create_tween().tween_property($Panel/PlayButton, "position", Vector2($Panel/PlayButton.position.x, 750), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property($Panel/SettingsButton, "position", Vector2(1580, $Panel/SettingsButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/ExitButton, "position", Vector2(1580, $Panel/ExitButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/GameLogo, "position", Vector2($Panel/GameLogo.position.x, -200), 0.25).set_trans(Tween.TRANS_SINE)
	await GlPizza.wait(0.5)
	$Panel/DifficultyScreen.position = Vector2(380, 776)
	$Panel/BackButton.position = Vector2(-300, 72)
	get_tree().create_tween().tween_property($Panel/DifficultyScreen, "position", Vector2(380, 120), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/BackButton, "position", Vector2(380, 72), 0.25).set_trans(Tween.TRANS_ELASTIC)

func _on_settings_button_up() -> void:
	get_tree().create_tween().tween_property($Panel/SettingsButton, "position", Vector2($Panel/SettingsButton.position.x, 750), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property($Panel/PlayButton, "position", Vector2(1580, $Panel/PlayButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/ExitButton, "position", Vector2(1580, $Panel/ExitButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)

func _on_exit_button_up() -> void:
	$Panel/ExitButton/Label.text = "no lol"
	await GlPizza.wait(2.0)
	$Panel/ExitButton/Label.text = "Exit"
	return
	get_tree().create_tween().tween_property($Panel/ExitButton, "position", Vector2($Panel/ExitButton.position.x, 750), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property($Panel/PlayButton, "position", Vector2(1580, $Panel/PlayButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/SettingsButton, "position", Vector2(1580, $Panel/SettingsButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/GameLogo, "position", Vector2($Panel/GameLogo.position.x, -200), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/Label, "position", Vector2($Panel/Label.position.x, 800), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/Label2, "position", Vector2($Panel/Label2.position.x, 800), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/Label3, "position", Vector2($Panel/Label3.position.x, 800), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/Label4, "position", Vector2($Panel/Label4.position.x, 800), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/CookingMaybeRevV3Official, "volume_db", -80, 1)
	get_tree().create_tween().tween_property($Panel/CookingMaybeRevV1Official, "volume_db", -80, 1)
	await GlPizza.wait(1.0)
	get_tree().quit()

func _on_normal_button_up() -> void:
	GlPizza.difficulty = "Normal"
	get_tree().change_scene_to_file("res://intro.tscn")

func _on_hard_button_up() -> void:
	GlPizza.difficulty = "Hard"
	get_tree().change_scene_to_file("res://intro.tscn")


func _on_back_button_up() -> void:
	get_tree().create_tween().tween_property($Panel/DifficultyScreen, "position", Vector2(380, 776), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/BackButton, "position", Vector2(-300, 72), 0.25).set_trans(Tween.TRANS_ELASTIC)
	await GlPizza.wait(0.5)
	get_tree().create_tween().tween_property($Panel/PlayButton, "position", Vector2(528, 339), 0.5).set_trans(Tween.TRANS_ELASTIC)
	#get_tree().create_tween().tween_property($Panel/SettingsButton, "position", Vector2(1580, $Panel/SettingsButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/ExitButton, "position", Vector2(528, 392), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/GameLogo, "position", Vector2($Panel/GameLogo.position.x, 160), 0.25).set_trans(Tween.TRANS_SINE)
