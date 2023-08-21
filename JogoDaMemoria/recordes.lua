local composer = require("composer")

local scene = composer.newScene()
local scriptJogador = require("jogador")

local json = require("json")
local pontosTable = {}
local nomesTable = {}
local filePath = system.pathForFile("pontos.json", system.DocumentsDirectory)

local function carregaPontos()
    local pasta = io.open(filePath, "r")

    if pasta then
        local contents = pasta:read("*a")
        io.close(pasta)
        local decodedData = json.decode(contents)
        
        if decodedData then
            pontosTable = decodedData.pontos
            nomesTable = decodedData.nomes
        end
    end

    if (pontosTable == nil or #pontosTable == 0) then
        pontosTable = {}
        nomesTable = {}
        for i = 1, 6 do
            pontosTable[i] = 0
            nomesTable[i] = " "
        end
    end
end

local function salvaPontos()
    local dataToSave = {
        pontos = pontosTable,
        nomes = nomesTable
    }

    local pasta = io.open(filePath, "w")

    if pasta then
        pasta:write(json.encode(dataToSave))
        io.close(pasta)
    end
end

local function gotoRecordes ()
	composer.gotoScene ("recordes", {time = 800, effect = "crossFade"})
end


local function gotoMenu()
    composer.gotoScene("menu", { time = 800, effect = "crossFade" })
end

local function zerarPontos ()
    pontosTable = {}
    salvaPontos()
    gotoRecordes()

end

function scene:create(event)
    local sceneGroup = self.view

    carregaPontos()
    
    local playerName = composer.getVariable("ArmazenaJogador")

    local playerScore = composer.getVariable("scoreFinal")

    composer.setVariable("scoreFinal", 0)

    -- Verifica se a nova pontuação é maior que a menor pontuação atual na tabela
    for i = 6, 1, -1 do
        if playerScore > (pontosTable[i] or 0) then
            if i < 5 then
                pontosTable[i + 1] = pontosTable[i]
                nomesTable[i + 1] = nomesTable[i]
            end
            pontosTable[i] = playerScore
            nomesTable[i] = playerName
        end
    end

    salvaPontos()

    local bg = display.newImageRect (sceneGroup, "imagens/bg-recordes.png", 1600/2.2, 900/2.6)
    bg.x, bg.y = display.contentCenterX, display.contentCenterY

    local cabecalho = display.newImageRect (sceneGroup, "imagens/recordes.png",315/2, 96/2)
    cabecalho.x = 20
    cabecalho.y = 50

    for i = 1, 5 do
        local yPos = 200 + (i * 40)

        local ranking = display.newText(sceneGroup, i .. ")", display.contentCenterX-90, yPos - 150, native.systemFont, 20)
        ranking:setFillColor (0.2, 0.5, 0.8)
        ranking.anchorX = 1

        local playerNameText = display.newText(sceneGroup, nomesTable[i] or "",  display.contentCenterX-80, yPos - 150, native.systemFont, 25)
        playerNameText.anchorX = 0
        playerNameText:setFillColor (0.2, 0.5, 0.8)

        local playerScoreText = display.newText(sceneGroup, pontosTable[i] or 0, display.contentCenterX+50, yPos - 150, native.systemFont, 25)
        playerScoreText.anchorX = 0
        playerScoreText:setFillColor (0.2, 0.5, 0.8)
        playerScoreText.anchorX = 0
    end

    local menu = display.newImageRect (sceneGroup, "imagens/menu.png", 315/2, 96/2)
    menu.x = 430
    menu.y = 275
    menu:addEventListener ("tap", gotoMenu)

    local zerar = display.newImageRect (sceneGroup, "imagens/zerar-pontos.png", 315/2, 96/2)
    zerar.x = 20
    zerar.y = 275
    zerar:addEventListener ("tap", zerarPontos)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
    elseif (phase == "did") then
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
    elseif (phase == "did") then
        composer.removeScene("recordes")
    end
end

function scene:destroy(event)
    local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
