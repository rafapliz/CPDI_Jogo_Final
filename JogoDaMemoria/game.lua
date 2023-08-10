-- local composer = require("composer")
-- local scene = composer.newScene()

-- local bg = display.newImageRect("imagens/bg.jpg")
-- bg.x = display.contentCenterX
-- bg.y = display.contentCenterY
-- bg:setFillColor(0,0,1)

-- local function shuffle(t)
--    local n = #t
--    while n > 2 do
--       local k = math.random(n)
--       t[n], t[k] = t[k], t[n]
--       n = n - 1
--    end
--    return t
-- end

-- function scene:create(event)
--    local sceneGroup = self.view

--    local cards = {"ODS2"}

--    cards = shuffle(cards)

--    local function cardTapped(event)
--       local card = event.target
--       if not card.isFlipped then
--          transition.to(card, {time = 300, xScale = 0.1, onComplete = function()
--             card:setFillColor(1, 1, 1)
--             transition.to(card, {time = 300, xScale = 1})
--          end})
--          card.isFlipped = true
--       end
--    end

--    local xOffset = 60
--    local yOffset = 100

--    for i = 1, #cards do
	
-- 	local cardFront = display.newImage(sceneGroup, "imagens/"..cards[i]..".jpg", xOffset, yOffset)
-- 	local cardBack = display.newImage(sceneGroup, "imagens/"..cards[i].."-oculta.jpg", xOffset, yOffset)
     
--       cardBack.isFlipped = true

--       cardFront:addEventListener("tap", cardTapped)
      
--       xOffset = xOffset + 80
--       if i % 4 == 0 then
--          xOffset = 60
--          yOffset = yOffset + 120
--       end
--    end
-- end

-- scene:addEventListener("create", scene)

-- return scene



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
    "imagens/ODS10.png"
}

local boardSize = 4
local totalPairs = (boardSize * boardSize) / 2
local cardSize = 100
local cardSpacing = 10
local startX = (display.contentWidth - (boardSize * (cardSize + cardSpacing)) + cardSpacing) / 2
local startY = (display.contentHeight - (boardSize * cardSize)) / 2

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

    table.insert(revealedCards, card)

    if #revealedCards == 2 then
        local card1, card2 = unpack(revealedCards)

        if card1.cardImage == card2.cardImage then
            pontos = pontos + 10
        else
            pontos = pontos - 5
            timer.performWithDelay(1000, function()
                card1.isFlipped = false
                card2.isFlipped = false
                card1.rect.isVisible = true
                card2.rect.isVisible = true
            end)
        end

        revealedCards = {}
    end
end

shuffleCards()

for row = 1, boardSize do
    for col = 1, boardSize do
        local index = (row - 1) * boardSize + col
        local card = display.newRect(startX + (col - 1) * (cardSize + cardSpacing), startY + (row - 1) * cardSize, cardSize, cardSize)
        card:setFillColor(1, 0, 0)
        card.rect = display.newRect(card.x, card.y, card.width, card.height)
        card.rect:setFillColor(1, 0, 0)
        card.rect.isVisible = true
        card.cardImage = cardImages[index]
        card.isFlipped = false

        local cardImage = display.newImageRect(cardImages[index], cardSize - 10, cardSize - 10)
        cardImage.x, cardImage.y = card.x, card.y
        card:addEventListener("tap", flipCard)
    end
end

local pontosText = display.newText({
    text = "Pontos: " .. pontos,
    x = display.contentCenterX,
    y = display.contentHeight - 20,
    fontSize = 20
})
pontosText:setFillColor(0, 0, 0)