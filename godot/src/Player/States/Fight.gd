extends PlayerState
# Basic state when the player is moving around until jumping or lack of input.


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if skin._playback.get_current_play_position() >= skin._playback.get_current_length():
		_state_machine.transition_to("Move/Idle")

func enter(msg: = {}) -> void:
	skin.transition_to(skin.States.FIGHT)
	_parent.enter()


func exit() -> void:
	_parent.exit()
