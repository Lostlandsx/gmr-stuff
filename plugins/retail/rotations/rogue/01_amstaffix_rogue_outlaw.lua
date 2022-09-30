--This file is part of the AmsTaFFix' GMR plugins/profiles distribution
--(https://github.com/AmsTaFFix/gmr-stuff).
--Copyright (C) 2022 Nikita Sapogov
--
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <https://www.gnu.org/licenses/>.

local ID = "CR>R/O"
local LIB_LINK = "https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/plugins/wotlk%2Bclassic%2Bretail/custom/00_amstlib.lua"
local ROTATION_LINK = "https://raw.githubusercontent.com/AmsTaFFix/gmr-stuff/main/plugins/retail/rotations/demonhunter/02_amstaffix_demonhunter_havoc_rotation.lua"
---@type RogueConfig
local Config = {
    ---Toggle debug mode. Turn on, if you encounter some issues and want to deal with it, or record a video and send
    ---to author.
    debug = true,
    ---Use standard CombatRotation pluggable function. Change only if you know what you are doing.
    useCombatRotationLauncher = true,
    ---Use online loading feature to get last updates
    onlineLoad = false,
}

do
    local msgPrefix = "[" .. ID .. "] "
    if Config.onlineLoad then
        GMR.SendHttpRequest({
            Url = LIB_LINK,
            Method = "Get",
            Callback = function(content)
                RunScript(content)
                if not amstlib then
                    GMR.Print(msgPrefix.."AmsTaFFix' Lib do not initialized properly")
                    return
                end

                local cr = amstlib:getCombatRotation(ID)
                cr:prepare(Config)
                cr:load(ROTATION_LINK)
            end
        })
    else
        GMR.Print(msgPrefix.."Offline loading of rotation initiated")
        local cr = amstlib:getCombatRotation(ID)
        cr:prepare(Config)
        cr:load(ROTATION_LINK)
    end
end