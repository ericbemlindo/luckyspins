local ReplicatedStorage = game:GetService("ReplicatedStorage")


local ClaimReward = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("ChallengeService")
    :WaitForChild("RF")
    :WaitForChild("ClaimReward")


local startId = 1
local endId = 1000000 

print("Iniciando a coleta de recompensas...")

for i = startId, endId do
    local args = { i }

    
    local success, result = pcall(function()
        return ClaimReward:InvokeServer(unpack(args))
    end)

    if success then
        print("Recompensa " .. i .. " processada. Resposta: ", result)
    else
        warn("Erro ao processar ID " .. i .. ": " .. tostring(result))
    end

    
    task.wait(0.5) 
end
