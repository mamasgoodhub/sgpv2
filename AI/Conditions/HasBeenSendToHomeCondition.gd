extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.hasBeenSendToHome:
		return SUCCESS
	return FAILURE

