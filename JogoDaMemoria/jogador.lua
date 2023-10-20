local widget = require("widget")  
local display = require("display")
local native = require("native")

local composer = require( "composer" )

local scene = composer.newScene()

nomeJogador = ""  -- Variável para armazenar o nome do jogador

local function gotoMenu ()
	composer.gotoScene ("menu")
end

local function gotoGame()
	composer.gotoScene ("game", {time = 800, effect = "crossFade"})
end

-- create()
function scene:create( event )

	local sceneGroup = self.view

local bg = display.newImageRect (sceneGroup, "imagens/bg-jogador.png", 1600/2.2, 900/2.6)
bg.x, bg.y = display.contentCenterX, display.contentCenterY

-- Caixa de texto para o jogador digitar o nome
local caixaDeTexto = native.newTextField(display.contentCenterX, display.contentCenterY, 200, 30)
caixaDeTexto.placeholder = "Digite seu nome"
sceneGroup:insert(caixaDeTexto)

local borda = display.newRect(caixaDeTexto.x, caixaDeTexto.y, caixaDeTexto.width + 4, caixaDeTexto.height + 4)
borda:setFillColor(0, 0, 0, 0) -- Defina a cor de preenchimento para transparente
borda.strokeWidth = 3 -- Largura da borda
borda:setStrokeColor(0, 0, 0) -- Cor da borda (preto)
sceneGroup:insert(borda)

-- Variável para armazenar o nome do jogador
local nomeJogador = ""

-- Função para lidar com o clique no botão de salvar
local function salvarNome(event)
    if event.phase == "ended" then
        -- Armazena o texto da caixa de texto na variável nomeJogador
        nomeJogador = caixaDeTexto.text
		composer.setVariable("ArmazenaJogador", nomeJogador)
		gotoGame()
        -- Exibe o nome do jogador no console (opcional)
        print("Nome do jogador: " .. nomeJogador)
    end
end

-- Botão para salvar o nome
local botaoSalvar = display.newImageRect (sceneGroup, "imagens/play.png", 315/2, 96/2, native.systemFont, 44)
botaoSalvar.x, botaoSalvar.y = display.contentCenterX, 240
botaoSalvar:addEventListener("touch", salvarNome)

end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
print(nomeJogador)
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
print(nomeJogador)
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		
		
		
		composer.removeScene("jogador")

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
