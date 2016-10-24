# miniastar

## Description
miniastar is a simple pathfinding library for turn based 2d game that is written by pure LUA.

## Usage
1. define a 2d array and create a graph by using that array and a parameter. 
you can set one of following value as second parameter to Graph.  
2. set start point and end point and then get a short path array.

### Parameters
##### POINTYTOP_ODD
miniastar expects uniform hexagon gird (upper center coner).  
the array of even rows shift one step to the rightwards.  
Ex)
```
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 0, 2, 1, 0, 1, 1, 1, 1, 0
0, 1, 1, 1, 0, 1, 2, 2, 1, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 1, 1, 1, 0, 1, 1, 1, 1, 0
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
==>
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 0, 2, 1, 0, 1, 1, 1, 1, 0
  0, 1, 1, 1, 0, 1, 2, 2, 1, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
  0, 1, 1, 1, 0, 1, 1, 1, 1, 0
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
```
Rightwards Wave  
you can go right or left or upper right or upper left or bottom right or bottom left.
	
##### POINTYTOP_EVEN
miniastar expects uniform hexagon gird (upper center coner).  
the array of odd rows shift one step to the rightwards.  
Ex)
```
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 0, 2, 1, 0, 1, 1, 1, 1, 0
0, 1, 1, 1, 0, 1, 2, 2, 1, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 1, 1, 1, 0, 1, 1, 1, 1, 0
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
==>
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
  0, 0, 2, 1, 0, 1, 1, 1, 1, 0
0, 1, 1, 1, 0, 1, 2, 2, 1, 0
  0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 1, 1, 1, 0, 1, 1, 1, 1, 0
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
```
Leftwards Wave  
you can go right or left or upper right or upper left or bottom right or bottom left.

##### FLATTOP_ODD
miniastar expects uniform hexagon gird (upper center edge).  
the array of even columns shift one step to the downwards.  
Ex)
```
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 0, 2, 1, 0, 1, 1, 1, 1, 0
0, 1, 1, 1, 0, 1, 2, 2, 1, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 1, 1, 1, 0, 1, 1, 1, 1, 0
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
==>
0,  , 0,  , 0,  , 0,  , 0,   
 , 0,  , 0,  , 0,  , 0,  , 0 
0,  , 1,  , 1,  , 1,  , 0,   
 , 1,  , 0,  , 0,  , 1,  , 0 
0,  , 2,  , 0,  , 1,  , 1,   
 , 0,  , 1,  , 1,  , 1,  , 0 
0,  , 1,  , 0,  , 2,  , 1,   
 , 1,  , 1,  , 1,  , 2,  , 0 
0,  , 1,  , 1,  , 1,  , 0,   
 , 1,  , 0,  , 0,  , 1,  , 0 
0,  , 1,  , 0,  , 1,  , 1,   
 , 1,  , 1,  , 1,  , 1,  , 0 
0,  , 0,  , 0,  , 0,  , 0,   
 , 0,  , 0,  , 0,  , 0,  , 0 
```
 Downwards Wave  
 you can go upper or bottom or upper right or upper left or bottom right or bottom left.
 
##### FLATTOP_EVEN
miniastar expects uniform hexagon gird (upper center edge).  
the array of odd columns shift one step to the downwards.  
Ex)
```
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 0, 2, 1, 0, 1, 1, 1, 1, 0
0, 1, 1, 1, 0, 1, 2, 2, 1, 0
0, 1, 1, 0, 1, 0, 1, 1, 0, 0
0, 1, 1, 1, 0, 1, 1, 1, 1, 0
0, 0, 0, 0, 0, 0, 0, 0, 0, 0
==>
 , 0,  , 0,  , 0,  , 0,  , 0 
0,  , 0,  , 0,  , 0,  , 0,   
 , 1,  , 0,  , 0,  , 1,  , 0 
0,  , 1,  , 1,  , 1,  , 0,   
 , 0,  , 1,  , 1,  , 1,  , 0 
0,  , 2,  , 0,  , 1,  , 1,   
 , 1,  , 1,  , 1,  , 2,  , 0 
0,  , 1,  , 0,  , 2,  , 1,   
 , 1,  , 0,  , 0,  , 1,  , 0 
0,  , 1,  , 1,  , 1,  , 0,   
 , 1,  , 1,  , 1,  , 1,  , 0 
0,  , 1,  , 0,  , 1,  , 1,  
 , 0,  , 0,  , 0,  , 0,  , 0 
0,  , 0,  , 0,  , 0,  , 0,   
```
Upwards Wave  
 you can go upper or bottom or upper right or upper left or bottom right or bottom left.

##### SQUARE
miniastar expects uniform square grid.  

##### SQUARE_X
miniastar expects uniform square grid with digonal  



## Example
```lua
local miniastar = require("miniastar")
local map = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 1, 1, 0, 1, 0, 1, 1, 0, 0},
	{0, 0, 2, 1, 0, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 0, 1, 2, 2, 1, 0},
	{0, 1, 1, 0, 1, 0, 1, 1, 0, 0},
	{0, 1, 1, 1, 0, 1, 1, 1, 1, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}
local graph = miniastar.Graph(map, miniastar.SQUARE)
...
...

local start = graph.grid[2][2]
local goal = graph.grid[6][8]
local path = miniastar.search(graph, start, goal) 
...
...
```

### Result
```
0	0	0	0	0	0	0	0	0	0	
0	@	1	0	1	0	1	1	0	0	
0	0	@	1	0	1	1	1	1	0	
0	1	1	@	0	1	2	2	1	0	
0	1	1	0	@	0	1	1	0	0	
0	1	1	1	0	@	@	@	1	0	
0	0	0	0	0	0	0	0	0	0
```	

search function returns array in order from start to end or {} if it could not find out.  
path array elements has some properties.  
r  = row(horizontal position of array)  
c = column(virtical position of array)  
f = movement score + heuristic score  
g = movement score (estimated cost from start point so far)  
h = heuristic score (distance from start to goal)  
parent = next square  
weight = value of graph you set  

Note that you can't use float value(only int type),  
you can't set negative value to wegiht and  
wegith = 0 is wall, so you can't pass there  

## Requirements
miniastar needs **binaryheap.lua**  
you can get the library by using luarockets or downloaing direcotry from [here](https://github.com/Tieske/binaryheap.lua)

## Credit and Thank you
[javascript-astar](https://github.com/bgrins/javascript-astar)  
[Hexagonal Grids](http://www.redblobgames.com/grids/hexagons/)

## Lisence
MIT/X11
