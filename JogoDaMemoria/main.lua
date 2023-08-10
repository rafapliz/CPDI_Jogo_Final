display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/bg.jpg", 612, 408)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local cardImages = {
    "imagens/ODS1.jpg",
    "imagens/ODS2.jpg",
    "imagens/ODS3.jpg",
    "imagens/ODS4.jpg",
    "imagens/ODS5.jpg",
    "imagens/ODS6.jpg",
    "imagens/ODS7.jpg",
    "imagens/ODS8.png",
    "imagens/ODS9.png",
    "imagens/ODS10.png",
	 "imagens/ODS1.jpg",
	 "imagens/ODS2.jpg",
	 "imagens/ODS3.jpg",
	 "imagens/ODS4.jpg",
	 "imagens/ODS5.jpg",
	 "imagens/ODS6.jpg",
	 "imagens/ODS7.jpg",
	 "imagens/ODS8.png",
	 "imagens/ODS9.png",
	 "imagens/ODS10.png",
	 
	}

	local numRows = 4
	local numCols = 5
	local totalPairs = (numRows * numCols) / 2
	local cardSize = 60
	local cardSpacing = 5
	local startX = (display.contentWidth - (numCols * (cardSize + cardSpacing)) + cardSpacing) / 2
	local startY = (display.contentHeight - (numRows * (cardSize + cardSpacing))) / 2
	
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
		print("Carta 1 ",  card1)
		
		table.insert(revealedCards, card)
	
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

shuffleCards()

for row = 1, numRows do
    for col = 1, numCols do
        local index = (row - 1) * numCols + col
        local cardX = startX + (col - 1) * (cardSize + cardSpacing)
        local cardY = startY + (row - 1) * (cardSize + cardSpacing)
        
        local card = display.newRect(cardX, cardY, cardSize, cardSize)
        card:setFillColor(1, 1, 1)
        card:addEventListener("tap", flipCard)
        card.rect = display.newRect(cardX, cardY, cardSize, cardSize)
        card.rect:setFillColor(1,0,0)
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
    x = display.contentCenterX,
    y = display.contentHeight - 20,
    fontSize = 20
})
pontosText:setFillColor(1, 0, 0)

--######################### CENA MENU ################################
-- display.setStatusBar(display.HiddenStatusBar)
-- -- Importar bibliotecas
-- local composer = require("composer")

-- -- Iniciar Composer
-- composer.gotoScene("menu")

