function _init()
  --palt(0, false)
  --palt(14, true)
end

function _draw()
  cls()
  --[[
  local t = time() / 4
  local am = 10

  for i = 1, am do
    local a = t + i / am
    local d = cos(t + i % 2 * 0.5) * 16 + 32
    local x = cos(a) * d + 64
    local y = sin(a) * d + 64

    spr(16, x, y)
    --circ(x, y, 4, i % 2 == 0 and 2 or 1)
    --circ(x, y, 3, i % 2 == 0 and 8 or 13)
  end
  ]]
  spr(0, 0, 0, 16, 16)
end