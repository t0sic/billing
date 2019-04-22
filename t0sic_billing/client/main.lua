
local ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(50)

        ESX = exports["es_extended"]:getSharedObject()
    end
end)

SendBilling = function()
    ESX.UI.Menu.CloseAll()

    local player, distance = ESX.Game.GetClosestPlayer()

    if distance <= 5.0 then
        ESX.TriggerServerCallback("t0sic-billing:getCharacterNames", function(sender, receiver)
            

            SetNuiFocus(true, true)

            SendNUIMessage({
                ["action"] = "open",
                ["sender"] = sender[1]["firstname"] .. ' ' .. sender[1]["lastname"],
                ["reciver"] = receiver[1]["firstname"] .. ' ' .. receiver[1]["lastname"],
                ["closestplayer"] = player
            })
        end, GetPlayerServerId(player))
    else
        ESX.ShowNotification("Ingen är i närheten..")
    end
end


FetchBillings = function()

    ESX.UI.Menu.CloseAll()

    local billings = {}

    ESX.TriggerServerCallback("t0sic-billing:fetchBillings", function(data)
        for i = 1, #data, 1 do
            table.insert(billings, {
                ["label"]           = 'Invoice - <span style="color:yellow"> ' .. data[i]["id"] .. '</span> - Date: <span style="color:yellow">' .. data[i]["date"] .. '</span>',
                ["date"]            = data[i]["date"],
                ["id"]              = data[i]["id"],
                ["price"]           = data[i]["amount"],
                ["reason"]          = data[i]["reason"],
                ["sender"]          = data[i]["sender"],
                ["receiver"]        = data[i]["identifier"],
                ["senderName"]      = data[i]["senderName"],
                ["receiverName"]    = data[i]["receiverName"]

            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'received_billings',
            {
                title    = 'Bills',
                align    = 'center',
                elements = billings
            }, function(data, menu)
                menu.close()
                
                SetNuiFocus(true, true)

                SendNUIMessage({
                    action      = "reciver-open",
                    sender      = data.current.senderName,
                    id          = data.current.id,
                    reciver2    = data.current.receiverName,
                    belop       = data.current.price,
                    date        = data.current.date,
                    name        = data.current.reason

                })

                price = data.current.price

                id = data.current.id

            end, function(data, menu)
            menu.close()
        end)

    end)
end

SentBillings = function()

    local billings = {}
    ESX.TriggerServerCallback("t0sic_billing:fetchSent", function(invoices)
        
        if invoices ~= nil then
            for i = 1, #invoices do
                table.insert(billings, {
                    ["label"] = '<span style="color:yellow">' .. invoices[i]["id"] .. " </span> - " .. invoices[i]["receiverName"] .. '  - <span style="color:yellow"> ' .. invoices[i]["date"] .. ' </span>',
                    ["id"] = invoices[i]["id"]
                })
            end
        end
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sent_billings',
            {
                title    = 'Invoices sent',
                align    = 'center',
                elements = billings
            }, function(data, menu)
                
                DeleteBilling(data.current)

            end, function(data, menu)
            menu.close()
        end)
    end)
end

DeleteBilling = function(invoice)

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_billing',
        {
            title    = 'Remove invoice <span style="color:yellow"> ' .. invoice["id"] .. '</span>',
            align    = 'center',
            elements = {
                { ["label"] = "Yes" },
                { ["label"] = "Yo" }
            }

        }, function(data, menu)

            if data.current.label == "Yes" then

                TriggerServerEvent("t0sic-billing:payBill", invoice["id"])
                
                ESX.UI.Menu.CloseAll()


                SentBillings()

            else
                menu.close()
            end

        end, function(data, menu)
        menu.close()
    end)

end
