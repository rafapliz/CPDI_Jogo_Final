local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()
local centerX = display.contentCenterX
local centerY = display.contentCenterY

-- -----------------------------------------------------------------------------------
--O código fora das funções de evento de cena abaixo será executado apenas UMA VEZ, a menos que
-- a cena é totalmente removida (não reciclada) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMenu ()
    composer.gotoScene ("menu", {time=800, effect= "crossFade"})
end
-- -----------------------------------------------------------------------------------
-- Funções de evento de cena
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
----------------------------------------------------------------	


    local bg = display.newImageRect (sceneGroup, "imagens/desenvolvedores.png", 1920/3.3, 1080/3.3)
    bg.x, bg.y = display.contentCenterX, display.contentCenterY

    
    local menu = display.newImageRect (sceneGroup, "imagens/menu.png", 503/4.6,187/4.6)
    menu.x = display.contentCenterX + 230
    menu.y = 30
  
    menu:addEventListener ("tap", gotoMenu)
    local linkBruno = display.newText {
        text = "Linkedin.com/JoseBrunoReis",
        x = centerX - 42,
        y = centerY - 43,
        fontSize = 14,
      
    }
    linkBruno:setFillColor(1) -- Cor branca
    sceneGroup: insert(linkBruno)
    local function openBruno(event)
        if event.phase == "ended" then
            system.openURL("http://www.linkedin.com/in/josebrunoreis")
        end
    end
    
    linkBruno:addEventListener("touch", openBruno) 
       
    local linkRafael = display.newText {
        text = "Linkedin.com/RafaelPereiraDeLiz",
        x = centerX - 34,
        y = centerY + 73,
        fontSize = 14,
       
    }
    linkRafael:setFillColor(1) -- Cor branca
    sceneGroup: insert(linkRafael)

    local function openRafael(event)
        if event.phase == "ended" then
            system.openURL("http://www.linkedin.com/in/rafaelpereiradeliz")
        end
    end
    
    linkRafael:addEventListener("touch", openRafael) 
----------------------------------------------------------------
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
        composer.removeScene("equipe")
          
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