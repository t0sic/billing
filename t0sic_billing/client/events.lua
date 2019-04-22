RegisterCommand("fetch", function()
    FetchBillings()


end)


RegisterCommand("send", function()
    SendBilling()


end)

RegisterCommand("sent", function()
    
    SentBillings()


end)



RegisterNUICallback("NUIFocusOff", function()
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = "close"
    })
end)

RegisterNUICallback("send", function(data)
    local closestPlayer = data["closestplayer"]

    TriggerServerEvent("t0sic-billing:insert", data, GetPlayerServerId(closestPlayer))   
end)



RegisterNUICallback("pay", function()
    print("Attempting to pay " .. price)
    TriggerServerEvent("t0sic-billing:payBill", id, price) 
end)
