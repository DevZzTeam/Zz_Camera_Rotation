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

You can simply use **/cameffect** in you chat game.

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

## License

[GNU](https://choosealicense.com/licenses/gpl-3.0/)
