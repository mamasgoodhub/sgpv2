extends Node

enum PHASES {
	INTRO,
	BUILD,
	EVENT,
	LOSEROUND,
	OUTRO
}

func StartPhase(phase: PHASES) -> void:
	match phase:
		PHASES.BUILD:
			_PhaseBuild()


func _PhaseBuild() -> void:
	pass
