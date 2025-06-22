# Zz Camera Rotation

Zz Camera Rotation is a **FiveM/RedM** script makes

## Installation

Using **cmd**:
```bash
cd "YOUR_SERVER_PATH/resources"
git clone https://github.com/DevZzTeam/Zz_Camera_Rotation.git
```
Or you can just download the repository and put it in your **resources** folder

add this line to your server.cfg
```lua
ensure zz_camera_rotation
```

## Configuration
Open **config.lua** and modify the settings as needed

## Usage
**In Game:**

You can simply write **/cameffect** in you chat game.

**In Your Script:**

Add this line to your fxmanifest.lua
```lua
dependency 'zz_camera_rotation'
```

These functions can only be used on the client side:
```lua
exports.zz_camera_rotation:StartCameraEffect(cam, amplificator, maxX, maxY, useNuiFocus, disableAllControl, exeptControls)

exports.zz_camera_rotation:StopCameraEffect()
```

Here is an example of a script using Event Callback:
```lua
--client.lua

RegisterNetCallbackEvent = function(eventName, handler) exports.event_callback:RegisterNetCallbackEvent(eventName, handler) end
AddCallbackEventHandler = function(eventName, handler) exports.event_callback:AddCallbackEventHandler(eventName, handler) end
TriggerCallbackEvent = function(eventName, ...) exports.event_callback:TriggerCallbackEvent(eventName, ...) end
TriggerServerCallbackEvent = function(eventName, ...) exports.event_callback:TriggerServerCallbackEvent(eventName, ...) end

local myName = "DevZzTeam"
local myAge = math.floor((math.random() * 100))

CreateThread(function()
    Wait(500) --Waiting for the creation of the callback event 'isInformationsValid' (on the server-side)
    TriggerServerCallbackEvent("isInformationsValid", myName, myAge, function(nameValid, ageValid)
        print(nameValid, ageValid)
    end)
end)
```

## License

[GNU](https://choosealicense.com/licenses/gpl-3.0/)
