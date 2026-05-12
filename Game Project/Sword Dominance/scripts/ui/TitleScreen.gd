extends Node

var title_label: Label
var can_skip: bool = false

func _ready() -> void:
	print("타이틀 화면 시작")
	title_label = get_node("CanvasLayer/Title")

	# 초기에 투명하게 설정
	title_label.modulate.a = 0.0

	# 페이드인 애니메이션
	var tween = create_tween()
	tween.tween_property(title_label, "modulate:a", 1.0, 2.0)
	tween.tween_callback(func(): can_skip = true)

func _input(event: InputEvent) -> void:
	if not can_skip:
		return

	if event is InputEventKey and event.pressed:
		# QWERTY 키 확인 (A-Z)
		if event.keycode >= KEY_A and event.keycode <= KEY_Z:
			print("키 눌림: ", char(event.keycode))
			start_game()
			get_tree().root.set_input_as_handled()

func start_game() -> void:
	# 페이드아웃 애니메이션
	var tween = create_tween()
	tween.tween_property(title_label, "modulate:a", 0.0, 1.0)
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://scenes/Main.tscn"))
