extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.home != null:
		return SUCCESS
	return FAILURE

