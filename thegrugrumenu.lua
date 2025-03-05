local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")
local youtubeLink = "https://www.youtube.com/@thegrugru"

local function createGui()
    local existingGui = player:WaitForChild("PlayerGui"):FindFirstChild("ModernGui")
    if existingGui then existingGui:Destroy() end

    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ModernGui"
    screenGui.Parent = player.PlayerGui
    screenGui.ResetOnSpawn = false

    -- Frame chính với góc bo
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 220)
    frame.Position = UDim2.new(0.5, -160, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    -- Gradient nền với hiệu ứng mờ
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
    })
    gradient.Rotation = 45
    gradient.Parent = frame

    -- Hiệu ứng glow
    local glow = Instance.new("UIStroke")
    glow.Thickness = 2
    glow.Color = Color3.fromRGB(100, 255, 255)
    glow.Transparency = 0.7
    glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    glow.Parent = frame

    -- Thanh tiêu đề hiện đại
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 220, 220))
    })
    titleGradient.Rotation = 90
    titleGradient.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "The Gru Gru"
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 26
    titleLabel.TextColor3 = Color3.fromRGB(200, 255, 255)
    titleLabel.TextStrokeTransparency = 0.8
    titleLabel.Parent = titleBar

    -- Nút đóng với hiệu ứng
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 36, 0, 36)
    closeButton.Position = UDim2.new(1, -45, 0, 7)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    closeButton.Text = "×"
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.TextSize = 24
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeButton

    -- Nút thu nhỏ
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Size = UDim2.new(0, 36, 0, 36)
    minimizeButton.Position = UDim2.new(1, -85, 0, 7)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
    minimizeButton.Text = "−"
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = 24
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Parent = titleBar
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(1, 0)
    minCorner.Parent = minimizeButton

    -- Nút YouTube với thiết kế đẹp hơn
    local youtubeButton = Instance.new("TextButton")
    youtubeButton.Size = UDim2.new(0, 260, 0, 70)
    youtubeButton.Position = UDim2.new(0.5, -130, 0.5, 10)
    youtubeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    youtubeButton.Text = "Copy YouTube Link"
    youtubeButton.Font = Enum.Font.SourceSansSemibold
    youtubeButton.TextSize = 24
    youtubeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    youtubeButton.Parent = frame
    
    local ytCorner = Instance.new("UICorner")
    ytCorner.CornerRadius = UDim.new(0, 10)
    ytCorner.Parent = youtubeButton

    local ytGradient = Instance.new("UIGradient")
    ytGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
    ytGradient.Rotation = 45
    ytGradient.Parent = youtubeButton

    local ytGlow = Instance.new("UIStroke")
    ytGlow.Thickness = 1.5
    ytGlow.Color = Color3.fromRGB(255, 200, 200)
    ytGlow.Transparency = 0.6
    ytGlow.Parent = youtubeButton

    -- Hiệu ứng hover
    local function createHoverEffect(button, normalSize, hoverSize, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            tweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = hoverSize,
                BackgroundColor3 = hoverColor
            }):Play()
        end)
        button.MouseLeave:Connect(function()
            tweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = normalSize,
                BackgroundColor3 = normalColor
            }):Play()
        end)
    end

    createHoverEffect(youtubeButton, 
        UDim2.new(0, 260, 0, 70), 
        UDim2.new(0, 270, 0, 75), 
        Color3.fromRGB(255, 50, 50), 
        Color3.fromRGB(255, 90, 90)
    )
    
    createHoverEffect(closeButton, 
        UDim2.new(0, 36, 0, 36), 
        UDim2.new(0, 40, 0, 40), 
        Color3.fromRGB(255, 70, 70), 
        Color3.fromRGB(255, 100, 100)
    )
    
    createHoverEffect(minimizeButton, 
        UDim2.new(0, 36, 0, 36), 
        UDim2.new(0, 40, 0, 40), 
        Color3.fromRGB(70, 70, 255), 
        Color3.fromRGB(100, 100, 255)
    )

    -- Logic nút YouTube
    youtubeButton.MouseButton1Click:Connect(function()
        pcall(function()
            setclipboard(youtubeLink)
            youtubeButton.Text = "Link Copied!"
            wait(1.5)
            youtubeButton.Text = "Copy YouTube Link"
        end)
    end)

    -- Logic nút đóng
    closeButton.MouseButton1Click:Connect(function()
        local tween = tweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Transparency = 1
        })
        tween:Play()
        tween.Completed:Connect(function() screenGui:Destroy() end)
    end)

    -- Logic nút thu nhỏ
    local isMinimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        if not isMinimized then
            tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 320, 0, 50)
            }):Play()
            youtubeButton.Visible = false
            minimizeButton.Text = "+"
            isMinimized = true
        else
            tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 320, 0, 220)
            }):Play()
            youtubeButton.Visible = true
            minimizeButton.Text = "−"
            isMinimized = false
        end
    end)

    -- Hiệu ứng xuất hiện
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Transparency = 1
    
    local appearTween = tweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 320, 0, 220),
        Position = UDim2.new(0.5, -160, 0.5, -110),
        Transparency = 0
    })
    appearTween:Play()
end

local character = player.Character or player.CharacterAdded:Wait()
createGui()
player.CharacterAdded:Connect(createGui)
