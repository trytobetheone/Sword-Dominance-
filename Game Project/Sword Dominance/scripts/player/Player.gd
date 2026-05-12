extends CharacterBody2D

var speed: float = 250.0
var health: int = 100
var max_health: int = 100
var attack_cooldown: float = 0.3
var attack_timer: float = 0.0
var facing_right: bool = true
var game_manager: Node = null
var attack_flash_timer: float = 0.0
var attack_flash_duration: float = 0.15
var original_color: Color = Color.WHITE

# 패링 시스템
var parrying: bool = false
var parry_duration: float = 0.2
var parry_timer: float = 0.0
var parry_cooldown: float = 0.5
var parry_cooldown_timer: float = 0.0

func _ready() -> void:
	add_to_group("player")
	print("플레이어 준비됨!")

	# 콜리전 셰이프 설정
	if has_node("CollisionShape2D"):
		if $CollisionShape2D.shape == null:
			var shape = RectangleShape2D.new()
			shape.size = Vector2(30, 50)
			$CollisionShape2D.shape = shape
			print("콜리전 셰이프 생성됨")
		else:
			print("콜리전 셰이프 이미 있음")

	# 스프라이트 색상 저장
	if has_node("Sprite2D"):
		original_color = $Sprite2D.modulate
		print("스프라이트 색상 저장: ", original_color)

	game_manager = get_tree().get_first_node_in_group("game_manager")
	print("게임 매니저 찾음: ", game_manager)
	print("플레이어 포지션: ", position)

func _process(delta: float) -> void:
	handle_movement(delta)
	attack_timer -= delta
	update_attack_flash(delta)
	update_parry(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_Q:
				print("Q 키 눌림!")
				perform_attack()
				get_tree().root.set_input_as_handled()
			elif event.keycode == KEY_W:
				print("W 키 눌림 - 패링!")
				perform_parry()
				get_tree().root.set_input_as_handled()
			elif event.keycode == KEY_LEFT:
				print("LEFT 키 눌림!")
				get_tree().root.set_input_as_handled()
			elif event.keycode == KEY_RIGHT:
				print("RIGHT 키 눌림!")
				get_tree().root.set_input_as_handled()

func handle_movement(delta: float) -> void:
	var input_dir = Input.get_axis("ui_left", "ui_right")

	if input_dir != 0:
		print("이동 입력: ", input_dir)
		velocity.x = input_dir * speed
		facing_right = input_dir > 0
	else:
		velocity.x = 0

	move_and_slide()

func perform_attack() -> void:
	if attack_timer <= 0:
		attack_timer = attack_cooldown
		attack_flash_timer = attack_flash_duration

		# 공격 이펙트: 플레이어 색상 변경
		if has_node("Sprite2D"):
			$Sprite2D.modulate = Color.WHITE

		# 슬래시 이펙트 생성
		create_slash_effect()

		# 공격 범위 내 적 찾기 (y=-20: 플레이어 발 위치 기준)
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsShapeQueryParameters2D.new()
		var shape = RectangleShape2D.new()
		shape.size = Vector2(50, 30)
		query.shape = shape
		query.transform = Transform2D.IDENTITY.translated(position + Vector2(40 if facing_right else -40, -20))

		var result = space_state.intersect_shape(query)

		for collision in result:
			var collider = collision.collider
			if collider.is_in_group("enemy"):
				collider.take_damage(20)
				if game_manager:
					game_manager.add_score(10)

func create_slash_effect() -> void:
	var slash = preload("res://scenes/weapons/SlashEffect.tscn").instantiate()
	slash.position = position + Vector2(0, -30)
	if not facing_right:
		slash.scale.x = -1  # 왼쪽 향할 때 반전
	get_parent().add_child(slash)

func update_attack_flash(delta: float) -> void:
	if attack_flash_timer > 0:
		attack_flash_timer -= delta
		if attack_flash_timer <= 0 and has_node("Sprite2D"):
			$Sprite2D.modulate = original_color

func perform_parry() -> void:
	if parry_cooldown_timer <= 0:
		parrying = true
		parry_timer = parry_duration
		parry_cooldown_timer = parry_cooldown

		# 패링 이펙트: 플레이어 색상 파란색으로 변경
		if has_node("Sprite2D"):
			$Sprite2D.modulate = Color.CYAN

func update_parry(delta: float) -> void:
	if parry_timer > 0:
		parry_timer -= delta
		if parry_timer <= 0:
			parrying = false
			if has_node("Sprite2D"):
				$Sprite2D.modulate = original_color

	if parry_cooldown_timer > 0:
		parry_cooldown_timer -= delta

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

func die() -> void:
	queue_free()
