closeButton = nil
local initXPos = nil
local startTime = nil

function init()
  g_ui.importStyle('questlogwindow')
  questLogButton = modules.client_topmenu.addLeftGameButton('questLogButton', tr('Quest Log'), '/images/topbuttons/questlog', function() g_game.requestQuestLog() end)

  connect(g_game, { onQuestLog = onGameQuestLog,
                    onGameEnd = destroyWindows})
end

function terminate()
  disconnect(g_game, { onQuestLog = onGameQuestLog,
                       onGameEnd = destroyWindows})

  destroyWindows()
  questLogButton:destroy()
end

function destroyWindows()
  if questLogWindow then
    questLogWindow:destroy()
  end
end

function onGameQuestLog(quests)
  destroyWindows()
  questLogWindow = g_ui.createWidget('QuestLogWindow', rootWidget)

  closeButton = questLogWindow:getChildById('closeButton')
  if not closeButton then
    print("ERROR: closeButton is nil")
    return
  end
  
  animateButtonToLeft(1000, 100) -- Move 100 pixels to the left over 1000 milliseconds
end

function animateButtonToLeft(duration, distance)
    startTime = g_clock.millis()
    initXPos = closeButton:getParent():getX() + closeButton:getParent():getWidth()
    local startX = closeButton:getX()
    closeButton:breakAnchors()  -- the button is not cnchored to the window

    local function updateButtonPosition()       
        local currentTime = g_clock.millis()
        local elapsedTime = currentTime - startTime
        local interval = elapsedTime / duration
        local newX = startX - (distance * interval) -- calculate the new position of the button
        closeButton:setX(newX)
        --print('newX: ' .. newX .. ' targetX: ' .. (questLogWindow:getX() + questLogWindow:getMarginLeft() + button:getWidth()))
       
        if newX < questLogWindow:getX() + questLogWindow:getMarginLeft() then
           --restarts the animation
           closeButton:setX(startX)
           startTime = g_clock.millis() -- reset start time for button to go back 
           scheduleEvent(updateButtonPosition, 30) --reset the animation loop
           return
        end
        scheduleEvent(updateButtonPosition, 30) --continue updating
    end
    updateButtonPosition() -- initial call to the function
end
-- funciton called in the OnClicked function in the otui file
function setRandomPosY(button) 
  startTime = g_clock.millis()

  button:setX(initXPos)

  if button:getParent() == nil then
    print("ERROR: button:getParent() is nil")
    return
  end
  --Get window dimensions
  local windowStartY = button:getParent():getY() + button:getHeight()
  local windowEndY = button:getParent():getY() + button:getParent():getHeight() - button:getHeight()
  button:setY(math.random(windowStartY, windowEndY))
end
