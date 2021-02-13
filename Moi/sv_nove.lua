RegisterServerEvent('Nove:moi')
AddEventHandler('Nove:moi', function(text)
	TriggerClientEvent('Nove:moi', -1, text, source)
end)