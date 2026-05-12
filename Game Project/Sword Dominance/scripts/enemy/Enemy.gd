extends CharacterBody2D

# 기본 적 클래스
var speed: float = 100.0
var health: int = 20
var max_health: int = 20
var damage: int = 10

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	move_and_slide()

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()

func die() -> void:
	print("적 사망!")
	queue_free()
