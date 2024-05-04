extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.isAtWork = false
	#if actor.home.position.distance_to(actor.position) < 1:
		#return SUCCESS
	#actor.velocity = actor.position.dire
	#actor.move_and_slide()
	#return RUNNING
	actor.velocity = (actor.position.direction_to(actor.home.position) ) * actor.position.distance_to(actor.home.position) * 0.03 * actor.speed
	if actor.position.distance_to(actor.home.position) < 10:
		actor.isAtHome = true
		return SUCCESS
	actor.show()
	actor.move_and_slide()
	return RUNNING

