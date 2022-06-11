tickspeed = TimeBetweenTicks
stopafter = Limit

local tycoons = workspace.Tycoons:GetChildren()
local tycoon
local lp = game.Players.LocalPlayer
for i=1, #tycoons do
    if tycoons[i].Owner.Value then
        if tycoons[i].Owner.Value.Name == game.Players.LocalPlayer.Name then
            tycoon = tycoons[i]
            print("owner found")
        end
    end
end

local cur = 0
local CanDoObby = true

local drops = tycoon.Drops:GetChildren()
for l=1, #drops do
    game.ReplicatedStorage.CollectFruit:FireServer(drops[l])
end

tycoon.Drops.ChildAdded:Connect(function(fr)
    if cur < stopafter then
      game.ReplicatedStorage.CollectFruit:FireServer(fr)
     end
end)

function Tick()
     if cur < stopafter then
        local JuiceButton = tycoon.Essentials.JuiceMaker.StartJuiceMakerButton
        local ObbyGate = game.Workspace.ObbyParts["RealObbyStartPart"]
        local ObbyEnd = game.Workspace.ObbyParts["VictoryPart"]
        local ObbyInfoSign = lp.PlayerGui.ObbyInfoBillBoard.TopText.Text
        CanDoObby = ObbyInfoSign == "Start Obby"
        if lp.Character then
            if not CanDoObby then
                local ButtonToBuy
                local cash = lp.leaderstats.Money.Value
                local buttons = tycoon.Buttons:GetChildren()
                for b=1, #buttons do
                    local price = string.gsub(buttons[b].ButtonLabel.CostLabel.Text, ",", "")
                    local buttonprice = tonumber(price)
                    if buttonprice <= cash then
                        ButtonToBuy = buttons[b]
                    end
                end
                print(ButtonToBuy)
                if not ButtonToBuy then
                  lp.Character:SetPrimaryPartCFrame(CFrame.new(JuiceButton.Position))
                  delay(0.2, function()
                      keypress(0x45)
                      wait(0.1)
                      keyrelease(0x45)
                  end)
                else
                    lp.Character:SetPrimaryPartCFrame(CFrame.new(ButtonToBuy.Position) + Vector3.new(0,5,0))
                    ButtonToBuy = nil
                end
            else
                  lp.Character:SetPrimaryPartCFrame(CFrame.new(ObbyGate.Position) - Vector3.new(0,10,0))
                  delay(0.5, function()
                       lp.Character:SetPrimaryPartCFrame(CFrame.new(ObbyEnd.Position) + Vector3.new(0,5,0))
                       wait(0.2)
                       Tick()
                      wait(obbycooldown)
                end)
            end
        end
        cur += 1
    end
end

while wait(tickspeed) do    
   Tick()
end

