local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
   local sceneGroup = self.view

   local playButton = display.newText(sceneGroup, "Jogar", display.contentCenterX, display.contentCenterY, native.systemFont, 40)

   local function goToGame()
      composer.gotoScene("game")
   end

   playButton:addEventListener("tap", goToGame)
end

scene:addEventListener("create", scene)

return scene