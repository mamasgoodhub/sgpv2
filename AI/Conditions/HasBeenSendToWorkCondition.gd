extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.hasBeenSendToWork:
		return SUCCESS
	return FAILURE

