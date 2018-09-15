time = tsab_get_time
exit = tsab_quit

_update = function() end
_draw = function() end
_init = function() end

tsab_init = function()
  tsab_resize(tsab_graphics_get_size())
  _init()
end

tsab_update = function()
  _update()
end

tsab_destroy = function() end

tsab_error = function(error)
	print("tsab_error: " .. error)
	exit()
end

local canvas = tsab_graphics_new_canvas(128, 128)
local x, y, s

tsab_resize = function(w, h)
  s = math.floor(math.min(
    w / 128, h / 128
  ))

  x = (w - s * 128) / 2
  y = (h - s * 128) / 2
end

tsab_draw = function()
  tsab_graphics_set_canvas(canvas)
  _draw()
  tsab_graphics_set_canvas(-1)
  tsab_graphics_draw(canvas, x, y, 0, 0, 0, s, s)
end

--
-- input
--

local keymap = {
  [0] = "left", "right", "up", "down", "x", { "z", "c" }
}

function btn(id)
  local t = keymap[id]

  if not t then
    return false
  elseif type(t) == "table" then
    for _, v in pairs(t) do
      if tsab_input_is_down(v) then return true end
    end

    return false
  else
    return tsab_input_is_down(t)
  end
end

function btnp(id)
  local t = keymap[id]

  if not t then
    return false
  elseif type(t) == "table" then
    for _, v in pairs(t) do
      if tsab_input_was_pressed(v) then return true end
    end

    return false
  else
    return tsab_input_was_pressed(t)
  end
end

--
-- graphics
--

local palette = {
	[0] = {0, 0, 0},
	{29, 43, 83},
	{126, 37, 83},
	{0, 135, 81},
	{171, 82, 54},
	{95, 87, 79},
	{194, 195, 199},
	{255, 241, 232},
	{255, 0, 77},
	{255, 163, 0},
	{255, 240, 36},
	{0, 231, 86},
	{41, 173, 255},
	{131, 118, 156},
	{255, 119, 168},
	{255, 204, 170}
}

for i = 0, 15 do
  local t = palette[i]

  for k, v in ipairs(t) do
    t[k] = v / 255
  end
end

color = function(i)
  local c = math.floor(i) % 16
  local p = palette[c]
  local r = p[1]
  local g = p[2]
  local b = p[3]

	tsab_graphics_set_color(r, g, b, 1)

	if active_shader then
		tsab_shaders_send_vec4(active_shader, "color", r or 1, g or 1, b or 1, 1)
	end
end

circ = function(x, y, r, c)
  if c then color(c) end
  tsab_graphics_circle(x, y, r)
end

rect = function(x1, y1, x2, y2, c)
  if c then color(c) end
  tsab_graphics_rectangle(x1, y1, x2 - x1, y2 - y1)
end

pset = function(x, y, c)
  if c then color(c) end
  tsab_graphics_point(x, y)
end

line = function(x1, y1, x2, y2, c)
  if c then color(c) end
  tsab_graphics_line(x1, y1, x2 - x1, y2 - y1)
end

print = function(s, x, y, c)
  if c then color(c) end
  print(s, x, y)
end

camera = tsab_graphics_camera
title = tsab_graphics_set_title
cls = tsab_graphics_clear

--
-- math
--

flr = math.floor
ceil = math.ceil
function cos(x) return math.cos((x or 0)*(math.pi*2)) end
function sin(x) return math.sin(-(x or 0)*(math.pi*2)) end
function atan2(x,y) return (0.75 + math.atan2(x,y) / (math.pi * 2)) % 1.0 end