local M = {}

local json = require("json")

local dataFileName = "playerData.json"

-- Função para carregar os dados do jogador do arquivo JSON
function M.loadPlayerData()
    local playerData = {}
    
    local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory)
    local file = io.open(filePath, "r")
    
    if file then
        local contents = file:read("*a")
        io.close(file)
        
        playerData = json.decode(contents)
    end
	if (playerData == nil or #playerData == 0) then
	     playerData = {0, 0, 0, 0, 0}
    end
    
    return playerData
end

-- Função para salvar os dados do jogador no arquivo JSON
function M.savePlayerData(nomeJogador, pontos)
    local playerData = M.loadPlayerData()
    
    table.insert(playerData, {name = nomeJogador, pontos = pontos})
    
    local filePath = system.pathForFile(dataFileName, system.DocumentsDirectory)
    local file = io.open(filePath, "w")
    
    if file then
        file:write(json.encode(playerData))
        io.close(file)
    end
end

return M