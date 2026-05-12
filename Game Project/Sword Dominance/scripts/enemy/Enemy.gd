extends CharacterBody2D

var speed: float = 100.0
var health: int = 30
var max_health: int = 30
var damage: int = 10
var player: Node2D = null
var attack_range: float = 30.0
var attack_cooldown: float = 1.0
var attack_timer: float = 0.0

# 패링 및 스턴 시스템
var stunned: bool = false
var stun_timer: float = 0.0

func _ready() -> void:
	add_to_group("enemy")
	if has_node("CollisionShape2D"):
		var shape = RectangleShape2D.new()
		shape.size = Vector2(25, 40)
		$CollisionShape2D.shape = shape

func _process(delta: float) -> void:
	# 스턴 상태 업데이트
	if stunned:
		stun_timer -= delta
		if stun_timer <= 0:
			stunned = false
		velocity.x = 0  # 스턴 중이면 이동 정지
		move_and_slide()
		return

	update_player_reference()
	chase_player()
	attack_player()
	attack_timer -= delta
	move_and_slide()

func update_player_reference() -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("player")

func chase_player() -> void:
	if player == null or not is_instance_valid(player):
		return

	var direction = sign(player.position.x - position.x)
	velocity.x = direction * speed

func attack_player() -> void:
	if player == null or not is_instance_valid(player):
		return

	var distance = position.distance_to(player.position)

	if distance < attack_range and attack_timer <= 0:
		# 플레이어가 패링 중이면 공격 무효화
		if player.parrying:
			take_parry()
			return

		player.take_damage(damage)
		attack_timer = attack_cooldown
		create_slash_effect()  # 적도 슬래시 이펙트 생성

func take_parry() -> void:
	stunned = true
	stun_timer = 1.0  # 1초 동안 스턴
	print("적이 패링당함!")

func create_slash_effect() -> void:
	var slash = preload("res://scenes/weapons/SlashEffect.tscn").instantiate()
	slash.position = position + Vector2(0, -30)
	if velocity.x < 0:  # 왼쪽으로 이동 중이면 반전
		slash.scale.x = -1
	get_parent().add_child(slash)

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

func die() -> void:
	queue_free()
