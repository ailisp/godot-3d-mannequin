extends Spatial
class_name Mannequiny
# Controls the animation tree's transitions for this animated character.

# # It has a signal connected to the player state machine, and uses the resulting
# state names to translate them into the states for the animation tree.

enum States { IDLE, RUN, AIR, LAND, FIGHT }

onready var animation_tree: AnimationTree = $AnimationTree
onready var _playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

var move_direction := Vector3.ZERO setget set_move_direction
var is_moving := false setget set_is_moving
var head_hit: Node = null
var right_fist_hit: Node = null


func _ready() -> void:
	animation_tree.active = true


func set_move_direction(direction: Vector3) -> void:
	move_direction = direction
	animation_tree["parameters/move_ground/blend_position"] = direction.length()


func set_is_moving(value: bool) -> void:
	is_moving = value
	animation_tree["parameters/conditions/is_moving"] = value


func transition_to(state_id: int) -> void:
	match state_id:
		States.IDLE:
			_playback.travel("idle")
		States.LAND:
			_playback.travel("land")
		States.RUN:
			_playback.travel("move_ground")
		States.AIR:
			_playback.travel("jump")
		States.FIGHT:
			_playback.travel("fight_punch")
		_:
			_playback.travel("idle")


func _on_Area_body_entered(body):
	print(body.name)
	head_hit = body


func _on_Area_body_exited(body):
	head_hit = null


func _on_RightFist_body_entered(body):
	right_fist_hit = body


func _on_RightFist_body_exited(body):
	right_fist_hit = null
