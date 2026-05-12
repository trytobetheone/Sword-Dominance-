extends Node

# 게임 전투 관리자
# 플레이어와 적의 상호작용 관리

func _ready() -> void:
	pass

func on_hit(attacker: Node, defender: Node, damage: int) -> void:
	if defender.has_method("take_damage"):
		defender.take_damage(damage)
