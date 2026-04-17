L_1_[5] = game:GetService("Players")["LocalPlayer"]

-- ==================== UI (DÁN VÀO ĐÂY) ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer

-- Clear old UI
if player.PlayerGui:FindFirstChild("MeowHubUI") then
    player.PlayerGui.MeowHubUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "MeowHubUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player.PlayerGui

-- Logo Toggle
local logoBtn = Instance.new("ImageButton")
logoBtn.Name = "ToggleLogo"
logoBtn.Size = UDim2.new(0, 46, 0, 46)
logoBtn.Position = UDim2.new(0, 14, 0, 14)
logoBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
logoBtn.Image = "rbxassetid://122444592900332"
logoBtn.AutoButtonColor = false
logoBtn.Parent = gui

local logoCorner = Instance.new("UICorner", logoBtn)
logoCorner.CornerRadius = UDim.new(1, 0)

local logoStroke = Instance.new("UIStroke", logoBtn)
logoStroke.Color = Color3.fromRGB(80, 170, 255)
logoStroke.Thickness = 2
logoStroke.Transparency = 0.2

task.spawn(function()
    while task.wait(0.03) do
        logoStroke.Transparency = 0.2 + math.abs(math.sin(tick() * 1.5)) * 0.35
    end
end)

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 430, 0, 290)
main.Position = UDim2.new(0.5, -215, 0.5, -145)
main.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
main.BorderSizePixel = 0
main.Visible = true
main.Parent = gui

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 22)

local neon = Instance.new("UIStroke", main)
neon.Color = Color3.fromRGB(80, 170, 255)
neon.Thickness = 2
neon.Transparency = 0.18

task.spawn(function()
    while task.wait(0.03) do
        neon.Transparency = 0.18 + math.abs(math.sin(tick() * 1.4)) * 0.28
    end
end)

-- Background
local bg = Instance.new("ImageLabel")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundTransparency = 1
bg.Image = "rbxassetid://137898463182318"
bg.ImageTransparency = 0.1
bg.ScaleType = Enum.ScaleType.Crop
bg.Parent = main
Instance.new("UICorner", bg).CornerRadius = UDim.new(0,22)

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(30,30,38)
overlay.BackgroundTransparency = 0.65
overlay.Parent = main
Instance.new("UICorner", overlay).CornerRadius = UDim.new(0,22)

-- Avatar
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0,64,0,64)
avatar.Position = UDim2.new(0,18,0,18)
avatar.BackgroundTransparency = 1
avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
avatar.Parent = main
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)

-- Title & Subtitle
local title = Instance.new("TextLabel")
title.Text = "THE_REAL_PANDA HUB"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(120,200,255)
title.Position = UDim2.new(0,98,0,22)
title.Size = UDim2.new(1,-110,0,26)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local sub = Instance.new("TextLabel")
sub.Text = "Kaitun Script"
sub.Font = Enum.Font.GothamBold
sub.TextSize = 14
sub.TextColor3 = Color3.fromRGB(150,215,255)
sub.Position = UDim2.new(0,98,0,50)
sub.Size = UDim2.new(1,-110,0,20)
sub.BackgroundTransparency = 1
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = main

-- Info Labels
local info = Instance.new("Frame")
info.Size = UDim2.new(1,-36,0,180)
info.Position = UDim2.new(0,18,0,92)
info.BackgroundTransparency = 1
info.Parent = main

local function createLabel(y, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,0,0,22)
    l.Position = UDim2.new(0,0,0,y)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.TextSize = 16
    l.TextColor3 = color or Color3.fromRGB(235,248,255)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = info
    Instance.new("UIStroke", l).Color = Color3.fromRGB(80,170,255)
    return l
end

local statusL = createLabel(0, Color3.fromRGB(255,255,255))
local levelL  = createLabel(24, Color3.fromRGB(35,255,226))
local beliL   = createLabel(48, Color3.fromRGB(13,255,0))
local fragL   = createLabel(72, Color3.fromRGB(143,125,255))
local dfL     = createLabel(96, Color3.fromRGB(255,81,247))
local timeL   = createLabel(120, Color3.fromRGB(255,100,100))
local fpsL    = createLabel(144)
local pingL   = createLabel(166)

-- Update UI
local function formatTime(gameTime)
    local h = math.floor(gameTime / 3600) % 24
    local m = math.floor(gameTime / 60) % 60
    local s = gameTime % 60
    return string.format("%02d:%02d:%02d", h, m, s)
end

local frames, lastTick, fps = 0, tick(), 0

RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - lastTick >= 1 then
        fps = frames
        frames = 0
        lastTick = tick()
    end
    fpsL.Text = "FPS: " .. fps
    pingL.Text = "Ping: " .. (pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValueString() end) and Stats.Network.ServerStatsItem["Data Ping"]:GetValueString() or "N/A")
end)

local function updateUI()
    pcall(function()
        statusL.Text = "Status: Nil"
        levelL.Text = "Level: " .. (player.Data.Level.Value or 0)

        local beli = player.Data.Beli.Value
        if beli >= 1e9 then beliL.Text = string.format("Beli: %.2fB", beli/1e9)
        elseif beli >= 1e6 then beliL.Text = string.format("Beli: %.2fM", beli/1e6)
        elseif beli >= 1e3 then beliL.Text = string.format("Beli: %.1fK", beli/1e3)
        else beliL.Text = "Beli: " .. beli end

        fragL.Text = "Fragments: " .. (player.Data.Fragments.Value or 0)
        local df = player.Data.DevilFruit.Value
        dfL.Text = "Devil Fruits: " .. (df == "" and "None" or df)
        timeL.Text = "Time: " .. formatTime(math.floor(workspace.DistributedGameTime + 0.5))
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        updateUI()
    end
end)

-- Ghi đè Status cho Kaitun
L_1_[45]["Status"] = function(newStatus)
    if statusL then
        statusL.Text = "Status: " .. tostring(newStatus)
    end
end

-- Toggle UI
local uiOpen = true
logoBtn.MouseButton1Click:Connect(function()
    uiOpen = not uiOpen
    main.Visible = uiOpen
end)

print("✅  UI đã load!")
