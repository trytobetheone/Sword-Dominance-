extends CharacterBody2D

var speed: float = 100.0
var health: int = 30
var max_health: int = 30
var damage: int = 10
var player: Node2D = null
var attack_range: float = 30.0
var attack_cooldown: float = 1.0
var attack_timer: float = 0.0

func _ready() -> void:
	add_to_group("enemy")
	if has_node("CollisionShape2D"):
		var shape = RectangleShape2D.new()
		shape.size = Vector2(25, 40)
		$CollisionShape2D.shape = shape

func _process(delta: float) -> void:
	update_player_reference()
	chase_player()
	attack_player()
	attack_timer -= delta
	move_and_slide()

func update_player_reference() -> void:
	if player == null:
		player = get_tree().first_child_in_group("player")

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
		player.take_damage(damage)
		attack_timer = attack_cooldown

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

func die() -> void:
	queue_free()
