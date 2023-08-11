local composer = require("composer")
local scpriptGame  = require("game")
local scene = composer.newScene()

local function gotoGame()
	composer.gotoScene ("game")
end

local function gotoRecordes ()
	composer.gotoScene ("recordes")
end

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
		bg2.y = display.contentCenterY
	
	 
		local play = display.newImageRect (sceneGroup, "imagens/play.png", 506/3, 185/3, native.systemFont, 44)
		play.x, play.y = 470, 150
		
	 
		local recordes = display.newImageRect (sceneGroup, "imagens/recordes.png", 510/3, 239/3, native.systemFont, 44)
		recordes.x, recordes.y = 472, 215
	 
		play:addEventListener("tap", gotoGame)
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