RegisterNetEvent("vorp:client:openPrompt")
AddEventHandler("vorp:client:openPrompt", function(holdMode, control, text)
    openPrompt(holdMode, control, text)
end)

RegisterNUICallback("closePrompt", function(data, cb)
    SetNuiFocus(false, false)
    if currentPrompt then
        currentPrompt.validate = true
    end
    cb("ok")
end)

function openPrompt(holdMode, control, text)
    local promptData = {
        validate = false
    }
    currentPrompt = promptData
    
    SendNUIMessage({
        type = "prompt",
        action = "open",
        data = {
            holdMode = holdMode,
            control = control,
            text = text
        }
    })
    
    SetNuiFocus(true, true)
    
    return promptData
end