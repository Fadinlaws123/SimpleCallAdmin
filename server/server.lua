-- Log System --
local timestamp = os.date("%c")

--[[
   ---------------------------------------------------
  |                                                   |
  |             Ace Permission System                 |
  |                                                   |
   ---------------------------------------------------
]]

local staffPermission = Config.Settings.acePerms

local function isStaff(player) return
    IsPlayerAceAllowed(player, staffPermission) end

local function handleStaffCommand(source, args)
    local playerName = GetPlayerName(source)
    local playerId = source

    local players = GetPlayers()
    for _, player in ipairs(players) do
        if isStaff(player) then
            if Config.Settings.chatSetting == "chat" then
                TriggerClientEvent("chat:addMessage", player, {
                    color = {0, 130, 255},
                    multiline = true,
                    args = {
                        playerName .. " Called Staff ", table.concat(args, " ")
                    }
                })
            elseif Config.Settings.chatSetting == "rtx" then
                TriggerClientEvent("rtx_notify:Notify", player, "Player " .. tostring(playerId) .. " Called Staff!", table.concat(args, " "), 15000, "warning")
            elseif Config.Settings.chatSetting == "okokNotify" then
                TriggerClientEvent('okokNotify:Alert', source, "Player " .. tostring(playerId) .. " Called Staff!", table.concat(args, " "), 15000, 'error', playSound)
            elseif Config.Settings.chatSetting == "custom" then
                -- Add your custom notify script export here
                --
                --
            end
        end
    end
end

RegisterCommand("calladmin", function(source, args, rawCommand)
    if #args <= 0 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 5px; border-radius: 5px; background-color: rgba(0, 0, 0, 0.75); border: 2px solid #FF0000; margin-bottom: 5px;">' ..
                       '<b style="color: #FF0000;">^0[^1SimpleCallAdmin^0]: </b> <span style="color: #FF0000;"> ~o~You have to put a reason for calling staff!</span>' ..
                       '</div>',
            args = {}
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 5px; border-radius: 5px; background-color: rgba(0, 0, 0, 0.75); border: 2px solid #007a01; margin-bottom: 5px;">' ..
                       '<b style="color: #007a01;">^0[^1SimpleCallAdmin^0]: </b> <span style="color: #007a01;"> ~o~You have called for an admin! Please wait for them to arrive!</span>' ..
                       '</div>',
            args = {}
        })
        handleStaffCommand(source, args)
            SimpleCallAdmin('SimpleCallAdmin \n',
                             '**→ ' .. GetPlayerName(source) ..
                                 ' called an admin!\n ** **→ Successful: ** *True* \n** → Message Details:** *' ..
                                 table.concat(args, " ") ..
                                 '*\n \n**→ Time command was executed:** *' ..
                                 timestamp ..
                                 '* \n **→ Command Used: ** */sc*')
    end
end, false)

--[[
   ---------------------------------------------------
  |                                                   |
  |         SimpleCallAdmin Logging System            |
  |                                                   |
   ---------------------------------------------------
]]

function SimpleCallAdmin(name, message)
    local content = {
        {
            ["color"] = Config.Logging.WebhookColor,
            ["title"] = "**Admin Report**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = 'Made by SimpleDevelopments',
                ["icon_url"] = Config.Logging.FooterIcon
            }
        }
    }

    PerformHttpRequest(Config.Logging.WebhookLink,
                       function(err, text, headers) end, 'POST', json.encode({
        username = Config.Logging.WebhookName,
        avatar_url = Config.Logging.WebhookPFP,
        embeds = content
    }), {['Content-Type'] = 'application/json'})
end