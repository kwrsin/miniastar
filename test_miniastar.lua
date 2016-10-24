-- test_something.lua
-- package.path = package.path .. ";../?.lua"
luaunit = require("luaunit")
astar = require("miniastar")



function testFact1()

	local graph = astar.Graph({
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
			{0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 3, 3, 3, 3, 3, 3, 3, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 3, 3, 3, 3, 3, 3, 3, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 3, 3, 3, 3, 3, 3, 3, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 2, 5, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 5, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 2, 5, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 5, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 3, 5, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 5, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 4, 1, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 2, 1, 1, 1, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 4, 2, 1, 5, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 4, 2, 1, 5, 1, 1, 0},
			{0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 3, 2, 1, 5, 1, 1, 0},
			{0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 3, 3, 1, 5, 1, 1, 0},
			{0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 3, 1, 5, 1, 1, 0},
			{0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 4, 3, 1, 5, 1, 1, 0},
			{0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 3, 3, 1, 5, 1, 1, 0},
			{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},

		}, astar.FLATTOP_ODD)
	-- print("---- ", require("inspect")(graph))
	print(graph:toString())
	local path = astar.search(graph, graph.grid[1][2], graph.grid[21][32])
	print(require("inspect")(path));
	local lineUpper = ""
	local lineLower = ""
	for i = 1, (#graph.grid) do
		if(graph.option == astar.POINTYTOP_ODD) then
			if i % 2 == 0 then
				io.write(" ")
			end
		elseif(graph.option == astar.POINTYTOP_EVEN) then
			if i % 2 ~= 0 then
				io.write(" ")
			end
		end

		for j = 1, (#graph.grid[1]) do
			local flg = false
			if(graph.option == astar.FLATTOP_EVEN) then
				for k, v in pairs(path) do
					if(v.r == i and v.c == j) then
						if j % 2 == 0 then
							lineUpper = lineUpper .. "@ "
							lineLower = lineLower .. "  "
						else
							lineUpper = lineUpper .. "  "
							lineLower = lineLower .. "@ "
						end
						flg = true
						break
					end
				end
				if flg == false then
					if j % 2 == 0 then
						lineUpper = lineUpper .. graph.grid[i][j].weight .. " "
						lineLower = lineLower .. "  "
					else
						lineUpper = lineUpper .. "  "
						lineLower = lineLower .. graph.grid[i][j].weight .. " "
					end
				end
			elseif(graph.option == astar.FLATTOP_ODD) then
				for k, v in pairs(path) do
					if(v.r == i and v.c == j) then
						if j % 2 == 0 then
							lineUpper = lineUpper .. "  "
							lineLower = lineLower .. "@ "
						else
							lineUpper = lineUpper .. "@ "
							lineLower = lineLower .. "  "
						end
						flg = true
						break
					end
				end
				if flg == false then
					if j % 2 == 0 then
						lineUpper = lineUpper .. "  "
						lineLower = lineLower .. graph.grid[i][j].weight .. " "
					else
						lineUpper = lineUpper .. graph.grid[i][j].weight .. " "
						lineLower = lineLower .. "  "
					end
				end
			else
				for k, v in pairs(path) do
					if(v.r == i and v.c == j) then
						-- graph.grid[i][j].weight = 9
						io.write("@ ")
						flg = true
						break
					end
				end
				if flg == false then
					local dat = graph.grid[i][j].weight .. " "
					io.write(dat)
				end
			end
		end
		if(#lineUpper > 0) then io.write(lineUpper.."\n");lineUpper = "" end
		if(#lineLower > 0) then io.write(lineLower);lineLower = "" end
		io.write("\n")
	end
	-- print(graph:toString())
	-- luaunit.assertTrue(graph.grid[2][2]:isWall())
	-- luaunit.assertFalse(graph.grid[2][1]:isWall())
	-- luaunit.assertEquals(graph.grid[2][2]:getCost(), 0)
	-- luaunit.assertEquals(graph.grid[2][3]:getCost(), 2)
	-- luaunit.assertEquals(graph.grid[3][3]:getCost(), 4)
	-- luaunit.assertEquals((graph.grid[2][2]):toString(), "[2 2]")
	-- luaunit.assertNotEquals((graph.grid[5][5]):toString(), "[2 2]")

	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[2][2], 1)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[2][2], 2)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[2][2], 3)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[2][2], 4)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[2][2], 5)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[2][2], 6)))

	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[3][3], 1)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[3][3], 2)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[3][3], 3)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[3][3], 4)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[3][3], 5)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[3][3], 6)))

	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[5][3], 1)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[5][3], 2)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[5][3], 3)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[5][3], 4)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[5][3], 5)))
	-- print("---- ", require("inspect")(graph:offset_neighbor(graph.grid[5][3], 6)))


	-- print("---- ", require("inspect")(graph:neighbors(graph.grid[2][2])))
	-- for k, v in pairs(graph:neighbors(graph.grid[1][1])) do
	-- 	print(k, v.r, v.c, v.weight)
	-- end

	-- for k, v in pairs(graph:neighbors(graph.grid[6][5])) do
	-- 	print(k, v.r, v.c, v.weight)
	-- end

end
os.exit(luaunit.LuaUnit.run())