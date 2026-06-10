-- 🅰️ Hub - Phần 1: Thư viện UI cơ bản
local Library = {}
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AHub_UI"
ScreenGui.Parent = PlayerGui

local LogoButton = Instance.new("TextButton")
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0, 10, 0, 10)
LogoButton.Text = "🅰️"
LogoButton.TextSize = 30
LogoButton.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
LogoButton.TextColor3 = Color3.new(1,1,1)
LogoButton.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 500)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(220, 20, 90)
TitleBar.Text = "🅰️ Hub - Blox Fruit"
TitleBar.TextColor3 = Color3.new(1,1,1)
TitleBar.TextSize = 18
TitleBar.Parent = MainFrame

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 30)
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, 0, 1, -60)
ContentContainer.Position = UDim2.new(0, 0, 0, 60)
ContentContainer.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
ContentContainer.Parent = MainFrame

local Tabs = {}
local CurrentTab = nil

LogoButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local dragging = false
local dragStart
local frameStart
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        frameStart = MainFrame.Position
    end
end)
MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

-- 🅰️ Hub - Phần 2: Methods của Library
function Library:CreateWindow(opts)
    local window = {}
    window.AddTab = function(name)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 100, 1, 0)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = TabContainer
        
        local scroll = Instance.new("ScrollingFrame")
        scroll.Size = UDim2.new(1, 0, 1, 0)
        scroll.BackgroundTransparency = 1
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.ScrollBarThickness = 8
        scroll.Visible = false
        scroll.Parent = ContentContainer
        
        local leftBox = nil
        local rightBox = nil
        
        local function updateCanvas()
            local height = 0
            for _, child in pairs(scroll:GetChildren()) do
                if child:IsA("Frame") then
                    height = height + child.Size.Y.Offset + 10
                end
            end
            scroll.CanvasSize = UDim2.new(0, 0, 0, height + 20)
        end
        
        local tabObj = {}
        tabObj.AddLeftGroupbox = function(title)
            leftBox = Instance.new("Frame")
            leftBox.Size = UDim2.new(0, 280, 0, 0)
            leftBox.Position = UDim2.new(0, 10, 0, 10)
            leftBox.BackgroundColor3 = Color3.fromRGB(255, 145, 175)
            leftBox.BorderSizePixel = 0
            leftBox.Parent = scroll
            local titleLbl = Instance.new("TextLabel")
            titleLbl.Size = UDim2.new(1, 0, 0, 25)
            titleLbl.Text = title
            titleLbl.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
            titleLbl.TextColor3 = Color3.new(1,1,1)
            titleLbl.Parent = leftBox
            leftBox.TitleLabel = titleLbl
            leftBox.CurrentY = 30
            updateCanvas()
            return leftBox
        end
        
        tabObj.AddRightGroupbox = function(title)
            rightBox = Instance.new("Frame")
            rightBox.Size = UDim2.new(0, 280, 0, 0)
            rightBox.Position = UDim2.new(1, -290, 0, 10)
            rightBox.BackgroundColor3 = Color3.fromRGB(255, 145, 175)
            rightBox.BorderSizePixel = 0
            rightBox.Parent = scroll
            local titleLbl = Instance.new("TextLabel")
            titleLbl.Size = UDim2.new(1, 0, 0, 25)
            titleLbl.Text = title
            titleLbl.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
            titleLbl.TextColor3 = Color3.new(1,1,1)
            titleLbl.Parent = rightBox
            rightBox.TitleLabel = titleLbl
            rightBox.CurrentY = 30
            updateCanvas()
            return rightBox
        end
        
        local function addToGroupbox(group, obj)
            obj.Size = UDim2.new(1, -20, 0, 30)
            obj.Position = UDim2.new(0, 10, 0, group.CurrentY)
            obj.Parent = group
            group.CurrentY = group.CurrentY + 35
            group.Size = UDim2.new(0, 280, 0, group.CurrentY + 10)
            updateCanvas()
        end
        
        tabObj.AddToggle = function(id, setting)
            local group = leftBox or rightBox or tabObj:AddLeftGroupbox(" ")
            local frame = Instance.new("Frame")
            frame.BackgroundTransparency = 1
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(0, 40, 0, 20)
            toggle.Position = UDim2.new(1, -50, 0, 5)
            toggle.Text = setting.Default and "ON" or "OFF"
            toggle.BackgroundColor3 = setting.Default and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
            toggle.TextColor3 = Color3.new(1,1,1)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -60, 1, 0)
            label.Text = setting.Title
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.Parent = frame
            toggle.Parent = frame
            addToGroupbox(group, frame)
            local state = setting.Default or false
            local callback = setting.Callback
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = state and "ON" or "OFF"
                toggle.BackgroundColor3 = state and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
                if callback then pcall(callback, state) end
                if frame.ExtraCallback then pcall(frame.ExtraCallback, state) end
            end)
            local proxy = {
                SetStage = function(_, v) state = v; toggle.Text = v and "ON" or "OFF"; toggle.BackgroundColor3 = v and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0); if callback then pcall(callback, v) end end,
                GetValue = function() return state end,
                OnChanged = function(_, fn) frame.ExtraCallback = fn end
            }
            return proxy
        end
        
        tabObj.AddButton = function(setting, cb)
            local group = leftBox or rightBox or tabObj:AddLeftGroupbox(" ")
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -20, 0, 30)
            btn.Text = setting.Title or setting
            btn.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
            btn.TextColor3 = Color3.new(1,1,1)
            addToGroupbox(group, btn)
            btn.MouseButton1Click:Connect(function() if cb then pcall(cb) elseif setting.Callback then pcall(setting.Callback) end end)
            return { SetText = function(_, t) btn.Text = t end }
        end
        
        tabObj.AddDropdown = function(id, setting)
            local group = leftBox or rightBox or tabObj:AddLeftGroupbox(" ")
            local frame = Instance.new("Frame")
            frame.BackgroundTransparency = 1
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -20, 0, 25)
            btn.Text = setting.Values[setting.Default or 1]
            btn.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Position = UDim2.new(0, 0, 0, -20)
            label.Text = setting.Title
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = frame
            btn.Parent = frame
            addToGroupbox(group, frame)
            local selected = setting.Values[setting.Default or 1]
            local callback = setting.Callback
            btn.MouseButton1Click:Connect(function()
                local menu = Instance.new("Frame")
                menu.Size = UDim2.new(0, 150, 0, #setting.Values * 25)
                menu.BackgroundColor3 = Color3.fromRGB(50,50,50)
                menu.Position = UDim2.new(0, btn.AbsolutePosition.X, 0, btn.AbsolutePosition.Y + 25)
                menu.Parent = ScreenGui
                for i, val in ipairs(setting.Values) do
                    local opt = Instance.new("TextButton")
                    opt.Size = UDim2.new(1, 0, 0, 25)
                    opt.Text = val
                    opt.BackgroundColor3 = Color3.fromRGB(80,80,80)
                    opt.TextColor3 = Color3.new(1,1,1)
                    opt.Parent = menu
                    opt.MouseButton1Click:Connect(function()
                        selected = val
                        btn.Text = val
                        if callback then pcall(callback, val) end
                        if frame.ExtraCallback then pcall(frame.ExtraCallback, val) end
                        menu:Destroy()
                    end)
                end
                game:GetService("Debris"):AddItem(menu, 10)
            end)
            local proxy = {
                SetValue = function(_, v) selected = v; btn.Text = v; if callback then pcall(callback, v) end end,
                GetValue = function() return selected end,
                OnChanged = function(_, fn) frame.ExtraCallback = fn end,
            }
            return proxy
        end
        
        tabObj.AddSlider = function(setting)
            local group = leftBox or rightBox or tabObj:AddLeftGroupbox(" ")
            local frame = Instance.new("Frame")
            frame.BackgroundTransparency = 1
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Text = setting.Title .. ": " .. setting.Default
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.Parent = frame
            local slider = Instance.new("Frame")
            slider.Size = UDim2.new(1, -20, 0, 5)
            slider.Position = UDim2.new(0, 10, 0, 20)
            slider.BackgroundColor3 = Color3.fromRGB(100,100,100)
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new((setting.Default - setting.Min) / (setting.Max - setting.Min), 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(255,20,147)
            fill.Parent = slider
            slider.Parent = frame
            addToGroupbox(group, frame)
            local value = setting.Default
            local callback = setting.Callback
            local dragging = false
            local function updateSlider(pos)
                local rel = math.clamp((pos.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                value = setting.Min + rel * (setting.Max - setting.Min)
                if setting.Rounding then value = math.floor(value + 0.5) end
                fill.Size = UDim2.new(rel, 0, 1, 0)
                label.Text = setting.Title .. ": " .. value
                if callback then pcall(callback, value) end
                if frame.ExtraCallback then pcall(frame.ExtraCallback, value) end
            end
            slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateSlider(input.Position)
                end
            end)
            slider.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input.Position)
                end
            end)
            local proxy = {
                SetValue = function(_, v) value = v; local rel = (v - setting.Min)/(setting.Max - setting.Min); fill.Size = UDim2.new(rel,0,1,0); label.Text = setting.Title .. ": " .. v; if callback then pcall(callback, v) end end,
                GetValue = function() return value end,
                OnChanged = function(_, fn) frame.ExtraCallback = fn end
            }
            return proxy
        end
        
        tabObj.AddInput = function(id, setting)
            local group = leftBox or rightBox or tabObj:AddLeftGroupbox(" ")
            local frame = Instance.new("Frame")
            frame.BackgroundTransparency = 1
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.Text = setting.Title
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,1,1)
            label.Parent = frame
            local box = Instance.new("TextBox")
            box.Size = UDim2.new(1, -20, 0, 25)
            box.Position = UDim2.new(0, 10, 0, 20)
            box.PlaceholderText = setting.Placeholder or ""
            box.Text = setting.Default or ""
            box.BackgroundColor3 = Color3.fromRGB(255,255,255)
            box.TextColor3 = Color3.new(0,0,0)
            box.Parent = frame
            addToGroupbox(group, frame)
            local callback = setting.Callback
            box.FocusLost:Connect(function()
                if callback then pcall(callback, box.Text) end
                if frame.ExtraCallback then pcall(frame.ExtraCallback, box.Text) end
            end)
            local proxy = {
                SetValue = function(_, v) box.Text = v; if callback then pcall(callback, v) end end,
                GetValue = function() return box.Text end,
                OnChanged = function(_, fn) frame.ExtraCallback = fn end
            }
            return proxy
        end
        
        tabObj.AddLabel = function(text)
            local group = leftBox or rightBox or tabObj:AddLeftGroupbox(" ")
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -20, 0, 25)
            lbl.Text = text
            lbl.BackgroundTransparency = 1
            lbl.TextColor3 = Color3.new(1,1,1)
            addToGroupbox(group, lbl)
            return { SetText = function(_, t) lbl.Text = t end }
        end
        
        tabObj.AddParagraph = function(setting)
            return tabObj.AddLabel(setting.Title .. "\n" .. (setting.Description or ""))
        end
        
        btn.MouseButton1Click:Connect(function()
            if CurrentTab then CurrentTab.Visible = false end
            scroll.Visible = true
            CurrentTab = scroll
            for _, b in pairs(TabContainer:GetChildren()) do
                if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(255,105,180) end
            end
            btn.BackgroundColor3 = Color3.fromRGB(255,20,147)
        end)
        if not CurrentTab then
            scroll.Visible = true
            CurrentTab = scroll
            btn.BackgroundColor3 = Color3.fromRGB(255,20,147)
        end
        
        Tabs[name] = scroll
        return tabObj
    end
    return window
end

function Library:Notify(opts)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.Position = UDim2.new(1, -310, 0, 10)
    notif.BackgroundColor3 = Color3.fromRGB(50,50,50)
    notif.Parent = ScreenGui
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 20)
    title.Text = opts.Title
    title.BackgroundColor3 = Color3.fromRGB(255,20,147)
    title.TextColor3 = Color3.new(1,1,1)
    title.Parent = notif
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, 0, 1, -20)
    desc.Position = UDim2.new(0, 0, 0, 20)
    desc.Text = opts.Description
    desc.BackgroundTransparency = 1
    desc.TextColor3 = Color3.new(1,1,1)
    desc.TextWrapped = true
    desc.Parent = notif
    game:GetService("Debris"):AddItem(notif, opts.Duration or 3)
    task.spawn(function()
        for i = 1, 20 do
            notif.Position = UDim2.new(1, -310 + i*15, 0, 10)
            task.wait(0.02)
        end
        task.wait(opts.Duration or 3)
        for i = 1, 20 do
            notif.Position = UDim2.new(1, -310 + 300 - i*15, 0, 10)
            task.wait(0.02)
        end
        notif:Destroy()
    end)
end

-- 🅰️ Hub - Phần 3: Hàm hỗ trợ và CheckLevel Sea1
local function AutoHaki()
    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

local STEP_SIZE = 60
local STEP_WAIT = 0.5
local _tweenThread = nil

local function SafeMove(targetCF, checkStop)
    local player = game.Players.LocalPlayer
    if not player.Character then return end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local targetPos = targetCF.Position
    while true do
        if checkStop and checkStop() then break end
        local curPos = hrp.Position
        local remaining = (targetPos - curPos).Magnitude
        if remaining < 8 then break end
        local dir = (targetPos - curPos).Unit
        local stepDist = math.min(remaining, STEP_SIZE)
        local nextPos = curPos + dir * stepDist
        local nextCF = (remaining <= STEP_SIZE) and targetCF or CFrame.new(nextPos)
        pcall(function() hrp.CFrame = nextCF end)
        task.wait(STEP_WAIT)
    end
end

local function Tween(targetCF)
    if not targetCF then return end
    if _tweenThread then pcall(function() task.cancel(_tweenThread) end) end
    _tweenThread = task.spawn(function()
        SafeMove(targetCF, function() return _tweenThread == nil end)
        _tweenThread = nil
    end)
end

local function BKP(cf)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
end

local Pos = CFrame.new(0, 30, 0)

local function AttackNoCoolDown()
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local tool = nil
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Tool") then tool = v; break end
    end
    if not tool then
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v:IsA("Tool") then tool = v; break end
        end
    end
    if not tool then return end
    if tool:FindFirstChild("LeftClickRemote") then
        local enemies = {}
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            local hrp = v:FindFirstChild("HumanoidRootPart")
            local hum = v:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 and (hrp.Position - char.HumanoidRootPart.Position).Magnitude <= 60 then
                table.insert(enemies, v)
            end
        end
        for _, v in pairs(enemies) do
            local dir = (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Unit
            pcall(function() tool.LeftClickRemote:FireServer(dir, 1) end)
        end
    else
        local enemies = {}
        local targetPart = nil
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            local head = v:FindFirstChild("Head")
            local hum = v:FindFirstChild("Humanoid")
            if head and hum and hum.Health > 0 and (head.Position - char.HumanoidRootPart.Position).Magnitude <= 60 then
                table.insert(enemies, {v, head})
                targetPart = head
            end
        end
        if targetPart then
            local regAttack = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
            local regHit = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
            regAttack:FireServer(1e-9)
            regHit:FireServer(targetPart, enemies)
        end
    end
end

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait()
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local Sea1, Sea2, Sea3 = true, true, true
local Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon

local function CheckLevel()
    local lv = game.Players.LocalPlayer.Data.Level.Value
    if Sea1 then
        if lv <= 9 then Ms="Bandit"; NameQuest="BanditQuest1"; QuestLv=1; NameMon="Bandit"; CFrameQ=CFrame.new(1060.938,16.455,1547.784); CFrameMon=CFrame.new(1038.553,41.296,1576.510)
        elseif lv<=14 then Ms="Monkey"; NameQuest="JungleQuest"; QuestLv=1; NameMon="Monkey"; CFrameQ=CFrame.new(-1601.655,36.852,153.388); CFrameMon=CFrame.new(-1448.145,50.852,63.607)
        elseif lv<=29 then Ms="Gorilla"; NameQuest="JungleQuest"; QuestLv=2; NameMon="Gorilla"; CFrameQ=CFrame.new(-1601.655,36.852,153.388); CFrameMon=CFrame.new(-1142.649,40.462,-515.392)
        elseif lv<=39 then Ms="Pirate"; NameQuest="BuggyQuest1"; QuestLv=1; NameMon="Pirate"; CFrameQ=CFrame.new(-1140.176,4.752,3827.406); CFrameMon=CFrame.new(-1201.088,40.629,3857.597)
        elseif lv<=59 then Ms="Brute"; NameQuest="BuggyQuest1"; QuestLv=2; NameMon="Brute"; CFrameQ=CFrame.new(-1140.176,4.752,3827.406); CFrameMon=CFrame.new(-1387.532,24.592,4100.958)
        elseif lv<=74 then Ms="Desert Bandit"; NameQuest="DesertQuest"; QuestLv=1; NameMon="Desert Bandit"; CFrameQ=CFrame.new(896.517,6.438,4390.149); CFrameMon=CFrame.new(984.999,16.110,4417.910)
        elseif lv<=89 then Ms="Desert Officer"; NameQuest="DesertQuest"; QuestLv=2; NameMon="Desert Officer"; CFrameQ=CFrame.new(896.517,6.438,4390.149); CFrameMon=CFrame.new(1547.151,14.452,4381.800)
        elseif lv<=99 then Ms="Snow Bandit"; NameQuest="SnowQuest"; QuestLv=1; NameMon="Snow Bandit"; CFrameQ=CFrame.new(1386.807,87.273,-1298.358); CFrameMon=CFrame.new(1356.302,105.769,-1328.242)
        elseif lv<=119 then Ms="Snowman"; NameQuest="SnowQuest"; QuestLv=2; NameMon="Snowman"; CFrameQ=CFrame.new(1386.807,87.273,-1298.358); CFrameMon=CFrame.new(1218.796,138.012,-1488.026)
        elseif lv<=149 then Ms="Chief Petty Officer"; NameQuest="MarineQuest2"; QuestLv=1; NameMon="Chief Petty Officer"; CFrameQ=CFrame.new(-5035.496,28.678,4324.184); CFrameMon=CFrame.new(-4931.155,65.793,4121.839)
        elseif lv<=174 then Ms="Sky Bandit"; NameQuest="SkyQuest"; QuestLv=1; NameMon="Sky Bandit"; CFrameQ=CFrame.new(-4842.137,717.695,-2623.048); CFrameMon=CFrame.new(-4955.641,365.464,-2908.187)
        elseif lv<=189 then Ms="Dark Master"; NameQuest="SkyQuest"; QuestLv=2; NameMon="Dark Master"; CFrameQ=CFrame.new(-4842.137,717.695,-2623.048); CFrameMon=CFrame.new(-5148.165,439.046,-2332.961)
        elseif lv<=209 then Ms="Prisoner"; NameQuest="PrisonerQuest"; QuestLv=1; NameMon="Prisoner"; CFrameQ=CFrame.new(5310.605,0.350,474.947); CFrameMon=CFrame.new(4937.319,0.332,649.575)
        elseif lv<=249 then Ms="Dangerous Prisoner"; NameQuest="PrisonerQuest"; QuestLv=2; NameMon="Dangerous Prisoner"; CFrameQ=CFrame.new(5310.605,0.350,474.947); CFrameMon=CFrame.new(5099.663,0.352,1055.758)
        elseif lv<=274 then Ms="Toga Warrior"; NameQuest="ColosseumQuest"; QuestLv=1; NameMon="Toga Warrior"; CFrameQ=CFrame.new(-1577.789,7.415,-2984.484); CFrameMon=CFrame.new(-1872.517,49.080,-2913.811)
        elseif lv<=299 then Ms="Gladiator"; NameQuest="ColosseumQuest"; QuestLv=2; NameMon="Gladiator"; CFrameQ=CFrame.new(-1577.789,7.415,-2984.484); CFrameMon=CFrame.new(-1521.374,81.203,-3066.314)
        elseif lv<=324 then Ms="Military Soldier"; NameQuest="MagmaQuest"; QuestLv=1; NameMon="Military Soldier"; CFrameQ=CFrame.new(-5316.116,12.263,8517.004); CFrameMon=CFrame.new(-5369.000,61.244,8556.492)
        elseif lv<=374 then Ms="Military Spy"; NameQuest="MagmaQuest"; QuestLv=2; NameMon="Military Spy"; CFrameQ=CFrame.new(-5316.116,12.263,8517.004); CFrameMon=CFrame.new(-5787.003,75.826,8651.699)
        elseif lv<=399 then Ms="Fishman Warrior"; NameQuest="FishmanQuest"; QuestLv=1; NameMon="Fishman Warrior"; CFrameQ=CFrame.new(61122.652,18.497,1569.400); CFrameMon=CFrame.new(60844.105,98.463,1298.399)
        elseif lv<=449 then Ms="Fishman Commando"; NameQuest="FishmanQuest"; QuestLv=2; NameMon="Fishman Commando"; CFrameQ=CFrame.new(61122.652,18.497,1569.400); CFrameMon=CFrame.new(61738.398,64.207,1433.838)
        elseif lv<=474 then Ms="God's Guard"; NameQuest="SkyExp1Quest"; QuestLv=1; NameMon="God's Guard"; CFrameQ=CFrame.new(-4721.860,845.303,-1953.849); CFrameMon=CFrame.new(-4628.050,866.929,-1931.235)
        elseif lv<=524 then Ms="Shanda"; NameQuest="SkyExp1Quest"; QuestLv=2; NameMon="Shanda"; CFrameQ=CFrame.new(-7863.160,5545.519,-378.423); CFrameMon=CFrame.new(-7685.147,5601.075,-441.389)
        elseif lv<=549 then Ms="Royal Squad"; NameQuest="SkyExp2Quest"; QuestLv=1; NameMon="Royal Squad"; CFrameQ=CFrame.new(-7903.383,5635.990,-1410.924); CFrameMon=CFrame.new(-7654.251,5637.108,-1407.755)
        elseif lv<=624 then Ms="Royal Soldier"; NameQuest="SkyExp2Quest"; QuestLv=2; NameMon="Royal Soldier"; CFrameQ=CFrame.new(-7903.383,5635.990,-1410.924); CFrameMon=CFrame.new(-7760.411,5679.908,-1884.811)
        elseif lv<=649 then Ms="Galley Pirate"; NameQuest="FountainQuest"; QuestLv=1; NameMon="Galley Pirate"; CFrameQ=CFrame.new(5258.279,38.527,4050.045); CFrameMon=CFrame.new(5557.168,152.327,3998.776)
        else Ms="Galley Captain"; NameQuest="FountainQuest"; QuestLv=2; NameMon="Galley Captain"; CFrameQ=CFrame.new(5258.279,38.527,4050.045); CFrameMon=CFrame.new(5677.677,92.786,4966.632)
        end
    end
end
-- 🅰️ Hub - Phần 4: CheckLevel Sea2 và Sea3
    if Sea2 then
        if lv <= 724 then Ms="Raider"; NameQuest="Area1Quest"; QuestLv=1; NameMon="Raider"; CFrameQ=CFrame.new(-427.726,72.996,1835.943); CFrameMon=CFrame.new(68.875,93.636,2429.675)
        elseif lv <= 774 then Ms="Mercenary"; NameQuest="Area1Quest"; QuestLv=2; NameMon="Mercenary"; CFrameQ=CFrame.new(-427.726,72.996,1835.943); CFrameMon=CFrame.new(-864.850,122.471,1453.151)
        elseif lv <= 799 then Ms="Swan Pirate"; NameQuest="Area2Quest"; QuestLv=1; NameMon="Swan Pirate"; CFrameQ=CFrame.new(635.612,73.096,917.813); CFrameMon=CFrame.new(1065.367,137.640,1324.380)
        elseif lv <= 874 then Ms="Factory Staff"; NameQuest="Area2Quest"; QuestLv=2; NameMon="Factory Staff"; CFrameQ=CFrame.new(635.612,73.096,917.813); CFrameMon=CFrame.new(533.220,128.469,355.626)
        elseif lv <= 899 then Ms="Marine Lieutenant"; NameQuest="MarineQuest3"; QuestLv=1; NameMon="Marine Lieutenant"; CFrameQ=CFrame.new(-2440.993,73.042,-3217.708); CFrameMon=CFrame.new(-2489.262,84.614,-3151.883)
        elseif lv <= 949 then Ms="Marine Captain"; NameQuest="MarineQuest3"; QuestLv=2; NameMon="Marine Captain"; CFrameQ=CFrame.new(-2440.993,73.042,-3217.708); CFrameMon=CFrame.new(-2335.203,79.787,-3245.867)
        elseif lv <= 974 then Ms="Zombie"; NameQuest="ZombieQuest"; QuestLv=1; NameMon="Zombie"; CFrameQ=CFrame.new(-5494.341,48.506,-794.591); CFrameMon=CFrame.new(-5536.497,101.086,-835.591)
        elseif lv <= 999 then Ms="Vampire"; NameQuest="ZombieQuest"; QuestLv=2; NameMon="Vampire"; CFrameQ=CFrame.new(-5494.341,48.506,-794.591); CFrameMon=CFrame.new(-5806.110,16.723,-1164.438)
        elseif lv <= 1049 then Ms="Snow Trooper"; NameQuest="SnowMountainQuest"; QuestLv=1; NameMon="Snow Trooper"; CFrameQ=CFrame.new(607.060,401.448,-5370.555); CFrameMon=CFrame.new(535.211,432.742,-5484.917)
        elseif lv <= 1099 then Ms="Winter Warrior"; NameQuest="SnowMountainQuest"; QuestLv=2; NameMon="Winter Warrior"; CFrameQ=CFrame.new(607.060,401.448,-5370.555); CFrameMon=CFrame.new(1234.445,456.954,-5174.131)
        elseif lv <= 1124 then Ms="Lab Subordinate"; NameQuest="IceSideQuest"; QuestLv=1; NameMon="Lab Subordinate"; CFrameQ=CFrame.new(-6061.842,15.927,-4902.039); CFrameMon=CFrame.new(-5720.558,63.309,-4784.610)
        elseif lv <= 1174 then Ms="Horned Warrior"; NameQuest="IceSideQuest"; QuestLv=2; NameMon="Horned Warrior"; CFrameQ=CFrame.new(-6061.842,15.927,-4902.039); CFrameMon=CFrame.new(-6292.752,91.182,-5502.650)
        elseif lv <= 1199 then Ms="Magma Ninja"; NameQuest="FireSideQuest"; QuestLv=1; NameMon="Magma Ninja"; CFrameQ=CFrame.new(-5429.047,15.978,-5297.961); CFrameMon=CFrame.new(-5461.839,130.363,-5836.470)
        elseif lv <= 1249 then Ms="Lava Pirate"; NameQuest="FireSideQuest"; QuestLv=2; NameMon="Lava Pirate"; CFrameQ=CFrame.new(-5429.047,15.978,-5297.961); CFrameMon=CFrame.new(-5251.189,55.165,-4774.410)
        elseif lv <= 1274 then Ms="Ship Deckhand"; NameQuest="ShipQuest1"; QuestLv=1; NameMon="Ship Deckhand"; CFrameQ=CFrame.new(1040.293,125.083,32911.039); CFrameMon=CFrame.new(921.124,125.984,33088.328)
        elseif lv <= 1299 then Ms="Ship Engineer"; NameQuest="ShipQuest1"; QuestLv=2; NameMon="Ship Engineer"; CFrameQ=CFrame.new(1040.293,125.083,32911.039); CFrameMon=CFrame.new(886.282,40.478,32800.832)
        elseif lv <= 1324 then Ms="Ship Steward"; NameQuest="ShipQuest2"; QuestLv=1; NameMon="Ship Steward"; CFrameQ=CFrame.new(971.421,125.083,33245.543); CFrameMon=CFrame.new(943.855,129.582,33444.367)
        elseif lv <= 1349 then Ms="Ship Officer"; NameQuest="ShipQuest2"; QuestLv=2; NameMon="Ship Officer"; CFrameQ=CFrame.new(971.421,125.083,33245.543); CFrameMon=CFrame.new(955.385,181.083,33331.891)
        elseif lv <= 1374 then Ms="Arctic Warrior"; NameQuest="FrostQuest"; QuestLv=1; NameMon="Arctic Warrior"; CFrameQ=CFrame.new(5668.137,28.203,-6484.601); CFrameMon=CFrame.new(5935.454,77.260,-6472.757)
        elseif lv <= 1424 then Ms="Snow Lurker"; NameQuest="FrostQuest"; QuestLv=2; NameMon="Snow Lurker"; CFrameQ=CFrame.new(5668.137,28.203,-6484.601); CFrameMon=CFrame.new(5628.482,57.575,-6618.348)
        elseif lv <= 1449 then Ms="Sea Soldier"; NameQuest="ForgottenQuest"; QuestLv=1; NameMon="Sea Soldier"; CFrameQ=CFrame.new(-3054.583,236.872,-10147.790); CFrameMon=CFrame.new(-3185.015,58.789,-9663.606)
        else Ms="Water Fighter"; NameQuest="ForgottenQuest"; QuestLv=2; NameMon="Water Fighter"; CFrameQ=CFrame.new(-3054.583,236.872,-10147.790); CFrameMon=CFrame.new(-3262.930,298.690,-10552.529)
        end
    end
    if Sea3 then
        if lv <= 1524 then Ms="Pirate Millionaire"; NameQuest="PiratePortQuest"; QuestLv=1; NameMon="Pirate Millionaire"; CFrameQ=CFrame.new(-450.105,107.681,5950.726); CFrameMon=CFrame.new(-193.992,56.125,5755.788)
        elseif lv <= 1574 then Ms="Pistol Billionaire"; NameQuest="PiratePortQuest"; QuestLv=2; NameMon="Pistol Billionaire"; CFrameQ=CFrame.new(-450.105,107.681,5950.726); CFrameMon=CFrame.new(-188.145,84.496,6337.042)
        elseif lv <= 1599 then Ms="Dragon Crew Warrior"; NameQuest="DragonCrewQuest"; QuestLv=1; NameMon="Dragon Crew Warrior"; CFrameQ=CFrame.new(6735.111,126.990,-711.098); CFrameMon=CFrame.new(6615.233,50.848,-978.934)
        elseif lv <= 1624 then Ms="Dragon Crew Archer"; NameQuest="DragonCrewQuest"; QuestLv=2; NameMon="Dragon Crew Archer"; CFrameQ=CFrame.new(6735.111,126.990,-711.098); CFrameMon=CFrame.new(6818.589,483.719,512.727)
        elseif lv <= 1649 then Ms="Hydra Enforcer"; NameQuest="VenomCrewQuest"; QuestLv=1; NameMon="Hydra Enforcer"; CFrameQ=CFrame.new(5446.879,601.629,749.457); CFrameMon=CFrame.new(4547.115,1001.602,334.195)
        elseif lv <= 1699 then Ms="Venomous Assailant"; NameQuest="VenomCrewQuest"; QuestLv=2; NameMon="Venomous Assailant"; CFrameQ=CFrame.new(5446.879,601.629,749.457); CFrameMon=CFrame.new(4637.885,1077.856,882.418)
        elseif lv <= 1724 then Ms="Marine Commodore"; NameQuest="MarineTreeIsland"; QuestLv=1; NameMon="Marine Commodore"; CFrameQ=CFrame.new(2179.988,28.731,-6740.055); CFrameMon=CFrame.new(2198.006,128.711,-7109.504)
        elseif lv <= 1774 then Ms="Marine Rear Admiral"; NameQuest="MarineTreeIsland"; QuestLv=2; NameMon="Marine Rear Admiral"; CFrameQ=CFrame.new(2179.988,28.731,-6740.055); CFrameMon=CFrame.new(3294.314,385.411,-7048.634)
        elseif lv <= 1799 then Ms="Fishman Raider"; NameQuest="DeepForestIsland3"; QuestLv=1; NameMon="Fishman Raider"; CFrameQ=CFrame.new(-10582.760,331.788,-8757.666); CFrameMon=CFrame.new(-10553.269,521.384,-8176.946)
        elseif lv <= 1824 then Ms="Fishman Captain"; NameQuest="DeepForestIsland3"; QuestLv=2; NameMon="Fishman Captain"; CFrameQ=CFrame.new(-10583.100,331.788,-8759.464); CFrameMon=CFrame.new(-10789.401,427.186,-9131.442)
        elseif lv <= 1849 then Ms="Forest Pirate"; NameQuest="DeepForestIsland"; QuestLv=1; NameMon="Forest Pirate"; CFrameQ=CFrame.new(-13232.662,332.404,-7626.482); CFrameMon=CFrame.new(-13489.397,400.303,-7770.252)
        elseif lv <= 1899 then Ms="Mythological Pirate"; NameQuest="DeepForestIsland"; QuestLv=2; NameMon="Mythological Pirate"; CFrameQ=CFrame.new(-13232.662,332.404,-7626.482); CFrameMon=CFrame.new(-13508.616,582.462,-6985.304)
        elseif lv <= 1924 then Ms="Jungle Pirate"; NameQuest="DeepForestIsland2"; QuestLv=1; NameMon="Jungle Pirate"; CFrameQ=CFrame.new(-12682.097,390.887,-9902.124); CFrameMon=CFrame.new(-12267.104,459.753,-10277.200)
        elseif lv <= 1974 then Ms="Musketeer Pirate"; NameQuest="DeepForestIsland2"; QuestLv=2; NameMon="Musketeer Pirate"; CFrameQ=CFrame.new(-12682.097,390.887,-9902.124); CFrameMon=CFrame.new(-13291.508,520.473,-9904.639)
        elseif lv <= 1999 then Ms="Reborn Skeleton"; NameQuest="HauntedQuest1"; QuestLv=1; NameMon="Reborn Skeleton"; CFrameQ=CFrame.new(-9480.808,142.131,5566.373); CFrameMon=CFrame.new(-8761.771,183.432,6168.333)
        elseif lv <= 2024 then Ms="Living Zombie"; NameQuest="HauntedQuest1"; QuestLv=2; NameMon="Living Zombie"; CFrameQ=CFrame.new(-9480.808,142.131,5566.373); CFrameMon=CFrame.new(-10103.753,238.566,6179.760)
        elseif lv <= 2049 then Ms="Demonic Soul"; NameQuest="HauntedQuest2"; QuestLv=1; NameMon="Demonic Soul"; CFrameQ=CFrame.new(-9516.993,178.007,6078.465); CFrameMon=CFrame.new(-9712.031,204.696,6193.322)
        elseif lv <= 2074 then Ms="Posessed Mummy"; NameQuest="HauntedQuest2"; QuestLv=2; NameMon="Posessed Mummy"; CFrameQ=CFrame.new(-9516.993,178.007,6078.465); CFrameMon=CFrame.new(-9545.776,69.620,6339.562)
        elseif lv <= 2099 then Ms="Peanut Scout"; NameQuest="NutsIslandQuest"; QuestLv=1; NameMon="Peanut Scout"; CFrameQ=CFrame.new(-2105.532,37.250,-10195.509); CFrameMon=CFrame.new(-2150.588,122.498,-10358.994)
        elseif lv <= 2124 then Ms="Peanut President"; NameQuest="NutsIslandQuest"; QuestLv=2; NameMon="Peanut President"; CFrameQ=CFrame.new(-2105.532,37.250,-10195.509); CFrameMon=CFrame.new(-2150.588,122.498,-10358.994)
        elseif lv <= 2149 then Ms="Ice Cream Chef"; NameQuest="IceCreamIslandQuest"; QuestLv=1; NameMon="Ice Cream Chef"; CFrameQ=CFrame.new(-819.377,64.926,-10967.283); CFrameMon=CFrame.new(-789.942,209.383,-11009.981)
        elseif lv <= 2199 then Ms="Ice Cream Commander"; NameQuest="IceCreamIslandQuest"; QuestLv=2; NameMon="Ice Cream Commander"; CFrameQ=CFrame.new(-819.377,64.926,-10967.283); CFrameMon=CFrame.new(-789.942,209.383,-11009.981)
        elseif lv <= 2224 then Ms="Cookie Crafter"; NameQuest="CakeQuest1"; QuestLv=1; NameMon="Cookie Crafter"; CFrameQ=CFrame.new(-2022.299,36.928,-12030.977); CFrameMon=CFrame.new(-2321.712,36.699,-12216.787)
        elseif lv <= 2249 then Ms="Cake Guard"; NameQuest="CakeQuest1"; QuestLv=2; NameMon="Cake Guard"; CFrameQ=CFrame.new(-2022.299,36.928,-12030.977); CFrameMon=CFrame.new(-1418.110,36.672,-12255.732)
        elseif lv <= 2274 then Ms="Baking Staff"; NameQuest="CakeQuest2"; QuestLv=1; NameMon="Baking Staff"; CFrameQ=CFrame.new(-1928.318,37.730,-12840.626); CFrameMon=CFrame.new(-1980.438,36.672,-12983.842)
        elseif lv <= 2299 then Ms="Head Baker"; NameQuest="CakeQuest2"; QuestLv=2; NameMon="Head Baker"; CFrameQ=CFrame.new(-1928.318,37.730,-12840.626); CFrameMon=CFrame.new(-2251.579,52.271,-13033.397)
        elseif lv <= 2324 then Ms="Cocoa Warrior"; NameQuest="ChocQuest1"; QuestLv=1; NameMon="Cocoa Warrior"; CFrameQ=CFrame.new(231.750,23.900,-12200.292); CFrameMon=CFrame.new(167.979,26.225,-12238.874)
        elseif lv <= 2349 then Ms="Chocolate Bar Battler"; NameQuest="ChocQuest1"; QuestLv=2; NameMon="Chocolate Bar Battler"; CFrameQ=CFrame.new(231.750,23.900,-12200.292); CFrameMon=CFrame.new(701.312,25.582,-12708.215)
        elseif lv <= 2374 then Ms="Sweet Thief"; NameQuest="ChocQuest2"; QuestLv=1; NameMon="Sweet Thief"; CFrameQ=CFrame.new(151.198,23.891,-12774.617); CFrameMon=CFrame.new(-140.258,25.582,-12652.312)
        elseif lv <= 2400 then Ms="Candy Rebel"; NameQuest="ChocQuest2"; QuestLv=2; NameMon="Candy Rebel"; CFrameQ=CFrame.new(151.198,23.891,-12774.617); CFrameMon=CFrame.new(47.923,25.582,-13029.240)
        elseif lv <= 2424 then Ms="Candy Pirate"; NameQuest="CandyQuest1"; QuestLv=1; NameMon="Candy Pirate"; CFrameQ=CFrame.new(-1149.328,13.576,-14445.614); CFrameMon=CFrame.new(-1437.563,17.148,-14385.693)
        elseif lv <= 2449 then Ms="Snow Demon"; NameQuest="CandyQuest1"; QuestLv=2; NameMon="Snow Demon"; CFrameQ=CFrame.new(-1149.328,13.576,-14445.614); CFrameMon=CFrame.new(-916.223,17.148,-14638.813)
        elseif lv <= 2474 then Ms="Isle Outlaw"; NameQuest="TikiQuest1"; QuestLv=1; NameMon="Isle Outlaw"; CFrameQ=CFrame.new(-16549.891,55.686,-179.914); CFrameMon=CFrame.new(-16162.819,11.686,-96.455)
        elseif lv <= 2499 then Ms="Island Boy"; NameQuest="TikiQuest1"; QuestLv=2; NameMon="Island Boy"; CFrameQ=CFrame.new(-16549.891,55.686,-179.914); CFrameMon=CFrame.new(-16357.313,20.633,1005.649)
        elseif lv <= 2524 then Ms="Sun-kissed Warrior"; NameQuest="TikiQuest2"; QuestLv=1; NameMon="Sun-kissed Warrior"; CFrameQ=CFrame.new(-16541.021,54.771,1051.461); CFrameMon=CFrame.new(-16357.313,20.633,1005.649)
        elseif lv <= 2549 then Ms="Isle Champion"; NameQuest="TikiQuest2"; QuestLv=2; NameMon="Isle Champion"; CFrameQ=CFrame.new(-16541.021,54.771,1051.461); CFrameMon=CFrame.new(-16848.941,21.686,1041.449)
        elseif lv <= 2574 then Ms="Serpent Hunter"; NameQuest="TikiQuest3"; QuestLv=1; NameMon="Serpent Hunter"; CFrameQ=CFrame.new(-16665.191,104.596,1579.694); CFrameMon=CFrame.new(-16621.414,121.406,1290.688)
        else Ms="Skull Slayer"; NameQuest="TikiQuest3"; QuestLv=2; NameMon="Skull Slayer"; CFrameQ=CFrame.new(-16665.191,104.596,1579.694); CFrameMon=CFrame.new(-16811.570,84.625,1542.235)
        end
    end
end

-- 🅰️ Hub - Phần 5: Tạo Window và các Tab
local Window = Library:CreateWindow({Title = "🅰️ Hub", Desc = "Blox Fruit"})

local function makeProxy(obj, callbackHolder)
    local proxy = {}
    setmetatable(proxy, {
        __index = function(_, k)
            if k == "OnChanged" then
                return function(_, fn) callbackHolder.extra = fn; return proxy end
            end
            if k == "SetStage" and obj.SetStage then
                return function(_, v) pcall(obj.SetStage, v) end
            end
            if k == "SetValue" then
                return function(_, v)
                    if obj.SetValue then pcall(obj.SetValue, v)
                    else pcall(function() obj:SetValue(v) end) end
                end
            end
            if k == "GetValue" then
                return function(_)
                    if obj.GetValue then
                        local ok, val = pcall(obj.GetValue)
                        if ok then return val end
                        local ok2, val2 = pcall(function() return obj:GetValue() end)
                        return val2
                    end
                end
            end
            local v = rawget(obj, k) or (type(obj)=="table" and obj[k])
            if type(v)=="function" then
                return function(_, ...) return pcall(v, obj, ...) end
            end
            return v
        end
    })
    return proxy
end

local function wrapTab(rawTab)
    local _currentSection = nil
    local _nextIsRight = false
    local function ensureSection()
        if not _currentSection then
            _currentSection = rawTab:AddLeftGroupbox(" ")
        end
    end
    local wrapped = {}
    function wrapped:AddSection(name)
        if _nextIsRight then
            _currentSection = rawTab:AddRightGroupbox(name or " ")
            _nextIsRight = false
        else
            _currentSection = rawTab:AddLeftGroupbox(name or " ")
            _nextIsRight = true
        end
        return _currentSection
    end
    function wrapped:AddToggle(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting.Description = nil
        local obj = _currentSection:AddToggle(id, setting)
        return makeProxy(obj, holder)
    end
    function wrapped:AddButton(setting, cb)
        ensureSection()
        if type(setting)=="table" then setting.Description = nil end
        local proxy = _currentSection:AddButton(setting, cb)
        if proxy then return makeProxy(proxy, {}) end
    end
    function wrapped:AddDropdown(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting.Description = nil
        local obj = _currentSection:AddDropdown(id, setting)
        return makeProxy(obj, holder)
    end
    function wrapped:AddSlider(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting.Description = nil
        local obj = _currentSection:AddSlider(setting)
        return makeProxy(obj, holder)
    end
    function wrapped:AddInput(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        local obj = _currentSection:AddInput(id, setting)
        return makeProxy(obj, holder)
    end
    function wrapped:AddParagraph(setting)
        ensureSection()
        local title = setting.Title or ""
        local desc = setting.Description or setting.Desc or ""
        local txt = desc~="" and (title.."\n"..desc) or title
        local obj = _currentSection:AddLabel(txt)
        return makeProxy(obj, {})
    end
    function wrapped:AddLabel(text)
        ensureSection()
        local obj = _currentSection:AddLabel(text)
        return makeProxy(obj, {})
    end
    return wrapped
end

local TabsUI = {
    Info = wrapTab(Window:AddTab("Thông Tin")),
    Main = wrapTab(Window:AddTab("Cày Cấp")),
    Sea = wrapTab(Window:AddTab("Sự Kiện")),
    Item = wrapTab(Window:AddTab("Vật Phẩm")),
    Setting = wrapTab(Window:AddTab("Cài Đặt")),
    Status = wrapTab(Window:AddTab("Webhook")),
    Stats = wrapTab(Window:AddTab("Chỉ Số")),
    Player = wrapTab(Window:AddTab("Người Chơi")),
    Teleport = wrapTab(Window:AddTab("Dịch Chuyển")),
    Visual = wrapTab(Window:AddTab("Giả Mạo")),
    Fruit = wrapTab(Window:AddTab("Trái Ác Quỷ")),
    Raid = wrapTab(Window:AddTab("Đột Kích")),
    Race = wrapTab(Window:AddTab("Nâng Cấp Chủng Tộc")),
    Shop = wrapTab(Window:AddTab("Cửa Hàng")),
    Misc = wrapTab(Window:AddTab("Khác")),
}

TabsUI.Info:AddSection("Thông Tin")
TabsUI.Info:AddButton({Title = "Discord", Callback = function() setclipboard("https://discord.gg/example") end})
TabsUI.Info:AddButton({Title = "TikTok", Callback = function() setclipboard("tiktok:@example") end})
TabsUI.Info:AddParagraph({Title = "🅰️ Hub", Description = "Auto Farm | ESP | Teleport | All Features"})

Library:Notify({Title = "🅰️ Hub", Description = "Đã load thành công! Nhấn 🅰️ để mở menu.", Duration = 4})

-- 🅰️ Hub - Phần 6: Tab Main (Cày cấp, vũ khí)
local weaponDropdown = TabsUI.Main:AddDropdown("Weapon", {Title = "Vũ Khí", Values = {"Melee","Sword","Blox Fruit"}, Default = 1})
local ChooseWeapon = "Melee"
weaponDropdown:OnChanged(function(v) ChooseWeapon = v end)

local SelectWeapon = ""
task.spawn(function()
    while task.wait() do
        pcall(function()
            local sources = {game.Players.LocalPlayer.Backpack}
            if game.Players.LocalPlayer.Character then table.insert(sources, game.Players.LocalPlayer.Character) end
            for _, src in pairs(sources) do
                for _, t in pairs(src:GetChildren()) do
                    if t:IsA("Tool") then
                        if ChooseWeapon == "Blox Fruit" and t.ToolTip == "Blox Fruit" then SelectWeapon = t.Name
                        elseif ChooseWeapon == "Sword" and t.ToolTip == "Sword" then SelectWeapon = t.Name
                        elseif ChooseWeapon == "Melee" and t.ToolTip == "Melee" then SelectWeapon = t.Name end
                    end
                end
            end
        end)
    end
end)

TabsUI.Main:AddToggle("AutoLevel", {Title = "Cày Cấp", Default = false}):OnChanged(function(v) _G.AutoLevel = v end)

_G.Fast_Delay = 1e-9
local bringmob = false
local FarmPos, MonFarm

task.spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                CheckLevel()
                if not Ms then return end
                local questVisible = pcall(function() return game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible end) or false
                local QuestTitle = ""
                if questVisible then
                    pcall(function() QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text end)
                end
                if questVisible and QuestTitle ~= "" and not string.find(QuestTitle, NameMon) then
                    bringmob = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    return
                end
                if not questVisible then
                    bringmob = false
                    Tween(CFrameQ)
                    repeat task.wait(0.1) until (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.AutoLevel
                    task.wait(0.2)
                    if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                    return
                end
                if questVisible and string.find(QuestTitle, NameMon) then
                    if game.Workspace.Enemies:FindFirstChild(Ms) then
                        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == Ms then
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    bringmob = true
                                    AutoHaki()
                                    local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(SelectWeapon)
                                    if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                                    local mobCF = v.HumanoidRootPart.CFrame * Pos
                                    if (mobCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(mobCF) end
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0
                                bringmob = false
                            end
                        end
                    else
                        bringmob = false
                        Tween(CFrameMon)
                    end
                end
            end)
        end
    end
end)

TabsUI.Main:AddToggle("OneHitKill", {Title = "Đánh Nhanh", Default = false}):OnChanged(function(v) _G.OneHitKill = v end)
TabsUI.Main:AddToggle("AutoNear", {Title = "Đánh Quái Gần", Default = false}):OnChanged(function(v) _G.AutoNear = v end)

task.spawn(function()
    while task.wait() do
        if _G.AutoNear then
            pcall(function()
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        repeat
                            task.wait(_G.Fast_Delay)
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid.JumpPower = 0
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.CanCollide = false
                            local mobCF = v.HumanoidRootPart.CFrame * Pos
                            if (mobCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(mobCF) end
                            bringmob = true
                            AutoHaki()
                            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(SelectWeapon)
                            if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                            AttackNoCoolDown()
                            FarmPos = v.HumanoidRootPart.CFrame
                            MonFarm = v.Name
                        until not _G.AutoNear or not v.Parent or v.Humanoid.Health <= 0
                        bringmob = false
                    end
                end
            end)
        end
    end
end)

-- 🅰️ Hub - Phần 7: Tab Main (Mastery, Boss, Material)
local masteryType = TabsUI.Main:AddDropdown("MasteryType", {Title = "Chọn Loại Thông Thạo", Values = {"Level","Level No Quest","Near Mob","Bone","Cake","Ecto"}, Default = 1})
masteryType:OnChanged(function(v) TypeMastery = v end)

TabsUI.Main:AddToggle("MasteryFruit", {Title = "Cày Trái", Default = false}):OnChanged(function(v) AutoFarmMasDevilFruit = v end)
TabsUI.Main:AddToggle("MasteryGun", {Title = "Cày Súng", Default = false}):OnChanged(function(v) AutoFarmMasGun = v end)

local killSlider = TabsUI.Main:AddSlider("KillPercent", {Title = "Máu Quái", Default = 20, Min = 0, Max = 100, Rounding = true})
killSlider:OnChanged(function(v) KillPercent = v end)

local bossList = {"The Gorilla King","Bobby","Yeti","Mob Leader","Vice Admiral","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Saber Expert"}
local bossDropdown = TabsUI.Main:AddDropdown("Boss", {Title = "Chọn Trùm", Values = bossList, Default = 1})
bossDropdown:OnChanged(function(v) _G.SelectBoss = v end)
TabsUI.Main:AddToggle("AutoBoss", {Title = "Đánh Trùm", Default = false}):OnChanged(function(v) _G.AutoBoss = v end)

task.spawn(function()
    while task.wait() do
        if _G.AutoBoss then
            pcall(function()
                if game.Workspace.Enemies:FindFirstChild(_G.SelectBoss) then
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == _G.SelectBoss and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat
                                task.wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(SelectWeapon)
                                if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                if (v.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(v.HumanoidRootPart.CFrame * Pos) end
                            until not _G.AutoBoss or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                elseif game.ReplicatedStorage:FindFirstChild(_G.SelectBoss) then
                    local boss = game.ReplicatedStorage:FindFirstChild(_G.SelectBoss)
                    if boss and boss:FindFirstChild("HumanoidRootPart") then
                        BKP(boss.HumanoidRootPart.CFrame * Pos)
                    end
                end
            end)
        end
    end
end)

local matList = {"Scrap Metal","Leather","Angel Wings","Magma Ore","Fish Tail"}
local matDropdown = TabsUI.Main:AddDropdown("Material", {Title = "Chọn Nguyên Liệu", Values = matList, Default = 1})
matDropdown:OnChanged(function(v) SelectMaterial = v end)
TabsUI.Main:AddToggle("AutoMaterial", {Title = "Cày Nguyên Liệu", Default = false}):OnChanged(function(v) _G.AutoMaterial = v end)

print("✅ Phần 7 đã sẵn sàng - Mastery, Boss, Material")

-- 🅰️ Hub - Phần 8: Tab Sự Kiện (Sea Events)
TabsUI.Sea:AddSection("Biển 3 - Sự Kiện")

local kitsuneStatus = TabsUI.Sea:AddParagraph({Title = "Trạng Thái Đảo Cáo"})
task.spawn(function()
    while task.wait() do
        pcall(function()
            if game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
                kitsuneStatus:SetDesc("Đảo Cáo: ✅ Có")
            else
                kitsuneStatus:SetDesc("Đảo Cáo: ❌ Không")
            end
        end)
    end
end)

TabsUI.Sea:AddToggle("TPKitsune", {Title = "Bay Đến Đảo Cáo", Default = false}):OnChanged(function(v) _G.TweenToKitsune = v end)

TabsUI.Sea:AddToggle("Terrorshark", {Title = "Đánh Cá Mập", Default = false}):OnChanged(function(v) _G.AutoTerrorshark = v end)

_G.IsFlying = false
task.spawn(function()
    while task.wait() do
        if _G.AutoTerrorshark then
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    if char.Humanoid.Health < 6000 and not _G.IsFlying then
                        _G.IsFlying = true
                        Tween(CFrame.new(char.HumanoidRootPart.Position.X, 360, char.HumanoidRootPart.Position.Z))
                    end
                    if _G.IsFlying and char.Humanoid.Health >= 8000 then _G.IsFlying = false end
                    if not _G.IsFlying and char.Humanoid.Health >= 8000 then
                        if game.Workspace.Enemies:FindFirstChild("Terrorshark") then
                            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v.Name == "Terrorshark" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        if char.Humanoid.Health < 6000 then
                                            _G.IsFlying = true
                                            Tween(CFrame.new(char.HumanoidRootPart.Position.X, 360, char.HumanoidRootPart.Position.Z))
                                            break
                                        end
                                        AttackNoCoolDown()
                                        AutoHaki()
                                        local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(SelectWeapon)
                                        if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        if (v.HumanoidRootPart.CFrame.Position - char.HumanoidRootPart.Position).Magnitude > 5 then BKP(v.HumanoidRootPart.CFrame * Pos) end
                                    until not _G.AutoTerrorshark or not v.Parent or v.Humanoid.Health <= 0 or _G.IsFlying
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

TabsUI.Sea:AddToggle("Piranha", {Title = "Đánh Piranha", Default = false}):OnChanged(function(v) _G.farmpiranya = v end)
TabsUI.Sea:AddToggle("Shark", {Title = "Đánh Cá Con", Default = false}):OnChanged(function(v) _G.AutoShark = v end)
TabsUI.Sea:AddToggle("Ship", {Title = "Đánh Tàu", Default = false}):OnChanged(function(v) _G.Ship = v end)
TabsUI.Sea:AddToggle("GhostShip", {Title = "Đánh Tàu Ma", Default = false}):OnChanged(function(v) _G.GhostShip = v end)
TabsUI.Sea:AddToggle("CastleRaid", {Title = "Đánh Hải Tặc Pháo Đài", Default = false}):OnChanged(function(v) _G.CastleRaid = v end)

task.spawn(function()
    while task.wait() do
        if _G.CastleRaid then
            pcall(function()
                local raidPos = CFrame.new(-5496.174,313.769,-2841.530)
                local center = Vector3.new(-5539.311,313.801,-2972.372)
                if (center - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat
                                task.wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(SelectWeapon)
                                if tool then game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool) end
                                v.HumanoidRootPart.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                if (v.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(v.HumanoidRootPart.CFrame * Pos) end
                            until not _G.CastleRaid or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                else
                    Tween(raidPos)
                end
            end)
        end
    end
end)

print("✅ Phần 8 đã sẵn sàng - Tab Sự Kiện")

-- 🅰️ Hub - Phần 9: ESP (Player, Fruit, Chest, Island)
local Number = math.random(1, 1000000)

local function round(n) return math.floor(n + 0.5) end

TabsUI.Fruit:AddSection("Định Vị ESP")
TabsUI.Fruit:AddToggle("EspPlayer", {Title = "ESP Người Chơi", Default = false}):OnChanged(function(v) ESPPlayer = v end)
TabsUI.Fruit:AddToggle("EspFruit", {Title = "ESP Trái Ác Quỷ", Default = false}):OnChanged(function(v) DevilFruitESP = v end)
TabsUI.Fruit:AddToggle("EspChest", {Title = "ESP Rương", Default = false}):OnChanged(function(v) ChestESP = v end)
TabsUI.Fruit:AddToggle("EspIsland", {Title = "ESP Đảo", Default = false}):OnChanged(function(v) IslandESP = v end)

local function UpdatePlayerChams()
    for _, plr in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local head = plr.Character.Head
                if ESPPlayer then
                    if not head:FindFirstChild("NameEsp"..Number) then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = "NameEsp"..Number
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.AlwaysOnTop = true
                        bill.Adornee = head
                        bill.Parent = head
                        local label = Instance.new("TextLabel", bill)
                        label.Size = UDim2.new(1,0,1,0)
                        label.BackgroundTransparency = 1
                        label.TextColor3 = plr.Team == game.Players.LocalPlayer.Team and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
                        label.Text = plr.Name
                    end
                    local dist = round((game.Players.LocalPlayer.Character.Head.Position - head.Position).Magnitude / 3)
                    head["NameEsp"..Number].TextLabel.Text = plr.Name.." | "..dist.."m\nHP: "..round(plr.Character.Humanoid.Health*100/plr.Character.Humanoid.MaxHealth).."%"
                elseif head:FindFirstChild("NameEsp"..Number) then
                    head:FindFirstChild("NameEsp"..Number):Destroy()
                end
            end
        end)
    end
end

local function UpdateFruitChams()
    for _, v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                local handle = v.Handle
                if DevilFruitESP then
                    if not handle:FindFirstChild("NameEsp"..Number) then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = "NameEsp"..Number
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.AlwaysOnTop = true
                        bill.Adornee = handle
                        bill.Parent = handle
                        local label = Instance.new("TextLabel", bill)
                        label.Size = UDim2.new(1,0,1,0)
                        label.BackgroundTransparency = 1
                        label.TextColor3 = Color3.fromRGB(255,255,255)
                        label.Text = v.Name
                    end
                    local dist = round((game.Players.LocalPlayer.Character.Head.Position - handle.Position).Magnitude / 3)
                    handle["NameEsp"..Number].TextLabel.Text = v.Name.." | "..dist.."m"
                elseif handle:FindFirstChild("NameEsp"..Number) then
                    handle:FindFirstChild("NameEsp"..Number):Destroy()
                end
            end
        end)
    end
end

local function UpdateChestChams()
    for _, v in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if string.find(v.Name, "Chest") then
                if ChestESP then
                    if not v:FindFirstChild("NameEsp"..Number) then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = "NameEsp"..Number
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.AlwaysOnTop = true
                        bill.Adornee = v
                        bill.Parent = v
                        local label = Instance.new("TextLabel", bill)
                        label.Size = UDim2.new(1,0,1,0)
                        label.BackgroundTransparency = 1
                        label.TextColor3 = Color3.fromRGB(255,215,0)
                        label.Text = v.Name
                    end
                    local dist = round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3)
                    v["NameEsp"..Number].TextLabel.Text = v.Name.." | "..dist.."m"
                elseif v:FindFirstChild("NameEsp"..Number) then
                    v:FindFirstChild("NameEsp"..Number):Destroy()
                end
            end
        end)
    end
end

local function UpdateIslandChams()
    for _, v in pairs(game.Workspace._WorldOrigin.Locations:GetChildren()) do
        pcall(function()
            if v.Name ~= "Sea" then
                if IslandESP then
                    if not v:FindFirstChild("NameEsp") then
                        local bill = Instance.new("BillboardGui")
                        bill.Name = "NameEsp"
                        bill.Size = UDim2.new(1,200,1,30)
                        bill.AlwaysOnTop = true
                        bill.Adornee = v
                        bill.Parent = v
                        local label = Instance.new("TextLabel", bill)
                        label.Size = UDim2.new(1,0,1,0)
                        label.BackgroundTransparency = 1
                        label.TextColor3 = Color3.fromRGB(0,255,255)
                        label.Text = v.Name
                    end
                    local dist = round((game.Players.LocalPlayer.Character.Head.Position - v.Position).Magnitude / 3)
                    v.NameEsp.TextLabel.Text = v.Name.." | "..dist.."m"
                elseif v:FindFirstChild("NameEsp") then
                    v.NameEsp:Destroy()
                end
            end
        end)
    end
end

task.spawn(function()
    while task.wait(0.5) do
        if ESPPlayer then UpdatePlayerChams() end
        if DevilFruitESP then UpdateFruitChams() end
        if ChestESP then UpdateChestChams() end
        if IslandESP then UpdateIslandChams() end
    end
end)

print("✅ Phần 9 đã sẵn sàng - ESP")

-- 🅰️ Hub - Phần 10: Teleport, Stats, Shop, Misc
TabsUI.Teleport:AddSection("Dịch Chuyển")
TabsUI.Teleport:AddButton({Title = "Biển 1", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end})
TabsUI.Teleport:AddButton({Title = "Biển 2", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end})
TabsUI.Teleport:AddButton({Title = "Biển 3", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end})

local islandList = {"WindMill","Marine","Jungle","Desert","Snow Island","Sky Island","Prison","Magma Village","Fountain City"}
local islandDropdown = TabsUI.Teleport:AddDropdown("Island", {Title = "Chọn Đảo", Values = islandList, Default = 1})
islandDropdown:OnChanged(function(v) _G.SelectIsland = v end)
TabsUI.Teleport:AddButton({Title = "Bay Đến Đảo", Callback = function()
    local islands = {
        WindMill = CFrame.new(979.799,16.517,1429.047),
        Marine = CFrame.new(-2566.430,6.856,2045.256),
        Jungle = CFrame.new(-1612.796,36.852,149.128),
        Desert = CFrame.new(944.158,20.920,4373.300),
        ["Snow Island"] = CFrame.new(1347.807,104.668,-1319.737),
        ["Sky Island"] = CFrame.new(-4869.103,733.461,-2667.018),
        Prison = CFrame.new(4875.330,5.652,734.850),
        ["Magma Village"] = CFrame.new(-5247.716,12.884,8504.969),
        ["Fountain City"] = CFrame.new(5127.128,59.501,4105.446),
    }
    if islands[_G.SelectIsland] then Tween(islands[_G.SelectIsland]) end
end})

TabsUI.Stats:AddSection("Nâng Chỉ Số")
TabsUI.Stats:AddToggle("StatMelee", {Title = "Nâng Đấm", Default = false}):OnChanged(function(v) _G.Auto_Stats_Melee = v end)
TabsUI.Stats:AddToggle("StatDefense", {Title = "Nâng Máu", Default = false}):OnChanged(function(v) _G.Auto_Stats_Defense = v end)
TabsUI.Stats:AddToggle("StatSword", {Title = "Nâng Kiếm", Default = false}):OnChanged(function(v) _G.Auto_Stats_Sword = v end)
TabsUI.Stats:AddToggle("StatGun", {Title = "Nâng Súng", Default = false}):OnChanged(function(v) _G.Auto_Stats_Gun = v end)
TabsUI.Stats:AddToggle("StatFruit", {Title = "Nâng Trái", Default = false}):OnChanged(function(v) _G.Auto_Stats_Devil_Fruit = v end)

task.spawn(function()
    while task.wait() do
        if game.Players.LocalPlayer.Data.Points.Value >= 1 then
            if _G.Auto_Stats_Melee then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Melee",1) end
            if _G.Auto_Stats_Defense then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Defense",1) end
            if _G.Auto_Stats_Sword then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Sword",1) end
            if _G.Auto_Stats_Gun then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Gun",1) end
            if _G.Auto_Stats_Devil_Fruit then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint","Demon Fruit",1) end
        end
    end
end)

TabsUI.Shop:AddSection("Mua Kỹ Năng")
TabsUI.Shop:AddButton({Title = "Geppo", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo") end})
TabsUI.Shop:AddButton({Title = "Buso", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso") end})
TabsUI.Shop:AddButton({Title = "Soru", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru") end})
TabsUI.Shop:AddButton({Title = "Ken", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy") end})

TabsUI.Misc:AddSection("Tiện Ích")
TabsUI.Misc:AddButton({Title = "Rejoin", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer) end})
TabsUI.Misc:AddButton({Title = "Hop Server", Callback = function()
    local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, v in pairs(servers.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id, game.Players.LocalPlayer)
            break
        end
    end
end})

TabsUI.Misc:AddToggle("AutoRejoin", {Title = "Auto Rejoin Khi Disconnect", Default = true}):OnChanged(function(v) _G.AutoRejoin = v end)
if _G.AutoRejoin then
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(p)
        if p.Name == "ErrorPrompt" then game:GetService("TeleportService"):Teleport(game.PlaceId) end
    end)
end

print("✅ Phần 10 đã sẵn sàng - Teleport, Stats, Shop, Misc")

-- 🅰️ Hub - Phần 11: Gom quái và kết thúc
TabsUI.Setting:AddSection("Cài Đặt Khác")
TabsUI.Setting:AddToggle("BringMob", {Title = "Gom Quái", Default = true}):OnChanged(function(v) _G.BringMob = v end)
_G.BringMob = true

task.spawn(function()
    while task.wait() do
        if _G.BringMob and bringmob and MonFarm then
            pcall(function()
                for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                        if (v.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000 then
                            v.HumanoidRootPart.CFrame = FarmPos
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.Transparency = 1
                            v.Humanoid.JumpPower = 0
                            v.Humanoid.WalkSpeed = 0
                            v.HumanoidRootPart.CanCollide = false
                            if v.Humanoid:FindFirstChild("Animator") then v.Humanoid.Animator:Destroy() end
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    end
                end
            end)
        end
    end
end)

TabsUI.Setting:AddToggle("WhiteScreen", {Title = "Màn Hình Trắng", Default = false}):OnChanged(function(v)
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
end)

TabsUI.Setting:AddToggle("NoClip", {Title = "Đi Xuyên Tường", Default = false}):OnChanged(function(v) _G.NoClip = v end)
task.spawn(function()
    while task.wait() do
        if _G.NoClip and game.Players.LocalPlayer.Character then
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

TabsUI.Player:AddSection("Người Chơi")
local playerList = {}
for _, plr in pairs(game:GetService("Players"):GetChildren()) do table.insert(playerList, plr.Name) end
local playerDropdown = TabsUI.Player:AddDropdown("Player", {Title = "Chọn Người Chơi", Values = playerList, Default = 1})
playerDropdown:OnChanged(function(v) _G.SelectPly = v end)
TabsUI.Player:AddToggle("TeleportToPlayer", {Title = "Bay Đến Người Chơi", Default = false}):OnChanged(function(v) _G.TeleportPly = v end)

task.spawn(function()
    while task.wait() do
        if _G.TeleportPly and game.Players:FindFirstChild(_G.SelectPly) then
            local target = game.Players[_G.SelectPly].Character
            if target and target:FindFirstChild("HumanoidRootPart") then
                Tween(target.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
            end
        end
    end
end)

print("✅ 🅰️ Hub - Toàn bộ 11 phần đã load thành công!")