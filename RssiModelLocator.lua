local lastToneTime = 0

local function map(value, inMin, inMax, outMin, outMax)
    return outMin + (outMax - outMin) * ((value - inMin) / (inMax - inMin))
end

local function run()
    local rssi = getRSSI()
    lcd.clear()
    lcd.drawText(1, 0, "RSSI Model Finder                          ", INVERS)
    lcd.drawText(40, 15, rssi, XXLSIZE)

    -- Map RSSI (0 to 100) to a pause duration (500 ms to 100 ms)
    local beepPause = map(rssi, 0, 100, 333, 3)

    local currentTime = getTime()
    
    -- Check if it's time to play the tone
    if currentTime - lastToneTime >= beepPause then
        playTone(500, 150, 20, PLAY_NOW)
        lastToneTime = currentTime  -- Update last tone time
    end

    return 0
end

return { run = run }
