-- Configuration
local moveSpeed = 16  -- Speed at which the player moves towards other players

-- Function to handle player movement
local function moveTowardsPlayers()
    local player = game.Players.LocalPlayer
    local character = player.Character

    if not character then
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end
    
    -- Get a list of all other players
    local players = game.Players:GetPlayers()
    
    local closestPlayer = nil
    local closestDistance = math.huge
    
    -- Find the closest player
    for _, otherPlayer in ipairs(players) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter then
                local otherRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
                if otherRootPart then
                    local distance = (otherRootPart.Position - humanoidRootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestPlayer = otherPlayer
                        closestDistance = distance
                    end
                end
            end
        end
    end
    
    -- Move towards the closest player
    if closestPlayer then
        local moveDirection = (closestPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Unit
        humanoidRootPart.Velocity = moveDirection * moveSpeed
    end
end

-- Call the moveTowardsPlayers function repeatedly
game:GetService("RunService").Heartbeat:Connect(moveTowardsPlayers)
