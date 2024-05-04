extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.GetWorkplace() != null:
		return SUCCESS
	return FAILURE

