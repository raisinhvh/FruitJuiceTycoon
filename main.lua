print("Loaded raisin's juice hacks successfully. This is version 1.1.2"

repeat wait() until game:IsLoaded()

for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
    v:Disable()
end

local tickspeed = 0.33
local ison = false
local tycoons = workspace.Tycoons:GetChildren()
local tycoon
local lp = game.Players.LocalPlayer

local LastObby = 0

local maingui = Instance.new("ScreenGui", lp.PlayerGui)
local frame = Instance.new("Frame", maingui)
local textlabel = Instance.new("TextLabel", frame)
local corners = Instance.new("UICorner", frame)
local button = Instance.new("TextButton", frame)
local corner2 = Instance.new("UICorner", button)
corners.CornerRadius = UDim.new(0.1, 0)
corner2.CornerRadius = UDim.new(0.6, 0)
maingui.ResetOnSpawn = false
maingui.Name = "l0l ez cheated game lmao fix ur shit"
frame.Size = UDim2.new(0.15, 0, 0.15, 0)
frame.BackgroundColor3 = Color3.fromRGB(0,206,209)
frame.Position = UDim2.new(0.01,0,0.84,0)
textlabel.Size = UDim2.new(1, 0, 0.5, 0)
button.TextScaled = true
button.Size = UDim2.new(1,0,0.5,0)
button.Position = UDim2.new(0,0,0.5,0)
textlabel.Text = "~~ Raisin's Epik Juice Hax ~~"
textlabel.TextScaled = true
textlabel.BackgroundTransparency = 1
button.BackgroundTransparency = 0.7
button.BackgroundColor3 = Color3.fromRGB(255,255,255)

local btexts = {
    [true] = "Turn Off",
    [false] = "Turn On"
}

local function fireproximityprompt(Obj, Amount, Skip)
    if Obj.ClassName == "ProximityPrompt" then 
        Amount = Amount or 1
        local PromptTime = Obj.HoldDuration
        if Skip then 
            Obj.HoldDuration = 0
        end
        for i = 1, Amount do 
            Obj:InputHoldBegin()
            if not Skip then 
                wait(Obj.HoldDuration)
            end
            Obj:InputHoldEnd()
        end
        Obj.HoldDuration = PromptTime
    else 
        error("userdata<ProximityPrompt> expected")
    end
end

button.Text = btexts[false]

button.MouseButton1Up:Connect(function()
    ison = not ison
    button.Text = btexts[ison]
    if tycoon:FindFirstChild("Drops") then
        local drops = tycoon:FindFirstChild("Drops"):GetChildren()
        if drops then
            for l=1, #drops do
             game.ReplicatedStorage.CollectFruit:FireServer(drops[l])
            end
        end
    end
end)

function FindTycoon()
    tycoons = workspace.Tycoons:GetChildren()
    for i=1, #tycoons do
        if tycoons[i]:FindFirstChild("Owner") then
            if tycoons[i].Owner.Value then
                if tycoons[i].Owner.Value.Name == game.Players.LocalPlayer.Name then
                    return tycoons[i]
                end
            end
        end
    end
end

for i=1, #tycoons do
    tycoon = FindTycoon()
end

local pause = false

if not tycoon then
   for x=1, #tycoons do
       if tycoons[x].Owner.Value == nil then
            local gate = tycoons[x].Essentials:FindFirstChild("Entrance")
            if gate then
              lp.Character:SetPrimaryPartCFrame(CFrame.new(gate.Position))
              tycoon = tycoons[x]
            end
        end
    end
end

local CanDoObby = true
local curpickupconnection

tycoon.Drops.ChildAdded:Connect(function(fr)
    if ison then
      game.ReplicatedStorage.CollectFruit:FireServer(fr)
     end
end)

function CalledOnStartAndRebirth()
    if curpickupconnection then
        curpickupconnection:Disconnect()
    end
    if tycoon:FindFirstChild("Drops") then
        curpickupconnection = tycoon.Drops.ChildAdded:Connect(function(fr)
            if ison then
               game.ReplicatedStorage.CollectFruit:FireServer(fr)
            end
        end)
    end
end

CalledOnStartAndRebirth()
pause = false

function Tick()
     if ison and pause == false then
         if tycoon:FindFirstChild("Essentials") and tycoon:FindFirstChild("Purchased") and tycoon:FindFirstChild("Buttons") then 
            local JuiceButton = tycoon.Essentials.JuiceMaker.StartJuiceMakerButton
            local ObbyGate = game.Workspace.ObbyParts["RealObbyStartPart"]
            local ObbyEnd = game.Workspace.ObbyParts["VictoryPart"]
            if lp.PlayerGui:FindFirstChild("ObbyInfoBillBoard") then
                local ObbyInfoSign = lp.PlayerGui.ObbyInfoBillBoard.TopText.Text
                CanDoObby = (ObbyInfoSign == "Start Obby") and (os.time() > LastObby + 3)
                if lp.Character then
                    if not CanDoObby then
                        local ButtonToBuy
                        local cash = lp.leaderstats.Money.Value
                        local buttonsinstance = tycoon.Buttons
                        local buttons = buttonsinstance:GetChildren()
                        for b=1, #buttons do
                            if buttons[b].ButtonLabel.CostLabel.Text ~= "FREE!" then
                                local price = string.gsub(buttons[b].ButtonLabel.CostLabel.Text, ",", "")
                                local buttonprice = tonumber(price)
                                if buttonprice <= cash then
                                    if not (#buttons > 2 and buttons[b].Name == "AutoCollect") then
                                      ButtonToBuy = buttons[b]
                                    end
                                end
                            else
                                ButtonToBuy = buttons[b]
                            end
                        end
                        if not ButtonToBuy then
                            local statue = tycoon.Purchased:FindFirstChild("Golden Tree Statue")
                            if not statue then
                                if lp.Character:FindFirstChild("Humanoid") then
                                    lp.Character:SetPrimaryPartCFrame(CFrame.new(JuiceButton.Position) + Vector3.new(0, lp.Character.Humanoid.HipHeight + JuiceButton.Size.Y, 0))
                                    local prompt = tycoon.Essentials.JuiceMaker.StartJuiceMakerButton.PromptAttachment.StartPrompt
                                    delay(0.1, function()
                                        if tycoon:FindFirstChild("Essentials") and tycoon:FindFirstChild("Purchased") and tycoon:FindFirstChild("Buttons") then
                                            if prompt then
                                                fireproximityprompt(prompt, 1, true)
                                            end
                                        end
                                    end)
                                end
                            else
                             if lp.Character:FindFirstChild("HumanoidRootPart") then
                                    local prompt = tycoon.Purchased["Golden Tree Statue"].StatueBottom.PrestigePrompt
                                    lp.Character:SetPrimaryPartCFrame(CFrame.new(statue.StatueBottom.Position))
                                    lp.Character.HumanoidRootPart.Anchored = true
                                    pause = true
                                    delay(1, function()
                                       if tycoon:FindFirstChild("Essentials") and tycoon:FindFirstChild("Purchased") and tycoon:FindFirstChild("Buttons") then
                                          fireproximityprompt(prompt, 1, true)
                                          wait(1)
                                                
                                          local function PissOnAnElephantsClitoris()
                                             local ft = FindTycoon()
                                             if ft then
                                                if ft:FindFirstChild("Essentials") then
                                                   return true
                                                end
                                             end
                                             return false
                                          end
                                                
                                          repeat wait() until PissOnAnElephantsClitoris()
                                          if lp.Character then
                                              if lp.Character.HumanoidRootPart then
                                                  lp.Character.HumanoidRootPart.Anchored = false
                                                  tycoon = FindTycoon()
                                                  pause = false
                                                  CalledOnStartAndRebirth()
                                               end
                                            end
                                        end
                                    end)
                                end
                            end
                        else
                            lp.Character:SetPrimaryPartCFrame(CFrame.new(ButtonToBuy.Position) + Vector3.new(0,5,0))
                            ButtonToBuy = nil
                        end
                    else  
                          lp.Character:SetPrimaryPartCFrame(CFrame.new(ObbyGate.Position) - Vector3.new(0,10,0))
                          pause = true
                          delay(0.25, function()
                              if lp.Character then
                                  if lp.Character:FindFirstChild("HumanoidRootPart") then
                                      lp.Character:SetPrimaryPartCFrame(CFrame.new(ObbyEnd.Position) + Vector3.new(0,5,0))
                                      wait(0.1)
                                      LastObby = os.time()
                                      pause = false
                                  end
                             end
                        end)
                    end
                end
            end
        end
    end
end

while wait(tickspeed) do    
   Tick()
end
