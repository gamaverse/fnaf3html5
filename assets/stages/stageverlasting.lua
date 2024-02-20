-- Using Lulu's optimizations to avoid game lagging.

function onCreate()
	-- Custom functions for stage.
	createStage() -- Create stages.
	createStageAnimated() -- Create animated stages.
	createJumpscares() -- Create jumpscares.
	createVideoSprites() -- Create video sprites.
	createMiscSprites() -- Create misc sprites.
end

function createStage()

	
	for _, stage in ipairs(stages) do
		precacheImage(stage.image)
		makeLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)
	end
end

function createStageAnimated()


	for _, stage in ipairs(stagesAnimated) do
		precacheImage(stage.image)
		makeAnimatedLuaSprite(stage.name, stage.image, stage.posX, stage.posY)
		setScrollFactor(stage.name, stage.scrollX, stage.scrollY)
		addAnimationByPrefix(stage.name, stage.animation, stage.xmlPrefix, stage.fps, stage.loop)
		scaleObject(stage.name, stage.scaleX, stage.scaleY)
		addLuaSprite(stage.name, stage.add)
		setProperty(stage.name .. '.visible', false)

		if (stage.name == 'bflighter') then
			if immersionLevel == 'Partial' then
				setObjectCamera(stage.name, 'camEasy')
			else
				setObjectCamera(stage.name, 'camHUD')
			end
		end
	end
end

function createJumpscares()


	for _, jumpscare in ipairs(jumpscares) do
		precacheImage(jumpscare.image)
		makeAnimatedLuaSprite(jumpscare.name, jumpscare.image, jumpscare.posX, jumpscare.posY)
		setScrollFactor(jumpscare.name, jumpscare.scrollX, jumpscare.scrollY)
		addAnimationByPrefix(jumpscare.name, jumpscare.animation, jumpscare.xmlPrefix, jumpscare.fps, jumpscare.loop)
		scaleObject(jumpscare.name, jumpscare.scaleX, jumpscare.scaleY)
		addLuaSprite(jumpscare.name, jumpscare.add)
		setProperty(jumpscare.name .. '.visible', false)

		if immersionLevel == 'Partial' then
			setObjectCamera(jumpscare.name, 'camEasy')
		else
			setObjectCamera(jumpscare.name, 'camJump')
		end
	end
end

function createVideoSprites()


	for _, videoSprite in ipairs(videoSprites) do
		makeVideoSprite(videoSprite.name, videoSprite.video, videoSprite.posX, videoSprite.posY)
		scaleObject(videoSprite.name, videoSprite.scaleX, videoSprite.scaleY)
		setObjectCamera(videoSprite.name, videoSprite.camera)
		setScrollFactor(videoSprite.name, videoSprite.scrollX, videoSprite.scrollY);
	end
end

function createMiscSprites()


	for _, miscSprite in ipairs(miscSprites) do
		precacheImage(miscSprite.image)
		makeLuaSprite(miscSprite.name, miscSprite.image, miscSprite.posX, miscSprite.posY)
		setScrollFactor(miscSprite.name, miscSprite.scrollX, miscSprite.scrollY)
		scaleObject(miscSprite.name, miscSprite.scaleX, miscSprite.scaleX)
		setObjectCamera(miscSprite.name, miscSprite.camera)
		addLuaSprite(miscSprite.name, true)
		setProperty(miscSprite.name .. '.alpha', miscSprite.alpha)
	end
end

function onStepHit()
	if curStep == 224 then
		-- Toggle visibility of stage sprites.
		setProperty('office.visible', true)
		setProperty('bg.visible', true)
		setProperty('fan.visible', true)

		-- Toggle visibility of characters.
		setProperty('dad.visible', true)
		setProperty('boyfriend.visible', true)

	elseif curStep == 824 then
		-- Toggle visibility of stage sprites.
		setProperty('camstatic.alpha', 0)
		setProperty('cam02.alpha', 0)
		setProperty('cam05.alpha', 0)
		setProperty('camstatic.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('camstatic', 'anim', true)

	elseif curStep == 832 then
		-- Scale Springtrap's size.
		scaleObject('dad', 0.285, 0.23)

		-- Modify object order.
		setObjectOrder('bg', 0)
		setObjectOrder('office', 1)
		setObjectOrder('dadGroup', 2)
		setObjectOrder('cam05', 3)
		setObjectOrder('cam02', 4)
		setObjectOrder('camstatic', 5)
		setObjectOrder('fan', 6)

		-- Re-position characters.
		setProperty('boyfriend.x', 630)
		setProperty('boyfriend.y', 600)

		-- Toggle visibility of stage sprites.
		setProperty('cam05.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('cam05', 'anim', true)

	elseif curStep == 1088 then
		-- Scale Springtrap's size
		scaleObject('dad', 0.285, 0.23)

		-- Remove previous stage sprites.
		removeLuaSprite('cam05', true)

		-- Modify object order.
		setObjectOrder('bg', 0)
		setObjectOrder('office', 1)
		setObjectOrder('dadGroup', 2)
		setObjectOrder('cam02', 3)
		setObjectOrder('camstatic', 4)
		setObjectOrder('fan', 5)

		-- Toggle visibility of stage sprites.
		setProperty('cam02.visible', true)

		-- Force play animations so they start from the beginning.
		playAnim('cam02', 'anim', true)

	elseif curStep == 1376 then
		-- Remove previous stage sprites.
		removeLuaSprite('camstatic', true)
		removeLuaSprite('cam02', true)
		removeLuaSprite('fan', true)
		removeLuaSprite('office', true)
		removeLuaSprite('bg', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of stage sprites.
		setProperty('door.visible', true)
		setProperty('hallway.visible', true)

		-- Modify object order.
		setObjectOrder('hallway', 0)
		setObjectOrder('dadGroup', 1)
		setObjectOrder('springtrap2', 2)

		-- Re-position characters.
		setProperty('boyfriend.x', 630)
		setProperty('boyfriend.y', 400)

	elseif curStep == 1674 then
		-- Toggle visibility of HUD elements
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)
		setProperty('healthBarOverlay.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		setProperty('scoreTxt.visible', false)
		setProperty('timeTxt.visible', false)
		setProperty('timeBar.visible', false)
		setProperty('timeBarBG.visible', false)

	elseif curStep == 1678 then
		-- Remove previous stage sprites.
		removeLuaSprite('door', true)
		removeLuaSprite('hallway', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Toggle visibility of cinematic bars.
		setProperty('LowerBar(With HUD).visible', false)
		setProperty('UpperBar(With HUD).visible', false)

		-- Start video sprite playback.
		addVideoSprite('everlasting', true)

	elseif curStep == 2736 then
		-- Toggle visibility of HUD elements
		setProperty('healthBar.visible', true)
		setProperty('healthBarBG.visible', true)
		setProperty('healthBarOverlay.visible', true)
		setProperty('iconP1.visible', true)
		setProperty('iconP2.visible', true)
		setProperty('scoreTxt.visible', true)
		setProperty('timeTxt.visible', true)
		setProperty('timeBar.visible', true)
		setProperty('timeBarBG.visible', true)

	elseif curStep == 2758 then
		-- Remove previous video sprite.
		setProperty('everlasting.visible', false)

		-- Toggle visibility of cinematic bars.
		setProperty('LowerBar(With HUD).visible', true)
		setProperty('UpperBar(With HUD).visible', true)

		-- Toggle visibility of stage sprites.
		setProperty('longasshallway.visible', true)
		setProperty('bfeet.visible', true)
		setProperty('aftonfeet.visible', true)

		-- Modify object order.
		setObjectOrder('longasshallway', 0)
		setObjectOrder('bfeet', 1)
		setObjectOrder('aftonfeet', 2)
		setObjectOrder('dadGroup', 3)
		setObjectOrder('boyfriendGroup', 4)

		-- Force play animations so they start from the beginning.
		playAnim('longasshallway', 'anim', true)
		playAnim('bfeet', 'anim', true)
		playAnim('aftonfeet', 'anim', true)

		-- Re-position characters.
		setProperty('boyfriend.x', 1429)
		setProperty('boyfriend.y', 270)
		setProperty('dad.x', 301)
		setProperty('dad.y', -100)

	elseif curStep == 3280 then
		-- Remove previous stage sprites.
		removeLuaSprite('aftonfeet', true)
		removeLuaSprite('bfeet', true)
		removeLuaSprite('longasshallway', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Re-position characters.
		setProperty('boyfriend.x', 700)

		-- Start video sprite playback.
		addVideoSprite('leftbehind', true)

		-- Modify object order.
		setObjectOrder('leftbehind', 0)
		setObjectOrder('dadGroup', 1)
		setObjectOrder('boyfriendGroup', 2)

	elseif curStep == 3792 then
		-- Remove previous video sprite.
		setProperty('leftbehind.visible', false)

		-- Toggle visibility of stage sprites.
		setProperty('prefire.visible', true)

		-- Modify object order.
		setObjectOrder('prefire', 0)
		setObjectOrder('dadGroup', 1)
		setObjectOrder('boyfriendGroup', 2)

		-- Re-position characters.
		dumbassDadOffset = getProperty('dad.y')
		setProperty('dad.y', dumbassDadOffset + 60)

		-- Force play animations so they start from the beginning.
		playAnim('prefire', 'anim', true)

	elseif curStep == 3904 then
		-- Modify object order.
		setObjectOrder('rarescreen1', 50)
		setObjectOrder('rarescreen2', 51)
		setObjectOrder('rarescreen3', 52)

	elseif curStep == 4320 then
		-- Remove previous stage sprites.
		removeLuaSprite('bflighter', true)
		removeLuaSprite('prefire', true)

		-- Clear unused memory (idk if it actually does anything meaningful, traces and profiling tools showed no real difference. I'll just leave it here, just in case)
		runHaxeCode([[
			Paths.clearUnusedMemory();
		]])

		-- Start video sprite playback.
		addVideoSprite('firebg', true)

		-- Modify object order.
		setObjectOrder('prefire', 0)
		setObjectOrder('firebg', 1)
		setObjectOrder('dadGroup', 2)
		setObjectOrder('boyfriendGroup', 3)

		-- Re-position characters.
		dumbassDadOffset = getProperty('dad.y')
		setProperty('dad.y', dumbassDadOffset + 60)
	end
end

--function onPause()
--	if curStep >= 1678 and curStep <= 2758 then
--		pauseVideoSprite('everlasting')
--	elseif curStep >= 3280 and curStep <= 3791 then
--		pauseVideoSprite('leftbehind')
--	elseif curStep >= 4320 then
--		pauseVideoSprite('firebg')
--	end
--	return Function_Continue; -- return Function_Stop if you want to stop the player from pausing the game
--end

--function onResume()
--	if curStep >= 1678 and curStep <= 2758 then
--		resumeVideoSprite('everlasting')
--	elseif curStep >= 3280 and curStep <= 3791 then
--		resumeVideoSprite('leftbehind')
--	elseif curStep >= 4320 then
--		resumeVideoSprite('firebg')
--	end
--end