extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.isAtHome = false
	#if actor.home.position.distance_to(actor.position) < 1:
		#return SUCCESS
	#actor.velocity = actor.position.dire
	#actor.move_and_slide()
	#return RUNNING
	actor.velocity = (actor.position.direction_to(actor.workplace.position) ) * actor.position.distance_to(actor.workplace.position) * 0.03 * actor.speed
	if actor.position.distance_to(actor.workplace.position) < 10:
		actor.isAtWork = true
		return SUCCESS
	actor.show()
	actor.move_and_slide()
	return RUNNING
