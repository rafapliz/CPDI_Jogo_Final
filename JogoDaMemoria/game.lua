display.setStatusBar (display.HiddenStatusBar)
local composer = require("composer")
local scene = composer.newScene()

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
        local bg = display.newImageRect ("imagens/bg.jpg", 612, 408)
        bg.x = display.contentCenterX
        bg.y = display.contentCenterY 
        
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
                 "imagens/ODS1OBJ.png",
                 "imagens/ODS2OBJ.png",
                 "imagens/ODS3OBJ.png",
                 "imagens/ODS4OBJ.png",
                 "imagens/ODS5OBJ.png",
                 "imagens/ODS6OBJ.png",
                 "imagens/ODS7OBJ.png",
                 "imagens/ODS8OBJ.png",
                 "imagens/ODS9OBJ.png",
                 "imagens/ODS10OBJ.png",
                 
                }
            
            local numRows = 4
            local numCols = 5
            local totalPairs = (numRows * numCols) / 2
            local cardSize = 75
            local cardSpacing = 4
            local startX = (display.contentWidth - (4 * (cardSize + cardSpacing)) + cardSpacing) / 1
            local startY = (display.contentHeight - (3.53 * (cardSize + cardSpacing)))
                
            local revealedCards = {}
            local pontos = 0
            
            local function shuffleCards()
                for i = 1, #cardImages do
                    local randIndex = math.random(i, #cardImages)
                    cardImages[i], cardImages[randIndex] = cardImages[randIndex], cardImages[i]
                end
            end
            
            local function flipCard(event)
                local card = event.target
            
                if card.isFlipped or #revealedCards >= 2 then
                    return
                end
            
                card.isFlipped = true
                card.rect.isVisible = false
                card.cardImage.isVisible = true
                
                table.insert(revealedCards, card)	
                print("Carta 1 ",  card1)
                print("Carta 2 ",  card2)
            
                if #revealedCards == 2 then
                    local card1, card2 = unpack(revealedCards)
                    local image1 = card1.cardImage.filename
                    local image2 = card2.cardImage.filename
                    print(image1)
                    print(image2)
                    if image1 == image2 then
                        pontos = pontos + 10
                    else
                        pontos = pontos - 5
                        timer.performWithDelay(1000, function()
                            card1.isFlipped = false
                            card2.isFlipped = false
                            card1.rect.isVisible = true
                            card2.rect.isVisible = true
                            card1.cardImage.isVisible = false
                            card2.cardImage.isVisible = false
                        end)
                    end
            
                    revealedCards = {}
                end
            end
            
            --shuffleCards()
            
            for row = 1, numRows do
                for col = 1, numCols do
                    local index = (row - 1) * numCols + col
                    local cardX = startX + (col - 1) * (cardSize + cardSpacing)
                    local cardY = startY + (row - 1) * (cardSize + cardSpacing)
                    
                    local card = display.newRect(cardX, cardY, cardSize, cardSize)
                    card:setFillColor(1, 1, 0)
                    card:addEventListener("tap", flipCard)
                    card.rect = display.newRect(cardX, cardY, cardSize, cardSize)
                    card.rect:setFillColor(0.6,0.8,0)
                    card.rect.isVisible = true
                    card.isFlipped = false
            
                    local cardImage = display.newImageRect(cardImages[index], cardSize - 10, cardSize - 10)
                    cardImage.x = cardX
                    cardImage.y = cardY
                    cardImage.isVisible = false
                    card.cardImage = cardImage
                end
            end
            
            local pontosText = display.newText({
                text = "Pontos: " .. pontos,
                x = 30,
                y = display.contentHeight - 100,
                fontSize = 20
            })
            pontosText:setFillColor(1, 1, 1)
            
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
