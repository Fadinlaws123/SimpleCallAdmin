local versionUrl = "https://raw.githubusercontent.com/Fadinlaws123/SimpleCallAdmin/main/version.txt"  -- URL of the remote version file
local localVersion = "1.0.0"  -- Current local version
local logPrefix = "[Version Checker]"
local logFile = "version_checker_log.txt"
local discordWebhookUrl = Config.Logging.WebhookLink  -- Replace with your Discord webhook URL

local branding = [[

   _____ _                 _       _____      _ _             _           _       
  / ____(_)               | |     / ____|    | | |   /\      | |         (_)      
 | (___  _ _ __ ___  _ __ | | ___| |     __ _| | |  /  \   __| |_ __ ___  _ _ __  
  \___ \| | '_ ` _ \| '_ \| |/ _ \ |    / _` | | | / /\ \ / _` | '_ ` _ \| | '_ \ 
  ____) | | | | | | | |_) | |  __/ |___| (_| | | |/ ____ \ (_| | | | | | | | | | |
 |_____/|_|_| |_| |_| .__/|_|\___|\_____\__,_|_|_/_/    \_\__,_|_| |_| |_|_|_| |_|
                    | |                                                           
                    |_|                                                           
                        By SimpleDevelopments (Fadin_laws)

]]
-- Function to write log messages to a file
function logToFile(message)
    local file = io.open(logFile, "a")
    if file then
        file:write(message .. "\n")
        file:close()
    end
end

-- Function to send log messages to Discord
function sendToDiscord(message)
    local content = {
        {
            ["color"] = Config.Logging.WebhookColor,
            ["title"] = "**SimpleCallAdmin Version Checker**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = 'Made by SimpleDevelopments',
                ["icon_url"] = Config.Logging.FooterIcon
            }
        }
    }
    PerformHttpRequest(discordWebhookUrl, function(statusCode, responseText, headers)
        if statusCode == 204 then
            printToConsole("Successfully sent log to Discord.", "info", false)
        else
            printToConsole("Failed to send log to Discord. Status code: " .. statusCode, "error", false)
        end
    end, "POST", json.encode({
        username = Config.Logging.WebhookName,
        avatar_url = Config.Logging.WebhookPFP,
        embeds = content
    }), {["Content-Type"] = "application/json"})
end

-- Function to print formatted messages to the console
function printToConsole(message, type, alsoLogToDiscord)
    if type == "info" then
        print(string.format("^2%s^7 %s", logPrefix, message))  -- Green for info
    elseif type == "warning" then
        print(string.format("^3%s^7 %s", logPrefix, message))  -- Yellow for warnings
    elseif type == "error" then
        print(string.format("^1%s^7 %s", logPrefix, message))  -- Red for errors
    else
        print(string.format("%s %s", logPrefix, message))  -- Default color for general messages
    end

    -- Optionally log to Discord
    if alsoLogToDiscord then
        sendToDiscord(message)
    end
end

-- Function to check for updates
function checkForUpdate()
    PerformHttpRequest(versionUrl, function(statusCode, responseText, headers)
        if statusCode == 200 then
            print(branding)
            local remoteVersion = responseText:match("(%d+%.%d+%.%d+)")
            if remoteVersion then
                compareVersions(remoteVersion)
            else
                local errorMessage = "Failed to parse remote version."
                printToConsole(errorMessage, "error", true)
                logToFile(logPrefix .. " " .. errorMessage)
            end
        else
            print(branding)
            local errorMessage = "Failed to check for updates. Status code: " .. statusCode
            printToConsole(errorMessage, "error", true)
            logToFile(logPrefix .. " " .. errorMessage)
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end

-- Function to compare versions
function compareVersions(remoteVersion)
    if remoteVersion == localVersion then
        print(branding)
        local message = "No updates available. Local version is up to date."
        printToConsole(message, "info", true)
        logToFile(logPrefix .. " " .. message)
    else
        print(branding)
        local message = "Update available!"
        printToConsole(message, "warning", true)
        local detailedMessage = "Local version: " .. localVersion .. "\nRemote Version: " .. remoteVersion
        printToConsole(detailedMessage, "info", false)
        logToFile(logPrefix .. " " .. message)
        logToFile(logPrefix .. " " .. detailedMessage)
        sendToDiscord(message .. "\n" .. detailedMessage)
        notifyUpdateAvailable(remoteVersion)
    end
end

-- Function to notify players of an update
function notifyUpdateAvailable(remoteVersion)
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {"[Update]", "A new version (" .. remoteVersion .. ") is available! Please update your script."}
    })
end

-- Check for updates when the resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        local message = "Checking for updates..."
        printToConsole(message, "info", false)  -- Only print to console, do not send to Discord
        logToFile(logPrefix .. " " .. message)
        checkForUpdate()
    end
end)