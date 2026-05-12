extends Node2D

# 스테이지 관리자
const GROUND_Y = 375  # 모든 캐릭터의 발 위치 기준 (지면 위)

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

	# 첫 적 바로 스폰
	spawn_enemy()
	enemies_spawned += 1

func _process(delta: float) -> void:
	spawn_timer += delta

	if spawn_timer >= spawn_interval and enemies_spawned < max_enemies:
		spawn_enemy()
		spawn_timer = 0.0

func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	# 모든 적은 플레이어와 같은 y=375에서 스폰 (발이 지면에 닿는 위치)
	enemy.position = Vector2(800, GROUND_Y)
	enemies_node.add_child(enemy)
