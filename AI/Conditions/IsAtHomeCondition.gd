extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.isAtHome == true:
		actor.hide()
		return SUCCESS
	return FAILURE

