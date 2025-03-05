local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")

local function createGui(config)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ModernGui"
    screenGui.Parent = player.PlayerGui
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 220)
    frame.Position = UDim2.new(0.5, -160, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
    Instance.new("UIGradient", frame).Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
    }).Rotation = 45
    
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)
    Instance.new("UIGradient", titleBar).Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 220, 220))
    }).Rotation = 90
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "The Gru Gru"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 26
    titleLabel.TextColor3 = Color3.fromRGB(200, 255, 255)
    titleLabel.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 36, 0, 36)
    closeButton.Position = UDim2.new(1, -45, 0, 7)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    closeButton.Text = "×"
    closeButton.TextSize = 24
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Parent = titleBar
    Instance.new("UICorner", closeButton).CornerRadius = UDim.new(1, 0)

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 36, 0, 36)
    minimizeButton.Position = UDim2.new(1, -85, 0, 7)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
    minimizeButton.Text = "−"
    minimizeButton.TextSize = 24
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Parent = titleBar
    Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(1, 0)

    -- Thêm nút từ config
    local buttons = {}
    for i, btnConfig in pairs(config.buttons or {}) do
        local btn = Instance.new("TextButton")
        btn.Size = btnConfig.size or UDim2.new(0, 260, 0, 70)
        btn.Position = btnConfig.pos or UDim2.new(0.5, -130, 0.35 + (i-1)*0.35, 0)
        btn.BackgroundColor3 = btnConfig.color or Color3.fromRGB(255, 50, 50)
        btn.Text = btnConfig.text or "Button"
        btn.Font = Enum.Font.SourceSansSemibold
        btn.TextSize = 24
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Parent = frame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
        
        if btnConfig.onClick then
            btn.MouseButton1Click:Connect(btnConfig.onClick)
        end
        buttons[#buttons + 1] = btn
    end

    -- Logic nút đóng
    closeButton.MouseButton1Click:Connect(function()
        tweenService:Create(frame, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        wait(0.5)
        screenGui:Destroy()
    end)

    -- Logic nút thu nhỏ
    local isMinimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        if not isMinimized then
            tweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 320, 0, 50)}):Play()
            for _, btn in pairs(buttons) do btn.Visible = false end
            minimizeButton.Text = "+"
            isMinimized = true
        else
            tweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 320, 0, 220)}):Play()
            for _, btn in pairs(buttons) do btn.Visible = true end
            minimizeButton.Text = "−"
            isMinimized = false
        end
    end)

    -- Hiệu ứng xuất hiện
    frame.Size = UDim2.new(0, 0, 0, 0)
    tweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 320, 0, 220),
        Position = UDim2.new(0.5, -160, 0.5, -110)
    }):Play()
end

local function init(config)
    local character = player.Character or player.CharacterAdded:Wait()
    createGui(config or {})
    player.CharacterAdded:Connect(function() createGui(config or {}) end)
end

return init
