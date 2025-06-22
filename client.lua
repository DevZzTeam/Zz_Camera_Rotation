local isRDR = GetGameName() == "redm" and true or false
local isCameraEffectRunning = false
local camera = nil

local function CreateGameplayCam()
    local playerPed = PlayerPedId()
    cam = CreateCamera("DEFAULT_SCRIPTED_CAMERA", true)
    local offsetCoords = GetGameplayCamCoord() - GetEntityCoords(playerPed)
    AttachCamToEntity(cam, playerPed, offsetCoords.x, offsetCoords.y, offsetCoords.z, false)
    SetCamFov(cam, GetGameplayCamFov())
    SetCamRot(cam, GetGameplayCamRot(0))
    RenderScriptCams(true, false, 0, false, true)
    return cam
end

local function DeleteGameplayCamera()
    SetCamActive(camera, false)
    DestroyCam(camera, false)
    RenderScriptCams(false, false, 0, false, false)
    camera = nil
end

local function StopCameraEffect()
    isCameraEffectRunning = false
    DeleteGameplayCamera()
end

exports("StopCameraEffect", StopCameraEffect)

local function GetNormalizedCursor()
    local cursorX, cursorY = GetNuiCursorPosition()
    local resX, resY
    if isRDR then
        resX, resY = GetCurrentScreenResolution()
    else
        resX, resY = GetActualScreenResolution()
    end
    local normX = cursorX / resX
    local normY = cursorY / resY

    return normX, normY
end

local function StartCameraEffect(cam, amplificator, maxX, maxY, useNuiFocus, disableAllControl, exceptControls)
    StopCameraEffect() --stop previous camera effect to avoid the loop duplication
    Wait(100)

    isCameraEffectRunning = true

    CreateThread(function()
        local exceptControls = type(exceptControls) == "table" and exceptControls or {exceptControls}

        local camExist = DoesCamExist(cam)
        if not camExist then
            camera = CreateGameplayCam()
            cam = camera
        end

        SetCamActive(cam, true)

        if useNuiFocus then
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(true)
            SetCursorLocation(0.5, 0.5)
        end

        local defaultCamRot = GetCamRot(cam, 0)

        while isCameraEffectRunning do
            Wait(0)

            if disableAllControl then DisableAllControlActions(0) end
            for _,v in pairs(exceptControls) do EnableControlAction(0, v, true) end

            local screenX, screenY = GetNormalizedCursor()
            local camRot = GetCamRot(cam, 0)
            local valueX = -(math.abs(screenX) - 0.5)
            local valueY = -(math.abs(screenY) - 0.5)
            valueX *= amplificator
            valueY *= amplificator
            local newScreenY = camRot.x + valueY
            local newScreenX = camRot.z + valueX

            if math.abs(math.abs(defaultCamRot.x) - math.abs(newScreenY)) > maxY then
                newScreenY = camRot.x --initial position
            end

            if math.abs(math.abs(defaultCamRot.z) - math.abs(newScreenX)) > maxX then
                newScreenX = camRot.z
            end

            SetCamRot(cam, newScreenY, camRot.y, newScreenX, 0)

        end

        if useNuiFocus then
            SetNuiFocus(false, false)
        end
    end)
end

exports("StartCameraEffect", StartCameraEffect)

if config.command.use and tostring(config.command.name):gsub(" ", "") ~= "" then
    RegisterCommand(config.command.name, function()
        isCameraEffectRunning = not isCameraEffectRunning
        if isCameraEffectRunning then
            StartCameraEffect(GetRenderingCam(), config.amplificator, config.maxDistanceX, config.maxDistanceY, true, config.disableAllControlAction, {isRDR and `INPUT_MP_TEXT_CHAT_ALL` or 245})
        else
            StopCameraEffect()
        end
    end, config.command.permissions)
end

AddEventHandler('onResourceStop', function()
    if DoesCamExist(camera) then DeleteGameplayCamera() end
end)