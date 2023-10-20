local composer = require("composer")

local scene = composer.newScene()
local scriptJogador = require("jogador")

local json = require("json")
local pontosTable = {}
local nomesTable = {}
local timerTable = {}
local filePath = system.pathForFile("pontos1.json", system.DocumentsDirectory)
local SomAplausos = audio.loadSound ("audio/recordes.mp3")

local tempoFinal 
local playerScore
print("tempo final é ", tempoFinal)




local function carregaPontos()
    local pasta = io.open(filePath, "r")

    if pasta then
        local contents = pasta:read("*a")
        io.close(pasta)
        local decodedData = json.decode(contents)
        
        if decodedData then
            pontosTable = decodedData.pontos
            nomesTable = decodedData.nomes
            timerTable = decodedData.timer
        end
    end

    if (pontosTable == nil or #pontosTable == 0) then
        pontosTable = {}
        nomesTable = {}
        timerTable = {}
        for i = 1, 6 do
            pontosTable[i] = 0
            nomesTable[i] = " "
            timerTable[i] = 0
        end
    end
end

local function salvaPontos()
    local dataToSave = {
        pontos = pontosTable,
        nomes = nomesTable,
        timer = timerTable
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

    audio.play (SomAplausos)
 

    carregaPontos()
    
    local playerName = composer.getVariable("ArmazenaJogador")

    playerScore = composer.getVariable("scoreFinal")

    tempoFinal = composer.getVariable("tempoFinal")

   

    composer.setVariable("scoreFinal", 0)

    -- Verifica se a nova pontuação é maior que a pontuação atual na tabela
    for i = 6, 1, -1 do
        if playerScore > (pontosTable[i] or 0) then
            if i < 5 then
                pontosTable[i + 1] = pontosTable[i]
                nomesTable[i + 1] = nomesTable[i]
                timerTable[i + 1] = timerTable[i]
            end
            local minutos = math.floor(tempoFinal / 60)
            local segundos = tempoFinal % 60

            pontosTable[i] = playerScore
            nomesTable[i] = playerName
            timerTable[i] = minutos .."m ".. segundos .."s"
        end
    end

    salvaPontos()

    local bg = display.newImageRect (sceneGroup, "imagens/bg-recordes.png", 1920/2.7, 1080/3.2)
    bg.x, bg.y = display.contentCenterX, display.contentCenterY

     for i = 1, 5 do
        local yPos = 200 + (i * 40)

        -- local ranking = display.newText(sceneGroup, i .. ")", display.contentCenterX-120, yPos - 160, native.systemFont, 20)
        -- ranking:setFillColor (1,1,1)
        -- ranking.anchorX = 1

        local playerNameText = display.newText(sceneGroup, nomesTable[i] or "",  display.contentCenterX-160, yPos - 130, native.systemFont, 25)
        playerNameText.anchorX = 0
        playerNameText:setFillColor (1,1,1)

        local playerScoreText = display.newText(sceneGroup, pontosTable[i] or "", display.contentCenterX+60, yPos - 130, native.systemFont, 25)
        playerScoreText.anchorX = 0
        playerScoreText:setFillColor (1,1,1)
        playerScoreText.anchorX = 0

        local playerTimerText = display.newText(sceneGroup, timerTable[i] or "",  display.contentCenterX+170, yPos - 130, native.systemFont, 25)
        playerTimerText.anchorX = 0
        playerTimerText:setFillColor (1,1,1)
    end

    local menu = display.newImageRect (sceneGroup, "imagens/menu.png", 315/2.7, 96/2.7)
    menu.x = -50
    menu.y = 50
    menu:addEventListener ("tap", gotoMenu)

    local zerar = display.newImageRect (sceneGroup, "imagens/zerar-pontos.png", 315/2.7, 96/2.7)
    zerar.x = -50
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
    audio.stop()   
        composer.removeScene("recordes")
    elseif (phase == "did") then
       
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