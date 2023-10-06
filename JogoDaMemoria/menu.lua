local composer = require("composer")
local scpriptGame  = require("game")

local scene = composer.newScene()



local function gotoSobre()
	composer.gotoScene ("sobre", {time = 800, effect = "crossFade"})
end
local function gotoRegras()
	composer.gotoScene ("regras", {time = 800, effect = "crossFade"})
end
local function gotoGame()
	composer.gotoScene ("game", {time = 800, effect = "crossFade"})
end
local function gotoJogador()
	composer.gotoScene ("jogador", {time = 800, effect = "crossFade"})
end
local function gotoRecordes ()
	composer.gotoScene ("recordes", {time = 800, effect = "crossFade"})
end

-- Create
function scene:create(event)
   local sceneGroup = self.view

   function scene:create( event ) 
	
	
      
   end
end

function scene:show( event ) -- Imediatamente antes ou depois da cena

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
		local sceneGroup = self.view
		-- Code here runs when the scene is first created but has not yet appeared on screen
		local bg2 = display.newImageRect (sceneGroup, "imagens/bg2.png",1024/1.4, 534/1.4 	)
		bg2.x = display.contentCenterX
		bg2.y = display.contentCenterY + 5
		composer.setVariable("scoreFinal", 0)


		local play = display.newImageRect (sceneGroup, "imagens/play.png", 315/2, 96/2, native.systemFont, 44)
		play.x, play.y = 470, 100
		
	 
		local recordes = display.newImageRect (sceneGroup, "imagens/recordes.png", 315/2, 96/2,native.systemFont, 44)
		recordes.x, recordes.y = 470, 150

		local sobre = display.newImageRect (sceneGroup, "imagens/sobre.png", 315/2, 96/2, native.systemFont, 44)
		sobre.x, sobre.y = 470, 250

		local regras = display.newImageRect (sceneGroup, "imagens/regras.png", 315/2, 96/2, native.systemFont, 44)
		regras.x, regras.y = 470, 200

		regras:addEventListener("tap", gotoRegras)
		sobre:addEventListener("tap", gotoSobre)
		play:addEventListener("tap", gotoJogador)
		recordes:addEventListener("tap", gotoRecordes)
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
		composer.removeScene("menu")
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