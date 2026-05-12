extends Node2D

# 스테이지 관리자
var enemy_scene = preload("res://scenes/enemy/KhitanSoldier.tscn")
var spawn_timer: float = 0.0
var spawn_interval: float = 2.0
var enemies_spawned: int = 0
var max_enemies: int = 15
var enemies_node: Node

func _ready() -> void:
	enemies_node = get_node("Enemies")
	if enemies_node == null:
		enemies_node = Node.new()
		enemies_node.name = "Enemies"
		add_child(enemies_node)

func _process(delta: float) -> void:
	spawn_timer += delta

	if spawn_timer >= spawn_interval and enemies_spawned < max_enemies:
		spawn_enemy()
		spawn_timer = 0.0

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	var random_y = randf_range(250, 350)
	enemy.position = Vector2(800, random_y)
	enemies_node.add_child(enemy)
	enemies_spawned += 1
