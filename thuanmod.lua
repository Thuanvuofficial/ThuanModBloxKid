-- ============================================================
--              BLOX FRUIT SIMPLE HUB v2.6 (FIX LỖI)
--   Đảm bảo menu hiển thị, toggle hoạt động, có nút TMS
-- ============================================================

print("🚀 Đang khởi tạo Blox Fruit Hub...")

-- Khai báo dịch vụ
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Xóa menu cũ
if CoreGui:FindFirstChild("BloxFruitSimpleHub") then
    CoreGui:FindFirstChild("BloxFruitSimpleHub"):Destroy()
    print("🗑️ Đã xóa menu cũ")
end

-- ============================================================
--                    TẠO GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxFruitSimpleHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui
print("✅ Đã tạo ScreenGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 420)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
print("✅ Đã tạo MainFrame")

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -70, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚔ BLOX FRUIT HUB"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Nút thu nhỏ
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -65, 0.5, -15)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinBtn.Text = "−"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Nút đóng (X) – giờ cũng thu nhỏ, không hủy
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Info Frame
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, -20, 0, 65)
InfoFrame.Position = UDim2.new(0, 10, 0, 55)
InfoFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
InfoFrame.BorderSizePixel = 0
InfoFrame.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 8)
InfoCorner.Parent = InfoFrame

local LevelLabel = Instance.new("TextLabel")
LevelLabel.Size = UDim2.new(0.5, -10, 1, 0)
LevelLabel.Position = UDim2.new(0, 10, 0, 0)
LevelLabel.BackgroundTransparency = 1
LevelLabel.Text = "Level: ?"
LevelLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
LevelLabel.TextSize = 16
LevelLabel.Font = Enum.Font.GothamBold
LevelLabel.TextXAlignment = Enum.TextXAlignment.Left
LevelLabel.Parent = InfoFrame

local ExpLabel = Instance.new("TextLabel")
ExpLabel.Size = UDim2.new(0.5, -10, 1, 0)
ExpLabel.Position = UDim2.new(0.5, 0, 0, 0)
ExpLabel.BackgroundTransparency = 1
ExpLabel.Text = "EXP: ?"
ExpLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
ExpLabel.TextSize = 16
ExpLabel.Font = Enum.Font.GothamBold
ExpLabel.TextXAlignment = Enum.TextXAlignment.Right
ExpLabel.Parent = InfoFrame

-- Container (ScrollingFrame)
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -135)
Container.Position = UDim2.new(0, 10, 0, 130)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 4
Container.CanvasSize = UDim2.new(0, 0, 0, 0)
Container.Parent = MainFrame
print("✅ Đã tạo Container")

local Layout = Instance.new("UIListLayout")
Layout.Parent = Container
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Padding = UDim.new(0, 8)

-- ============================================================
--                    NÚT THU NHỎ (TMS)
-- ============================================================
local ToggleMenuButton = Instance.new("Frame")
ToggleMenuButton.Name = "ToggleMenuButton"
ToggleMenuButton.Size = UDim2.new(0, 55, 0, 55)
ToggleMenuButton.Position = UDim2.new(1, -65, 1, -65)
ToggleMenuButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleMenuButton.BorderSizePixel = 0
ToggleMenuButton.Visible = false
ToggleMenuButton.ZIndex = 999
ToggleMenuButton.Parent = ScreenGui
print("✅ Đã tạo nút TMS")

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleMenuButton

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "TMS"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.TextSize = 18
ToggleLabel.Font = Enum.Font.GothamBold
ToggleLabel.Parent = ToggleMenuButton

-- Kéo thả nút tròn
local dragging = false
local dragStart, startPos
ToggleMenuButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleMenuButton.Position
    end
end)
ToggleMenuButton.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ToggleMenuButton.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
ToggleMenuButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Mở menu khi ấn nút tròn
ToggleMenuButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleMenuButton.Visible = false
    print("🔄 Mở menu từ nút TMS")
end)

-- ============================================================
--                    HÀM THU NHỎ / MỞ MENU
-- ============================================================
local function MinimizeMenu()
    MainFrame.Visible = false
    ToggleMenuButton.Visible = true
    print("📉 Thu nhỏ menu")
end

local function RestoreMenu()
    MainFrame.Visible = true
    ToggleMenuButton.Visible = false
    print("📈 Mở menu")
end

-- ============================================================
--                    TRẠNG THÁI
-- ============================================================
local States = {
    AutoFarm = false,
    AutoQuest = false,
    BringMob = false
}

-- ============================================================
--                    HÀM TẠO TOGGLE
-- ============================================================
local function CreateToggle(text, stateKey, callback)
    local ToggleBg = Instance.new("Frame")
    ToggleBg.Size = UDim2.new(1, 0, 0, 40)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    ToggleBg.BorderSizePixel = 0
    ToggleBg.Parent = Container

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleBg

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 240)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleBg

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 50, 0, 28)
    Button.Position = UDim2.new(1, -58, 0.5, -14)
    Button.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    Button.Text = "TẮT"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.Parent = ToggleBg

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        States[stateKey] = not States[stateKey]
        if States[stateKey] then
            Button.BackgroundColor3 = Color3.fromRGB(60, 200, 80)
            Button.Text = "BẬT"
        else
            Button.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
            Button.Text = "TẮT"
        end
        callback(States[stateKey])
    end)
end

-- ============================================================
--                    HÀM TẠO NÚT
-- ============================================================
local function CreateButton(text, callback)
    local BtnBg = Instance.new("Frame")
    BtnBg.Size = UDim2.new(1, 0, 0, 40)
    BtnBg.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    BtnBg.BorderSizePixel = 0
    BtnBg.Parent = Container

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = BtnBg

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.Parent = BtnBg

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = BtnBg

    Button.MouseButton1Click:Connect(callback)
end

-- ============================================================
--                    CẬP NHẬT THÔNG TIN (nếu có dữ liệu)
-- ============================================================
spawn(function()
    while true do
        task.wait(2)
        pcall(function()
            if LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data:FindFirstChild("Level") then
                local level = LocalPlayer.Data.Level.Value
                local exp = LocalPlayer.Data.Exp.Value
                local maxExp = LocalPlayer.Data.Exp.Max.Value or 100
                local percent = math.floor((exp / maxExp) * 100)
                LevelLabel.Text = "Level: " .. tostring(level)
                ExpLabel.Text = "EXP: " .. tostring(percent) .. "%"
            else
                -- Nếu không có dữ liệu, hiển thị mặc định
                LevelLabel.Text = "Level: ?"
                ExpLabel.Text = "EXP: ?"
            end
        end)
    end
end)

-- ============================================================
--                    DANH SÁCH QUÁI THEO LEVEL
-- ============================================================
local MobLevels = {
    {min = 1, max = 10, name = "Bandit"},
    {min = 11, max = 25, name = "Gorilla"},
    {min = 26, max = 40, name = "Saber Expert"},
    {min = 41, max = 60, name = "Ice Admiral"},
    {min = 61, max = 80, name = "Dragon"},
    {min = 81, max = 100, name = "Darkbeard"},
}

local function GetMobForLevel(level)
    for _, mob in ipairs(MobLevels) do
        if level >= mob.min and level <= mob.max then
            return mob.name
        end
    end
    return "Bandit"
end

-- ============================================================
--                    TÌM QUÁI
-- ============================================================
local function FindNearestMob(mobName)
    local nearest = nil
    local shortest = math.huge
    local root = Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob.Name == mobName and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local dist = (root.Position - mob.HumanoidRootPart.Position).Magnitude
            if dist < shortest then
                shortest = dist
                nearest = mob
            end
        end
    end
    return nearest
end

-- ============================================================
--                    AUTO FARM
-- ============================================================
CreateToggle("⚔ Auto Farm (siêu nhanh)", "AutoFarm", function(enabled)
    if enabled then
        spawn(function()
            while States.AutoFarm do
                task.wait(0.05)
                pcall(function()
                    local level = LocalPlayer.Data.Level.Value
                    local mobName = GetMobForLevel(level)
                    local target = FindNearestMob(mobName)
                    if target and Character and Character:FindFirstChild("HumanoidRootPart") then
                        local root = Character.HumanoidRootPart
                        local targetPos = target.HumanoidRootPart.Position
                        root.CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0), targetPos)
                        root.Velocity = Vector3.new(0, 0, 0)

                        local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool")
                        if tool then
                            Character.Humanoid:EquipTool(tool)
                            tool:Activate()
                        end

                        -- Thử remote (bỏ qua lỗi)
                        pcall(function()
                            local comm = ReplicatedStorage:FindFirstChild("CommF_")
                            if comm and comm:IsA("RemoteFunction") then
                                comm:InvokeServer("Attack")
                            end
                            local remote = ReplicatedStorage:FindFirstChild("Remote")
                            if remote and remote:IsA("RemoteEvent") then
                                remote:FireServer("Attack")
                            end
                        end)
                    end
                end)
            end
        end)
    end
end)

-- ============================================================
--                    AUTO QUEST
-- ============================================================
CreateToggle("📜 Auto Quest", "AutoQuest", function(enabled)
    if enabled then
        spawn(function()
            while States.AutoQuest do
                task.wait(6)
                pcall(function()
                    local level = LocalPlayer.Data.Level.Value
                    local questName = GetMobForLevel(level) .. "Quest"
                    local comm = ReplicatedStorage:FindFirstChild("CommF_")
                    if comm and comm:IsA("RemoteFunction") then
                        comm:InvokeServer("StartQuest", questName, 1)
                    end
                end)
            end
        end)
    end
end)

-- ============================================================
--                    BRING MOBS
-- ============================================================
CreateToggle("🧲 Gom Quái (nâng lên)", "BringMob", function(enabled)
    if enabled then
        spawn(function()
            while States.BringMob do
                task.wait(0.2)
                pcall(function()
                    local firstMob = nil
                    for _, mob in pairs(workspace.Enemies:GetChildren()) do
                        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            firstMob = mob
                            break
                        end
                    end
                    if firstMob then
                        local basePos = firstMob.HumanoidRootPart.Position
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do
                            if mob.Name == firstMob.Name and mob ~= firstMob and mob:FindFirstChild("HumanoidRootPart") then
                                mob.HumanoidRootPart.CFrame = CFrame.new(basePos + Vector3.new(0, 8, 0))
                                mob.HumanoidRootPart.CanCollide = false
                                mob.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ============================================================
--                    TELEPORT
-- ============================================================
CreateButton("🚀 Teleport Đảo Phù Hợp", function()
    pcall(function()
        local level = LocalPlayer.Data.Level.Value
        local islandName = ""
        if level <= 10 then islandName = "Jungle"
        elseif level <= 25 then islandName = "Pirate Village"
        elseif level <= 40 then islandName = "Ice Island"
        elseif level <= 60 then islandName = "Dragon Island"
        else islandName = "Dark Island" end
        local comm = ReplicatedStorage:FindFirstChild("CommF_")
        if comm and comm:IsA("RemoteFunction") then
            comm:InvokeServer("TeleportToIsland", islandName)
        end
    end)
end)

-- ============================================================
--                    NÚT THOÁT (ĐÓNG HẲN GUI)
-- ============================================================
CreateButton("🚪 Thoát (đóng hẳn)", function()
    ScreenGui:Destroy()
    print("👋 Đã đóng GUI")
end)

-- ============================================================
--                    GÁN SỰ KIỆN CHO NÚT THU NHỎ
-- ============================================================
MinBtn.MouseButton1Click:Connect(MinimizeMenu)
CloseBtn.MouseButton1Click:Connect(MinimizeMenu)

-- Hover effect
local function AddHoverEffect(button, color1, color2)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color2}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = color1}):Play()
    end)
end
AddHoverEffect(MinBtn, Color3.fromRGB(60, 60, 80), Color3.fromRGB(80, 80, 100))
AddHoverEffect(CloseBtn, Color3.fromRGB(200, 50, 50), Color3.fromRGB(230, 70, 70))

-- Cập nhật CanvasSize
Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Container.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

print("🎉 Blox Fruit Simple Hub v2.6 đã sẵn sàng!")
print("👉 Nếu menu không hiện, hãy mở console (F9) xem có lỗi gì không.")
