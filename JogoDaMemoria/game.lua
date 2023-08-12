display.setStatusBar (display.HiddenStatusBar) -- Remove a barra de Status
local composer = require("composer") -- Chama o composer para cenas
local scene = composer.newScene() -- cria a cena



local function gotoMenu()
	composer.gotoScene ("menu")
end

local function gotoRecordes ()
	composer.gotoScene ("recordes")
end

function scene:create(event)
   local sceneGroup = self.view

   function scene:create( event ) 

      local sceneGroup = self.view
      -- Code here runs when the scene is first created but has not yet appeared on screen

      
     end
end


function scene:show( event ) -- Imediatamente antes ou depois da cena

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
        local cornerRadius = 8

        local bg = display.newImageRect ("imagens/bg.jpg", 612, 408)
        bg.x = display.contentCenterX
        bg.y = display.contentCenterY 

            -- Configurações iniciais
            local numRows = 4 -- Número de linhas de cartas
            local numCols = 5 -- Número de colunas de cartas
            local cardSize = 75 -- Tamanho das cartas
            local cardSpacing = 4 -- Espaçamento entre as cartas
            local startX = (display.contentWidth - (4 * (cardSize + cardSpacing)) + cardSpacing) / 1
            local startY = (display.contentHeight - (3.53 * (cardSize + cardSpacing)))
            local cornerRadius = 8 -- Variável para arredondamento das bordas   
            local revealedCards = {} -- Armazena as cartas viradas
            

            local pontos = 0 -- Pontuação do jogador
        -- Imagem das cartas
              local cardImages = {
                "imagens/1.jpg",
                "imagens/2.jpg",
                "imagens/3.jpg",
                "imagens/4.jpg",
                "imagens/5.jpg",
                "imagens/6.jpg",
                "imagens/7.jpg",
                "imagens/8.png",
                "imagens/9.png",
                "imagens/10.png",
                "imagens/1.jpg",
                "imagens/2.jpg",
                "imagens/3.jpg",
                "imagens/4.jpg",
                "imagens/5.jpg",
                "imagens/6.jpg",
                "imagens/7.jpg",
                "imagens/8.png",
                "imagens/9.png",
                "imagens/10.png",
                --  "imagens/ODS1OBJ.png",
                --  "imagens/ODS2OBJ.png",
                --  "imagens/ODS3OBJ.png",
                --  "imagens/ODS4OBJ.png",
                --  "imagens/ODS5OBJ.png",
                --  "imagens/ODS6OBJ.png",
                --  "imagens/ODS7OBJ.png",
                --  "imagens/ODS8OBJ.png",
                --  "imagens/ODS9OBJ.png",
                --  "imagens/ODS10OBJ.png",
                 
                }
                -- for i = 1, #cardImages do
                --     print("Posição " .. i .. ": " .. cardImages[i])
                -- end


  -- Criação das cartas
 
-- Função para comparar as cartas viradas
local function compareCards()
    local card1 = revealedCards[1]
    local card2 = revealedCards[2]

    if card1.cardImage == card2.cardImage then
        pontos = pontos + 10
        card1:removeEventListener("tap", flipCard)
        card2:removeEventListener("tap", flipCard)
    else
        pontos = pontos - 1
        timer.performWithDelay(1000, function()
            card1.isFlipped = false
            card2.isFlipped = false
            card1.rect.isVisible = true
            card2.rect.isVisible = true
            card1.cardImage.isVisible = true
            card2.cardImage.isVisible = true
            card1.frontImage.isVisible = false
            card2.frontImage.isVisible = false
        end)
    end

    revealedCards = {}  -- Limpa as cartas viradas
end

 -- Função para virar a carta
 local function flipCard(event)
    
    local card = event.target
    
    if card.isFlipped then
         return
     end                
    
    card.isFlipped = true
    card.isVisible = false  -- Esconde a imagem de fundo
    card.frontImage.isVisible = true   -- Mostra a imagem frontal

    table.insert(revealedCards, card)
--   for i = 1, #revealedCards do
--       print(revealedCards[i])
--  end
    if #revealedCards == 2 then
        local card1 = revealedCards[1]
        local card2 = revealedCards[2]
        
            if card1 == card2 then
                pontos = pontos + 10
                card1:removeEventListener("tap", flipCard)
                card2:removeEventListener("tap", flipCard)
            else
                pontos = pontos - 1
                timer.performWithDelay(1000, function()
                    card1.isFlipped = false
                    card2.isFlipped = false
                    --card1.rect.isVisible = true
                   -- card2.rect.isVisible = true
                    card1.isVisible = true
                    card2.isVisible = true
                    card1.frontImage.isVisible = false
                    card2.frontImage.isVisible = false
                end)
            end
        
              

        revealedCards = {}
        
    end
end

for row = 1, numRows do
    for col = 1, numCols do
        local index = (row - 1) * numCols + col
        local cardX = startX + (col - 1) * (cardSize + cardSpacing)
        local cardY = startY + (row - 1) * (cardSize + cardSpacing)
        
        -- Cria o retângulo arredondado com a imagem de fundo

        local card = display.newImageRect("imagens/bg-carta.png", cardSize+20, cardSize+5)  -- Imagem de fundo da carta
        card.x = cardX 
        card.y = cardY 
        card.isVisible = true  -- Mostra a imagem de fundo inicialmente
        card:addEventListener("tap", flipCard)
                            
        local frontImage = display.newImageRect(cardImages[index], cardSize - 10, cardSize - 10)  -- Imagem frontal da carta
        frontImage.x = cardX
        frontImage.y = cardY
        frontImage.isVisible = false
        card.frontImage = frontImage

       
    end
end      

            -- Função para embaralhar as cartas a cada reinício
            local function shuffleCards()
                for i = 1, #cardImages do
                    local randIndex = math.random(i, #cardImages)
                    cardImages[i], cardImages[randIndex] = cardImages[randIndex], cardImages[i]
                end
            end  
                --shuffleCards()

                

            local imagemPontos = display.newImageRect("imagens/pontos.png", 590/3.5, 223/3.5)
            imagemPontos.x, imagemPontos.y = 30, display.contentHeight - 100

            local pontosText = display.newText({
                text =  pontos,
                x = 85,
                y = display.contentHeight - 102,
                fontSize = 25
            })
            pontosText:setFillColor(0, 0, 0)
            
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	end
end

function scene:hide( event ) -- Imediatamente antes ou depois que a cena sair da tela

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
      
	end
end



function scene:destroy( event )

	local sceneGroup = self.view
	
    
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
