AMST_SHARE = AMST_SHARE or {}

---@type PaladinConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = false,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = true,
    consumeArtOfWarFlashLightMinHp = 80,
    consumeArtOfWarFlashLightIfAuraDepletedSoon = true,
    useConsecrationsMinEnemies = 2,
    useDivineStormMinEnemies = 2,
}

AMST_SHARE["CR>P/R.CFG"] = Config
if Config.onlineLoad then
    local httpRequester = _G.SendHttpRequestTinkrFix or GMR.SendHttpRequest
    httpRequester({
        Url = "https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/plugins/wotlk/rotations/paladin/02_amstaffix_paladin_retri_rotation.lua",
        Method = "Get",
        Callback = function(content)
            GMR.RunString(content)
            if AMST_SHARE["CR>P/R.LOADED"] ~= true then
                GMR.Print("[CR>P/R][ERROR] Rotation have not loaded properly!")
                GMT.Print("[CR>P/R][ERROR] Content is: " .. content)
            end
        end
    })
else
    GMR.Print("[CR>P/R] Offline loading turned on")
end
