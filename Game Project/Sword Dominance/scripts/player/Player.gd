extends CharacterBody2D

# 플레이어 통계
var speed: float = 200.0
var jump_force: float = -400.0
var health: int = 100
var max_health: int = 100

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	handle_input()
	handle_movement(delta)

func handle_input() -> void:
	var input_dir = Input.get_axis("ui_left", "ui_right")

	if Input.is_action_just_pressed("attack"):
		perform_attack()

	if Input.is_action_just_pressed("special_attack"):
		perform_special_attack()

	if Input.is_action_just_pressed("interact"):
		interact()

	if Input.is_action_just_pressed("ultimate"):
		perform_ultimate()

func handle_movement(delta: float) -> void:
	var input_dir = Input.get_axis("ui_left", "ui_right")

	if input_dir != 0:
		velocity.x = input_dir * speed
	else:
		velocity.x = 0

	move_and_slide()

func perform_attack() -> void:
	# Q - 기본 공격
	print("기본 공격!")

func perform_special_attack() -> void:
	# W - 특수 공격
	print("특수 공격!")

func interact() -> void:
	# E - 상호작용
	print("상호작용!")

func perform_ultimate() -> void:
	# R - 궁극기
	print("궁극기!")

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

func die() -> void:
	print("플레이어 사망!")
	queue_free()
