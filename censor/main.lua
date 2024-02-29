print("Loading Censor Plugin...")
function normalizeMessage(message)
    -- Normalize message for comparison: lower case and replace common leet speak characters
    local normalized = message:lower()
    normalized = normalized:gsub("1", "i"):gsub("!", "i"):gsub("3", "e"):gsub("4", "a"):gsub("@", "a"):gsub("0", "o"):gsub("5", "s"):gsub("7", "t")
    return normalized
end

function containsBadWord(normalizedMessage)
    -- List of normalized bad words for comparison
    local badWords = {
        "nigger", "faggot", "bitch", "slut", "retard", "whore", "cunt", "dickhead", "asshole", "motherfucker", "pussy", "kys", "kill yourself", "im going to kill you", "dumbass", "fuck", "shit", "nigga", "niga"
    }
    print("Bad words loaded: " .. table.concat(badWords, ", "))
    for _, word in ipairs(badWords) do
        if normalizedMessage:find(word) then
            return true
        end
    end

    return false
end

function MyChatMessageHandler(sender_id, sender_name, message)
    local normalizedMessage = normalizeMessage(message)

    if containsBadWord(normalizedMessage) then
        -- Optionally, log or send a message about the censor action
        -- MP.SendChatMessage(-1, "A message was censored.")
        print(sender_name .. "'s message was censored.")
        return 1  -- Cancel the event to censor the message
    else
        return 0  -- Do not cancel the event, message is fine
    end
end

MP.RegisterEvent("onChatMessage", "MyChatMessageHandler")
print("Censor Plugin Loaded.")