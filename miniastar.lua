--[[
miniastar.lua

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local M = {}

local require = require
local binaryheap = require("binaryheap")

M.POINTYTOP_ODD = 1
M.POINTYTOP_EVEN = 2
M.FLATTOP_ODD = 3
M.FLATTOP_EVEN = 4
M.SQUARE = 5
M.SQUARE_X = 6

function cleanNode(node)
	node.f = 0
	node.g = 0
	node.h = 0
	node.visited = false
	node.closed = false
	node.parent = nil
end

function toCube(target, type)
	local r = target.r
	local c = target.c
	local parity
	local x
	local y
	local z
	if(type == M.POINTYTOP_ODD) then
		parity = r % 2
		x = c - (r + parity) / 2
		z = r
		y = -x-z
	elseif (type == M.POINTYTOP_EVEN) then
		parity = r % 2
		x = c - (r - parity) / 2
		z = r
		y = -x-z
	elseif (type == M.FLATTOP_ODD) then
		parity = c % 2
		x = c
		z = r - (c + parity) / 2
		y = -x-z
	else
		parity = c % 2
		x = c
		z = r - (c - parity) / 2
		y = -x-z
	end
	return {x=x,y=y,z=z}
end

function manhattanDistance(cubeA, cubeB)
	return (math.abs(cubeA.x - cubeB.x) + math.abs(cubeA.y - cubeB.y) + math.abs(cubeA.z - cubeB.z))
end

function manhattanDistanceSimple(source, destination)
	return (math.abs(source.r - destination.r) + math.abs(source.c - destination.c))
end

function digonal(source, destination)
	local digonal1 = 1
	local digonal2 = math.sqrt(2)
	local hDistance = math.abs(source.r - destination.r)
	local vDistance = math.abs(source.c - destination.c)
	return (digonal1 * (hDistance + vDistance)) + ((digonal2 - (2 * digonal1)) * math.min(hDistance, vDistance))
end

heuristics = {
	hexagon = function (source, destination, type)
		local cubeA = toCube(source, type)
		local cubeB = toCube(destination, type)
		return manhattanDistance(cubeA, cubeB)
	end,

	square  = function (source, destination, type)
		if(type == M.SQUARE_X) then
			return digonal(source, destination)
		else
			return manhattanDistanceSimple(source, destination)
		end
	end
}

function pathTo(node)
	local curr = node
	local path = {}
	while(curr) do
		table.insert(path, 1, curr)
		curr = curr.parent
	end
	return path
end

function search(graph, source, destination, options)
	graph:cleanDirty();
	local options = options or {}
	local heuristic
	if(graph.option == M.SQUARE or graph.option == M.SQUARE_X) then
		heuristic = heuristics.square
	else
		heuristic = options.heuristic or heuristics.hexagon
	end
	local closest = options.closest or false

	local openHeap = binaryheap.minUnique()
	local closestNode = source

	source.h = heuristic(source, destination, graph.option)
	source.f = source.g + source.h

	graph:markDirty(source)
	openHeap:insert(source.f, source)

	while(openHeap:peek()) do
		local f, currentNode = openHeap:peek()
		openHeap:remove(currentNode)
		if(currentNode == destination) then
			return pathTo(currentNode)
		end
		currentNode.closed = true;

		local neighbors = graph:neighbors(currentNode)

		for i, neighbor in ipairs(neighbors) do
			if(neighbor.closed == true or neighbor:isWall() == true) then
			else
				local gScore = currentNode.g + neighbor:getCost(currentNode)
				local beenVisied = neighbor.visited

				if(beenVisied == false or gScore < neighbor.g) then
					neighbor.visited = true
					neighbor.parent = currentNode
					neighbor.h = neighbor.h or heuristic(neighbor, destination)
					neighbor.g = gScore
					neighbor.f = neighbor.g + neighbor.h
					graph:markDirty(neighbor)

					if(closest) then
						if(neighbor.h < closestNode.h or
							(neighbor.h == closestNode.h and neighbor.g < closestNode.g)) then
							closestNode = neighbor
						end
					end

					if beenVisied == false then
						openHeap:insert(neighbor.f, neighbor)
					else
						openHeap:update(neighbor, neighbor.f)
					end
				end
			end

		end

	end

	if(closest) then
		return pathTo(currentNode)
	end

	return {}
end

M.search = search
M.cleanNode = cleanNode


function toString4Gridnode(self)
	return "[" .. self.r .. " " .. self.c .. "]"
end

function getCost(self)
	return self.weight
end

function isWall(self)
	return self.weight == 0
end

function GridNode(r, c, weight)
	return {
		r = r,
		c = c,
		weight = weight,
		toString = toString4Gridnode,
		getCost = getCost,
		isWall = isWall
	}
end

function init(self)
	self.dirtyNodes = {}
	for i = 1, #self.nodes do
		M.cleanNode(self.nodes[i])
	end
end

function cleanDirty(self)
	for i = 1, #self.dirtyNodes do
		M.cleanNode(self.dirtyNodes[i])
	end
	self.dirtyNodes = {}
end

function markDirty(self, node)
	table.insert(self.dirtyNodes, node)
end

function toString4Graph(self)
	local graphString = {}
	local nodes = self.grid
	for r = 1, #nodes do
		local rowDebug = {}
		local row = nodes[r]
		for c = 1, #row do
			table.insert(rowDebug, row[c].weight)
		end
		table.insert(graphString, table.concat(rowDebug, " "))
	end
	return table.concat(graphString, "\n")
end

local directionsPTO = {
	{GridNode( 1, 0), GridNode( 0,-1), GridNode(-1,-1),
	 GridNode(-1, 0), GridNode( 1,-1), GridNode( 0, 1)},
	{GridNode( 1, 0), GridNode(-1, 1), GridNode( 0,-1),
	 GridNode(-1, 0), GridNode( 0, 1), GridNode( 1, 1)}
}

local directionsPTE = {
	{GridNode( 1, 0), GridNode(-1, 1), GridNode( 0,-1),
	 GridNode(-1, 0), GridNode( 0, 1), GridNode( 1, 1)},
	{GridNode( 1, 0), GridNode( 0,-1), GridNode(-1,-1),
	 GridNode(-1, 0), GridNode( 1,-1), GridNode( 0, 1)}
}

local directionsFTO = {
	{GridNode( 1, 0), GridNode(-1, 1), GridNode( 0,-1),
	 GridNode(-1,-1), GridNode(-1, 0), GridNode( 0, 1)},
	{GridNode( 1, 1), GridNode( 1, 0), GridNode( 0,-1),
	 GridNode(-1, 0), GridNode( 1,-1), GridNode( 0, 1)}
}

local directionsFTE = {
	{GridNode( 1, 1), GridNode( 1, 0), GridNode( 0,-1),
	 GridNode(-1, 0), GridNode( 1,-1), GridNode( 0, 1)},
	{GridNode( 1, 0), GridNode(-1, 1), GridNode( 0,-1),
	 GridNode(-1,-1), GridNode(-1, 0), GridNode( 0, 1)}
}

function offset_neighbor(self, targetHex, direction)
	local parity
	if self.option < 3 then
		if targetHex.r % 2 == 0 then
			parity = 2
		else
			parity = 1
		end
	else
		if targetHex.c % 2 == 0 then
			parity = 2
		else
			parity = 1
		end
	end
	local dir
	if self.option == M.POINTYTOP_ODD then
		dir = directionsPTO[parity][direction]
	elseif self.option == M.POINTYTOP_EVEN then
		dir = directionsPTE[parity][direction]
	elseif self.option == M.FLATTOP_ODD then
		dir = directionsFTO[parity][direction]
	else
		dir = directionsFTE[parity][direction]
	end
	local r = targetHex.r + dir.r
	local c = targetHex.c + dir.c
	if (r < 1 or c < 1) then return nil end
	if (r > #self.grid or c > #self.grid[1]) then return nil end
	return self.grid[r][c]
end

function neighbors(self, target)
	local neighbors = {}
	if(self.option >= M.SQUARE) then
		local r = target.r
		local c = target.c
		local grid = self.grid
		local dirNorth = false
		local dirSouth = false
		local dirWest = false
		local dirEast = false

		if(grid[r - 1] and grid[r - 1][c] and (r - 1 > 0)) then
			table.insert(neighbors, grid[r - 1][c])
			dirNorth = true
		end

		if(grid[r + 1] and grid[r + 1][c] and (r + 1 <= #grid)) then
			table.insert(neighbors, grid[r + 1][c])
			dirSouth = true
		end

		if(grid[r] and grid[r][c - 1] and (c - 1 > 0)) then
			table.insert(neighbors, grid[r][c - 1])
			dirWest = true
		end

		if(grid[r] and grid[r][c + 1] and (c + 1 <= #grid[1])) then
			table.insert(neighbors, grid[r][c + 1])
			dirEast = true
		end

		if(self.option == M.SQUARE_X) then
			if(dirNorth and dirWest) then
				table.insert(neighbors, grid[r - 1][c - 1])
			end

			if(dirNorth and dirEast) then
				table.insert(neighbors, grid[r - 1][c + 1])
			end

			if(dirSouth and dirWest) then
				table.insert(neighbors, grid[r + 1][c - 1])
			end

			if(dirSouth and dirEast) then
				table.insert(neighbors, grid[r + 1][c + 1])
			end
		end

	else
		for i = 1, 6 do
			neighbor = self:offset_neighbor(target, i)
			if neighbor ~= nil then
				table.insert(neighbors, neighbor)
			end
		end
	end

	return neighbors
end

M.GraphFactory = function(gridIn, option)
	local graph = {
		option = option or M.POINTYTOP_ODD,
		nodes = {},
		grid = {},
		dirtyNodes = {},
		init = init,
		cleanDirty = cleanDirty,
		markDirty = markDirty,
		toString = toString4Graph,
		offset_neighbor = offset_neighbor,
		neighbors = neighbors
	}
	for r = 1, #gridIn do
		graph.grid[r] = {}

		row = gridIn[r]
		for c = 1, #row do
			local node = GridNode(r, c, gridIn[r][c])
			graph.grid[r][c] = node
			table.insert(graph.nodes, node)
		end
	end
	graph:init()
	return graph
end

local function newGraph(gridIn, option)
	return M.GraphFactory(gridIn, option)
end

M.Graph = function(gridIn, option)
	return newGraph(gridIn, option)
end

return M