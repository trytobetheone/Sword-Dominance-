extends CharacterBody2D

var speed: float = 250.0
var health: int = 100
var max_health: int = 100
var attack_cooldown: float = 0.5
var attack_timer: float = 0.0
var facing_right: bool = true
var game_manager: Node = null
var attack_flash_timer: float = 0.0
var attack_flash_duration: float = 0.15
var original_color: Color = Color.WHITE

func _ready() -> void:
	add_to_group("player")
	if has_node("CollisionShape2D"):
		var shape = RectangleShape2D.new()
		shape.size = Vector2(30, 50)
		$CollisionShape2D.shape = shape
	if has_node("Sprite2D"):
		original_color = $Sprite2D.modulate
	game_manager = get_tree().get_first_node_in_group("game_manager")

func _process(delta: float) -> void:
	handle_input()
	handle_movement(delta)
	attack_timer -= delta
	update_attack_flash(delta)

func handle_input() -> void:
	if Input.is_action_just_pressed("attack"):
		perform_attack()

func handle_movement(delta: float) -> void:
	var input_dir = Input.get_axis("ui_left", "ui_right")

	if input_dir != 0:
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

		# 공격 범위 내 적 찾기
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsShapeQueryParameters2D.new()
		var shape = RectangleShape2D.new()
		shape.size = Vector2(50, 30)
		query.shape = shape
		query.transform = Transform2D.IDENTITY.translated(position + Vector2(40 if facing_right else -40, -15))

		var result = space_state.intersect_shape(query)

		for collision in result:
			var collider = collision.collider
			if collider.is_in_group("enemy"):
				collider.take_damage(20)
				if game_manager:
					game_manager.add_score(10)

func update_attack_flash(delta: float) -> void:
	if attack_flash_timer > 0:
		attack_flash_timer -= delta
		if attack_flash_timer <= 0 and has_node("Sprite2D"):
			$Sprite2D.modulate = original_color

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

func die() -> void:
	queue_free()
