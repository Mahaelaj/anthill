extends Node

static func sortAStarPositionsAsc(a, b):
	if a.global_position.x < b.global_position.x:
		return true
	return false
