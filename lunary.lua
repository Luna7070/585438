-- Hitbox Expander - Stable Matcha Version (change size by editing code)
-- Bright pink watermark bottom-right

local BALL_SIZE = 5.5          -- <--- CHANGE THIS NUMBER and re-execute
                              -- Examples: 8 (small), 16, 24, 36, 50, 80

local CHECK_INTERVAL = 1.5

print("[Hitbox Expander] Loaded | Current size: " .. BALL_SIZE)

local replicated = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera

-- Bright pink watermark
local watermark = Drawing.new("Text")
watermark.Visible = true
watermark.Text = "Hitbox Expander made by Luna"
watermark.Size = 20
watermark.Color = Color3.fromRGB(255, 170, 220)
watermark.Transparency = 0.55
watermark.Outline = true
watermark.Center = false
watermark.Font = 2
watermark.Position = Vector2.new(9999, 9999)

-- Wait for Assets
local assets
repeat
    assets = replicated:FindFirstChild("Assets")
    wait(1)
until assets

local ball_folder = assets:FindFirstChild("Ball")
if not ball_folder then
    print("[Error] Ball folder not found in Assets")
    return
end

print("[Active] Size " .. BALL_SIZE .. " applied | Watermark visible")

local function expand_balls()
    pcall(function()
        for _, model in ball_folder:GetChildren() do
            if model:IsA("Model") then
                for _, part in model:GetDescendants() do
                    if part:IsA("BasePart") or part:IsA("MeshPart") then
                        part.Size = Vector3.new(BALL_SIZE, BALL_SIZE, BALL_SIZE)
                    end
                end
            end
        end
    end)
end

local function update_watermark()
    pcall(function()
        local vp = camera.ViewportSize
        local estWidth = #watermark.Text * 11
        watermark.Position = Vector2.new(vp.X - estWidth - 25, vp.Y - 55)
    end)
end

expand_balls()
update_watermark()

while true do
    expand_balls()
    update_watermark()
    wait(CHECK_INTERVAL)
end

