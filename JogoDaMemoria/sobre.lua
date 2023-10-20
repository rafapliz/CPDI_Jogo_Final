local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
--O código fora das funções de evento de cena abaixo será executado apenas UMA VEZ, a menos que
-- a cena é totalmente removida (não reciclada) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotoMenu ()
    composer.gotoScene ("menu", {time=800, effect= "crossFade"})
end
local function gotoEquipe ()
    composer.gotoScene ("equipe", {time=800, effect= "crossFade"})
end
-- -----------------------------------------------------------------------------------
-- Funções de evento de cena
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view


    local bg = display.newImageRect (sceneGroup, "imagens/bg-sobre.png", 1920/2.9, 1080/3.3)
    bg.x, bg.y = display.contentCenterX, display.contentCenterY

    local menu = display.newImageRect (sceneGroup, "imagens/menu.png", 503/3.6,187/3.6)
    menu.x = display.contentCenterX + 120
    menu.y = 290
        menu:addEventListener ("tap", gotoMenu)
		local equipe = display.newImageRect (sceneGroup, "imagens/equipe.png", 503/3.6,187/3.6)
    equipe.x = display.contentCenterX - 120
    equipe.y = 290
        equipe:addEventListener ("tap", gotoEquipe)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		--O código aqui é executado quando a cena ainda está fora da tela (mas está prestes a aparecer na tela)


	elseif ( phase == "did" ) then
		-- O código aqui é executado quando a cena está inteiramente na tela
        
       
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- O código aqui é executado quando a cena está na tela (mas está prestes a sair da tela)

	elseif ( phase == "did" ) then
		-- O código aqui é executado imediatamente após a cena sair totalmente da tela
        composer.removeScene("sobre")
          
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
-- O código aqui é executado antes da remoção da visualização da cena
    
end



-- -----------------------------------------------------------------------------------
-- Ouvintes de função de evento de cena
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene