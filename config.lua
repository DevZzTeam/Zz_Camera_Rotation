config = {}

config.amplificator = 0.5
config.maxDistanceX = 1 --max distance from the default camera rotation on axe X
config.maxDistanceY = 1
config.disableAllControlAction = true

config.command = {
    use = true,
    name = "cameffect",
    permissions = false
}

--exports.zz_camera_rotation:StartCameraEffect(cam, amplificator, maxX, maxY, useNuiFocus, disableAllControl, exeptControls)
--exports.zz_camera_rotation:StopCameraEffect()