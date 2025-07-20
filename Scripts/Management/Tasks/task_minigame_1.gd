extends Node2D
class_name maze

var width : int
var height : int
var start : Vector2i
var end : Vector2i
var grid : grid2

class grid2:
	var width : int
	var height : int
	var list : Array[int]
	
	func _init(new_wid : int, new_hei : int):
		width = new_wid
		height = new_hei
		list = []
		list.resize(width * height)
	
	func set_at_point(point : Vector2i, val : int):
		list[point.x + width * point.y] = val
	
	func get_from_point(point : Vector2i) -> int:
		return list[point.x + width * point.y]
	
	func recycle(wid : int, hei : int):
		list.resize(wid * hei)
		list.fill(0)
		width = wid
		height = hei

func _init(wid : int, hei : int):
	width = wid
	height = hei

func gen_maze():
	if !grid: grid = grid2.new(width, height)
	else: grid.recycle(width, height)
	var cardir : Array[Vector2i] = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
	
	start = Vector2i(randi_range(1, width - 2), randi_range(1, height - 2))
	end = start
	grid.set_at_point(start, 1)
	
	var points : Array[Vector2i] = [start]
	var queue : Array[Vector2i] = [start]
	
	while queue.size() > 0:
		cardir.shuffle()
		var added := false
		
		var current = queue.back()
		for dir in cardir:
			var next = current + dir
			
			if next.x <= 0 or next.x >= width - 1 or next.y <= 0 or next.y >= height -1: continue
			if grid.get_from_point(next) : continue
			var orth = Vector2i(next.x, next.y)
			var addnext := true
			
			for neighbor in [next + orth, next + orth + dir, next + dir, next - orth + dir, next - orth]:
				if (grid.get_from_point(neighbor)): 
					addnext = false
					break
			
			if addnext:
				points.append(next)
				queue.append(next)
				grid.set_at_point(next, grid.get_from_point(current)+1)
				added = true
				if grid.get_from_point(next) > grid.get_from_point(end):
					end = next
				break
		if !added:
			queue.pop_back()
