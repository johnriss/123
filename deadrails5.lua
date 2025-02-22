local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local autoCollectBond = false -- Biến kiểm soát trạng thái tự động thu thập
local bondCollectionRange = 1000 -- Phạm vi thu thập Bond
local moveToDistance = 3 -- Khoảng cách dịch chuyển Bond về gần
local camera = workspace.CurrentCamera
while not camera do
    wait()
    camera = workspace.CurrentCamera
end

print("Camera found:", camera)
local userInputService = game:GetService("UserInputService")
local virtualInputManager = game:GetService("VirtualInputManager")

local collectionRange = 500
local moveToDistance = 3
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local starterGui = game:GetService("StarterGui")

local speedBoost = 200
local isSpeedBoosted = false
local isJumping = false
local guiVisible = false
local correctKey = "skibiditoiletyesyes"  -- Key đúng
local guiUnlocked = false  -- Trạng thái GUI bị khóa

-- 🖥️ Tạo GUI Nhập Key (Phiên bản nâng cấp)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame chứa giao diện
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 280, 0, 220)
keyFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
keyFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = screenGui

-- Bo góc cho Frame
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = keyFrame

-- Bóng đổ nhẹ cho Frame
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(80, 80, 80)
uiStroke.Parent = keyFrame

-- Tiêu đề
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "🔑 Type Key"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.Parent = keyFrame

-- Bo góc cho Tiêu đề
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- Ô nhập Key
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 220, 0, 40)
keyBox.Position = UDim2.new(0.5, -110, 0.5, -10)
keyBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderText = "Type Key..."
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 16
keyBox.Parent = keyFrame

-- Bo góc cho Ô nhập
local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBox

-- Nút Xác nhận
local enterButton = Instance.new("TextButton")
enterButton.Size = UDim2.new(0, 220, 0, 45)
enterButton.Position = UDim2.new(0.5, -110, 1, -70) 
enterButton.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
enterButton.Text = "✔ Confirm"
enterButton.Font = Enum.Font.GothamBold
enterButton.TextSize = 18
enterButton.Parent = keyFrame

-- Bo góc cho nút
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = enterButton

-- Hiệu ứng hover (di chuột vào nút)
enterButton.MouseEnter:Connect(function()
    enterButton.BackgroundColor3 = Color3.fromRGB(30, 130, 230)
end)

enterButton.MouseLeave:Connect(function()
    enterButton.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
end)


-- 🔒 Kiểm tra Key
enterButton.MouseButton1Click:Connect(function()
    if keyBox.Text == correctKey then
        guiUnlocked = true
        keyFrame.Visible = false  -- Ẩn màn hình nhập Key
        createMainGUI() -- Mở GUI chính
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "Wrong, Get Key Again..."
    end
end)

-- Nút Discord (Copy Link)
local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(0, 220, 0, 40)
discordButton.Position = UDim2.new(0.5, -110, 0.5, -60) -- Đặt bên dưới ô nhập Key
discordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Màu Discord
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.Text = "📋 GetKey"
discordButton.Font = Enum.Font.GothamBold
discordButton.TextSize = 16
discordButton.Parent = keyFrame

-- Bo góc cho nút Discord
local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 8)
discordCorner.Parent = discordButton

-- Hiệu ứng hover
discordButton.MouseEnter:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(71, 82, 196) -- Màu hover
end)

discordButton.MouseLeave:Connect(function()
    discordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Màu gốc
end)

-- Copy link Discord khi nhấn
local discordLink = "https://discord.gg/Ew7K7HAa" -- Thay bằng link Discord của bạn
discordButton.MouseButton1Click:Connect(function()
    setclipboard(discordLink) -- Copy link vào clipboard
    discordButton.Text = "✅ Copied!"
    wait(1.5)
    discordButton.Text = "📋 GetKey"
end)


-- 🖥️ Tạo GUI chính (Chỉ gọi khi nhập đúng Key)
function createMainGUI()
    if not guiUnlocked then return end
    
    guiVisible = true
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 260)
    frame.Position = UDim2.new(0.5, -130, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    local UICorner = Instance.new("UICorner", frame)
    UICorner.CornerRadius = UDim.new(0, 10)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 35)
    titleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = "DracoHub"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.Parent = frame
    
    local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 75, 0, 25)
toggleButton.Position = UDim2.new(1, -80, 0, 5)
toggleButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "HIDE"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = frame

local UICornerToggle = Instance.new("UICorner", toggleButton)
UICornerToggle.CornerRadius = UDim.new(0, 8)

-- 🎨 Thêm nút mở lại GUI
local openGuiButton = Instance.new("TextButton")
openGuiButton.Size = UDim2.new(0, 100, 0, 30)
openGuiButton.Position = UDim2.new(0, 10, 0, 10)
openGuiButton.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
openGuiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openGuiButton.Text = "OPEN"
openGuiButton.Font = Enum.Font.GothamBold
openGuiButton.Parent = screenGui
openGuiButton.Visible = false

toggleButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    frame.Visible = guiVisible
    openGuiButton.Visible = not guiVisible
end)

openGuiButton.MouseButton1Click:Connect(function()
    guiVisible = true
    frame.Visible = true
    openGuiButton.Visible = false
end)

-- ✨ Tạo hiệu ứng button hover
local function addHoverEffect(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hoverColor
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = normalColor
    end)
end


-- 🛡️ Thêm các nút chức năng
local function createButton(text, position, color, hoverColor)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 230, 0, 40)
    button.Position = position
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Parent = frame

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)

    addHoverEffect(button, color, hoverColor)

    return button
end

local collectButton = createButton("📦 Bring All Item (F)", UDim2.new(0, 15, 0, 50), Color3.fromRGB(100, 200, 100), Color3.fromRGB(80, 180, 80))
collectButton.MouseButton1Click:Connect(function()
    local itemsFolder = game.Workspace:FindFirstChild("RuntimeItems")
    if itemsFolder then
        local collectedItems = 0  -- Biến đếm số lượng item đã thu thập
        for _, item in pairs(itemsFolder:GetChildren()) do
            if collectedItems >= 10 then  -- Nếu đã thu thập đủ 10 item thì dừng lại
                break
            end
            if item:IsA("Model") or item:IsA("Part") then
                local itemPosition = item:GetPivot().Position
                local distance = (humanoidRootPart.Position - itemPosition).Magnitude
                if distance <= collectionRange then
                    local newPosition = humanoidRootPart.Position + Vector3.new(math.random(-moveToDistance, moveToDistance), 0, math.random(-moveToDistance, moveToDistance))
                    item:PivotTo(CFrame.new(newPosition))
                    collectedItems = collectedItems + 1  -- Tăng biến đếm lên 1
                end
            end
        end
    end
end)

local speedButton = createButton("⚡ On/Off Super Speed (Q)", UDim2.new(0, 15, 0, 100), Color3.fromRGB(200, 100, 100), Color3.fromRGB(180, 80, 80))
speedButton.MouseButton1Click:Connect(function()
    if isSpeedBoosted then
        humanoid.WalkSpeed = 16
        isSpeedBoosted = false
    else
        humanoid.WalkSpeed = speedBoost
        isSpeedBoosted = true
    end
end)

-- 💡 Thêm nút Full Light
local fullLightButton = createButton("💡 Full Light",UDim2.new(0, 15, 0, 150),Color3.fromRGB(150, 150, 50),Color3.fromRGB(130, 130, 30))
fullLightButton.MouseButton1Click:Connect(function()
local lighting = game:GetService("Lighting")
    if lighting.Brightness < 2 then
        lighting.Brightness = 20 -- Đặt độ sáng tối đa
        fullLightButton.Text = "💡 Full Light (ON)"
    else
        lighting.Brightness = 1 -- Đặt độ sáng về mặc định
        fullLightButton.Text = "💡 Full Light (OFF)"
    end
end)

-- 🎯 Nút bật/tắt auto thu thập Bond
local autoCollectBondButton = createButton("💰 Auto Collect Bond (OFF)", UDim2.new(0, 15, 0, 200), Color3.fromRGB(150, 100, 200), Color3.fromRGB(130, 80, 180))
autoCollectBondButton.MouseButton1Click:Connect(function()
    autoCollectBond = not autoCollectBond -- Đảo trạng thái bật/tắt
    autoCollectBondButton.Text = autoCollectBond and "💰 Auto Collect Bond (ON)" or "💰 Auto Collect Bond (OFF)"
end)

runService.Heartbeat:Connect(function()
    if autoCollectBond then
        local itemsFolder = game.Workspace:FindFirstChild("RuntimeItems")
        if itemsFolder then
            for _, item in pairs(itemsFolder:GetChildren()) do
                if item.Name == "Bond" then
                    local itemPosition = item:GetPivot().Position
                    local distance = (humanoidRootPart.Position - itemPosition).Magnitude
                    if distance <= bondCollectionRange then
                        -- 📌 Mang Bond đến gần người chơi
                        local newPosition = humanoidRootPart.Position + Vector3.new(math.random(-moveToDistance, moveToDistance), 0, math.random(-moveToDistance, moveToDistance))
                        item:PivotTo(CFrame.new(newPosition))
                        
                        -- 🔍 Kiểm tra xem Bond có ở trong tầm nhìn không
                        local viewportPoint, onScreen = camera:WorldToViewportPoint(itemPosition)
                        if onScreen then
                            -- 📱 Kiểm tra nếu Bond có ProximityPrompt (nút thu thập trên mobile)
                            local prompt = item:FindFirstChildOfClass("ProximityPrompt")
                            if prompt then
                                prompt:InputHoldBegin() -- Bấm nút thu thập
                                task.wait(0.2) -- Chờ một chút
                                prompt:InputHoldEnd() -- Nhả nút ra
                            else
                                -- 🖥 Nếu không có Prompt, giả lập nhấn phím "E" (chỉ cho PC)
                                if not userInputService.TouchEnabled then
                                    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, nil)
                                    task.wait(0.2)
                                    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, nil)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)



-- ⌨️ Xử lý khi nhấn phím
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        local itemsFolder = game.Workspace:FindFirstChild("RuntimeItems")
        if itemsFolder then
            local collectedItems = 0  -- Biến đếm số lượng item đã thu thập
            for _, item in pairs(itemsFolder:GetChildren()) do
                if collectedItems >= 10 then  -- Nếu đã thu thập đủ 10 item thì dừng lại
                    break
                end
                if item:IsA("Model") or item:IsA("Part") then
                    local itemPosition = item:GetPivot().Position
                    local distance = (humanoidRootPart.Position - itemPosition).Magnitude
                    if distance <= collectionRange then
                        local newPosition = humanoidRootPart.Position + Vector3.new(math.random(-moveToDistance, moveToDistance), 0, math.random(-moveToDistance, moveToDistance))
                        item:PivotTo(CFrame.new(newPosition))
                        collectedItems = collectedItems + 1  -- Tăng biến đếm lên 1
                    end
                end
            end
        end
    elseif input.KeyCode == Enum.KeyCode.Q then
        -- Gọi trực tiếp hàm xử lý sự kiện của nút speedButton
        if isSpeedBoosted then
            humanoid.WalkSpeed = 16
            isSpeedBoosted = false
        else
            humanoid.WalkSpeed = speedBoost
            isSpeedBoosted = true
        end
    end
end)

-- 🚀 Infinity Jump
userInputService.JumpRequest:Connect(function()
    if not isJumping then
        isJumping = true
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        isJumping = false
    end
end)

runService.Heartbeat:Connect(function()
    -- Đảm bảo script không bị ngắt
end)

end
