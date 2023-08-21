local composer = require( "composer" )

local scene = composer.newScene()

local acertos = 0
-- função voltar para menu
local function gotoGame()
	composer.gotoScene ("game", {time = 800, effect = "crossFade"})
end

local function gotoMenu()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end
local function gotoRecordes ()
	composer.gotoScene ("recordes", {time = 800, effect = "crossFade"})
end
-- Lista de imagens para as cartas
local cartas = { "card1", "card2", "card3", "card4", "card5", "card6","card7", "card8", "card9", "card10" }
-- Número de colunas e linhas do tabuleiro
local numCols, numLinhas = 5, 4
-- Espaçamento entre as cartas
local distancia = 2
-- Largura e altura de cada carta
local larguraCarta, alturaCarta = 75 ,75
--Variáveis para armazenar as cartas viradas
local card1, card2
-- Variável para controlar se as cartas podem ser viradas
local virar = true
-- Variável que representa o tabuleiro de cartas
local tabuleiro
-- Variável que representa o numero de pontos
local pontos = 0

local recordes = 0
-- Variável que representa o numero de tentativas inicial

local cartasRestantes = 20

local placarText

-- Função para embaralhar uma tabela
local function embaralhar(tabela)
    -- Armazena o tamanho da tabela
    local n = #tabela
    -- Laço para embaralhar os elementos da tabela
    while n > 1 do
        -- Gera um número aleatório entre 1 e n
        local l = math.random(n)
        -- Troca os elementos n e k de posição
        tabela[n], tabela[l] = tabela[l], tabela[n]
        -- Reduz o tamanho da tabela para embaralhar os elementos restantes
        n = n - 1
    end
    -- Retorna a tabela com os elementos embaralhados
    return tabela
end

--Função para criar uma carta com imagem de frente e verso
local function criarCarta(x, y, frenteImagem, atrasImagem)
    -- Cria um novo grupo para as cartas
    local carta = display.newGroup()
    -- Adiciona a imagem do verso da carta
    local back = display.newImageRect(carta, atrasImagem, larguraCarta, alturaCarta)
    -- Armazena o nome da imagem da frente da carta
    carta.frenteImagem = frenteImagem
    -- Variável para controlar se a carta está virada
    carta.virada = false
    -- Define a posição inicial da carta
    carta.x, carta.y = x, y
    -- função para virar a carta
    function carta:virar()
        if not self.virada then
            self.virada = true
            transition.to(self, { time = 200, xScale = 0.1, onComplete = function()
                back.isVisible = false
                display.newImageRect(self, self.frenteImagem, larguraCarta, alturaCarta)
                transition.to(self, { time = 200, xScale = 1 })
            end})
        end
    end
    -- Função para reverter a carta para a posição inicial
    function carta:reset()
        self.virada = false
        back.isVisible = true
        display.remove(self[2])
    end
    -- Adiciona um evento de toque para a carta
    carta:addEventListener("tap", function(event)
        carta:virar()
    end)

    return carta
end

-- Função para calcular o tamanho ideal das cartas
local function tamanhoDaCarta()
    local larguraDisponivel = display.actualContentWidth - (distancia * (numCols + 1))
    local alturaDisponivel = display.actualContentHeight - (distancia * (numLinhas + 1))
    larguraCarta = 75
    alturaCarta = 75 
end

-- Função para calcular o tamanho total do tabuleiro
local function tamanhoTabuleiro()
    tamanhoDaCarta()
    local larguraTabuleiro = larguraCarta * numCols + distancia * (numCols - 1)
    local alturaTabuleiro = alturaCarta * numLinhas + distancia * (numLinhas - 1)
    return larguraTabuleiro, alturaTabuleiro
end

-- Função para criar o tabuleiro
local function criarTab()
    -- Novo grupo para o tabuleiro
    local grupoTab = display.newGroup()
    -- Calcula o tamanho total do tabuleiro
    local larguraTabuleiro, alturaTabuleiro = tamanhoTabuleiro()
    -- Posiciona o tabuleiro a partir do centro
    local startX = (display.actualContentWidth - larguraTabuleiro) / 2  + 40
    local startY = (display.actualContentHeight - alturaTabuleiro) / 2 + 40
    -- Gera posições aleatórias para as cartas no tabuleiro
    local posicoes = {}
    for i = 1, numLinhas do
        for j = 1, numCols do
            table.insert(posicoes, { startX + (larguraCarta + distancia) * (j - 1), startY + (alturaCarta + distancia) * (i - 1) })
        end
    end

    posicoes = embaralhar(posicoes)
    -- Cria as cartas e adiciona elas ao grupo do tabuleiro
    for i = 1, numLinhas * numCols / 2 do
        for j = 1, 2 do
            local indice = (i - 1) * 2 + j

            if currentImageFolder == "imagens" then
                carta = criarCarta(posicoes[indice][1], posicoes[indice][2], "imagens/"..cartas[i]..".png", "imagens/bg-carta.png")
                currentImageFolder = "imagens2"
            else
                carta = criarCarta(posicoes[indice][1], posicoes[indice][2], "imagens2/"..cartas[i]..".png", "imagens/bg-carta.png")
                currentImageFolder = "imagens"
            end

            grupoTab:insert(carta)
        end
    end

    return grupoTab
end

-- Função para verificar vitória
local function verificarVitoria()
    -- Variavel para verificaçao de cartas restantes
cartasRestantes = cartasRestantes -2


if cartasRestantes == 0 then
recordes = recordes + pontos
    composer.setVariable ("scoreFinal", recordes)
    
    --composer.setVariable ("name", nomeJogador)
    composer.gotoScene ("recordes",{time=800, effect="crossFade"})

end

end

-- Função para verificar se duas cartas viradas são iguaais
local function checar()
    -- Cria uma tabela para armazenar as cartas viradas
    local cartasViradas = {}

    -- Coleta as cartas viradas
    for i = 1, tabuleiro.numChildren do
        local carta = tabuleiro[i]
        -- Se a carta estiver virada, adiciona a tabela de cartas viradas
        if carta.virada then
            table.insert(cartasViradas, carta)
        end
    end
  
    if #cartasViradas == 3 and virar then
        
        local imagemTemporaria = display.newImageRect( "imagens/gameOver.png", 1280/3, 720/3)
        imagemTemporaria.x = display.contentCenterX
        imagemTemporaria.y = display.contentCenterY

        timer.performWithDelay(3000, function()
            display.remove(imagemTemporaria)
            pontos = 0
            gotoGame()
        end)
    end
    -- Se tiverem duas cartas viradas e a função de virar cartas estiver disponivel
    if #cartasViradas == 2 and virar then
        -- Bloqueia a função de virar cartas temporariamente
        virar = false
     
        -- Armazena as duas cartas viradas para comparação
        local card1, card2 = cartasViradas[1], cartasViradas[2]
       
        -- Verifica se as cartas são iguais

        local nomeArquivo1 = card1.frenteImagem:match("^.+/(.+)$")
      

        local nomeArquivo2 = card2.frenteImagem:match("^.+/(.+)$")
       

        local saoIguais = nomeArquivo1 == nomeArquivo2
      

        -- Função para reverter as cartas após um intervalo
        local function reverterCartas()
            card1:reset()
            card2:reset()
            -- Libera a função de virar cartas novamente
            virar = true
        end

        if saoIguais then
            -- Se forem iguais, aumenta os pontos e verifica a vitória
            acertos = acertos + 1 
            pontos = pontos + 10
            placarText.text = " " .. pontos
            if acertos == 2 then
        
                local imagemAcertoPrata = display.newImageRect( "imagens/acerto-prata.png", 503/2.5, 496/2.5)
                imagemAcertoPrata.x = display.contentCenterX-200
                imagemAcertoPrata.y = display.contentCenterY
                pontos = pontos + 5
                timer.performWithDelay(3000, function()
                    display.remove(imagemAcertoPrata)
                end)
            end
            if acertos == 3 then
        
                local imagemAcertoOuro = display.newImageRect( "imagens/acerto-ouro.png", 503/2.5, 496/2.5)
                imagemAcertoOuro.x = display.contentCenterX-200
                imagemAcertoOuro.y = display.contentCenterY
                pontos = pontos + 10
                timer.performWithDelay(3000, function()
                    display.remove(imagemAcertoOuro)
                end)
            end
            verificarVitoria()
           
            -- Remove as cartas após um pequeno atraso
            timer.performWithDelay(1000, function()
                display.remove(card1)
                display.remove(card2)
                -- Libera a função de virar cartas novamente
                virar = true
            end)
        else
            -- Reverte as cartas após um pequeno atraso e diminuir as tentativas
            timer.performWithDelay(1500, function()
                reverterCartas()
                pontos = pontos - 1
                placarText.text = " " .. pontos
                acertos = 0
  
                virar = true
            
            
            end)
        end
    end
end

-- Função chamada quando o jogador toca no tabuleiro
local function onBoardTap(event)
    checar()
end




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)
    
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 1920/2.7, 1080/3.4)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY 

    tabuleiro = criarTab()
    tabuleiro:addEventListener("tap", onBoardTap)
    sceneGroup:insert(tabuleiro)


    local fundo = display.newImageRect(sceneGroup, "imagens/pontos.png", 315/2, 96/2)
    fundo.x, fundo.y = 30, display.contentCenterY + 80
   
    placarText = display.newText(sceneGroup, " " .. pontos, 75, display.contentCenterY + 80, native.systemFont, 20)
    placarText:setFillColor(0, 0, 0)

    -- tentativasText = display.newText(sceneGroup, " " .. tentativas, 220, 15.5, native.systemFont, 20)

    local menu = display.newImageRect (sceneGroup,"imagens/menu.png", 315/2, 96/2)
    menu.x = 30    menu.y = display.contentCenterY - 90
    menu:addEventListener ("tap", gotoMenu)

    local recordes = display.newImageRect (sceneGroup,"imagens/recordes.png", 315/2, 96/2)
    recordes.x = 30
    recordes.y = display.contentCenterY - 40
    recordes:addEventListener ("tap", gotoRecordes)

end

-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
        placarText.text = " " .. pontos
        -- tentativasText.text = " " .. tentativas
    end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen 
              composer.removeScene("game")
	end
end

-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene