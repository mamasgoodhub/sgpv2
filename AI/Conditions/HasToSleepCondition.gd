extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	var colonyService: Node = get_tree().get_root().get_node("World").get_node("ColonyManager/ColonyService")
	if colonyService.currentAlienState == colonyService.ALIENSTATE.SLEEP:
		return SUCCESS
	return FAILURE
