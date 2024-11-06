extends StaticBody2D

@export var STRENGTH = 10000
var vector: Vector2 = Vector2(-STRENGTH, 0)
var affected_players = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $Sprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    var bodies = $Area2D.get_overlapping_bodies()
    affected_players = []
    for body in bodies:
        if body is CharacterPlatforming:
            affected_players.append(body)
            body.apply_fan_force(vector * delta)
    for player in Globals.player_characters.values():
        if player not in affected_players:
            player.fan_vector = Vector2(0,0)