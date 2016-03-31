
vector = require "vector"


function love.load()
	windowWidth  = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	quad = {
		vector(0,0),
		vector(1280,0),
		vector(1280,720),
		vector(0,720)
	}

	vert = {quad[1].x, quad[1].y, quad[2].x, quad[2].y, quad[3].x, quad[3].y, quad[4].x, quad[4].y}

	center = quad[3] / 2

	-- angle = vector(windowWidth * windowHeight, 0)
	rad = math.rad(180)

	-- angle:rotated(rad)

	line = {             -- split line
		-- vector(windowWidth/2 - angle.x, windowHeight/2 - angle.y),
		-- vector(windowWidth/2 + angle.x, windowHeight/2 + angle.y)
	}
	intersection = vector()

	intersection.x = math.cos(rad + math.pi/2) * (windowWidth/4)
	intersection.y = math.sin(rad + math.pi/2) * (windowHeight/4)

	mode = 0

	proj = vector()

	buffer = {0,0,0,0}

end

function love.draw()
	love.graphics.polygon( "line", vert )
	love.graphics.circle('line', center.x, center.y, 5)
	love.graphics.line(windowWidth/2 + math.cos(rad) * windowWidth, windowHeight/2 - math.sin(rad) * windowHeight, windowWidth/2 - math.cos(rad) * windowWidth, windowHeight/2 + math.sin(rad) * windowHeight)                                         --line[1].x, line[1].y, line[2].x, line[2].y)
	-- love.graphics.circle('line', center.x, center.y, windowHeight/2)
	love.graphics.ellipse( "line", center.x, center.y, windowWidth/4 ,windowHeight/4)
	love.graphics.rectangle("line", center.x - windowWidth/4, center.y - windowHeight/4, windowWidth/2 ,windowHeight/2)
	-- love.graphics.print("angle: "..rad, 10, 10)
	-- love.graphics.print("angle: "..math.deg(rad), 10, 25)

	love.graphics.line(center.x + intersection.x, center.y + intersection.y,  center.x, center.y)

	-- love.graphics.line(0, 0, windowWidth, windowHeight)
	-- love.graphics.line(windowWidth, 0, 0, windowHeight)

	love.graphics.circle('line', center.x + intersection.x, center.y + intersection.y, 5)
	love.graphics.circle('line', center.x - intersection.x, center.y - intersection.y, 5)
	love.graphics.circle('line', proj.x, proj.y,  5)

	love.graphics.circle('line', moy.x, moy.y,  5)

	love.graphics.print("mode: "..mode, 10, 40)

	love.graphics.line(buffer)


end

function love.update(dt)
	rad = (rad + (math.pi/4 * dt))
	-- angle = angle:rotated((math.pi/40 * dt))

	line = {             -- split line
		-- vector(windowWidth/2 - angle.x, windowHeight/2 - angle.y),
		-- vector(windowWidth/2 + angle.x, windowHeight/2 + angle.y)
	}

	intersection.x = math.cos(rad) * (windowWidth/4)
	intersection.y = -math.sin(rad) * (windowHeight/4)

	mode = math.floor(((math.deg(rad)+45)%360)/(90))+1

	if mode == 1 then
		proj = vector(3*windowWidth/4, center.y - (( windowHeight/4)*math.tan(rad)))
	elseif mode == 2 then
		proj = vector(center.x + ((windowWidth/4) / math.tan(rad)), windowHeight/4)
	elseif mode == 3 then
		proj = vector(windowWidth/4, center.y + (( windowHeight/4)*math.tan(rad)))
	elseif mode == 4 then
		proj = vector(center.x - ((windowWidth/4) / math.tan(rad)), 3*windowHeight/4)
	end

	moy = (vector(center.x + intersection.x, center.y + intersection.y) + proj) / 2

	table.insert(buffer, moy.x)
	table.insert(buffer, moy.y)

end
