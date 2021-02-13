----/moi By Nove.exe

local color = {r = 0, g = 0, b = 4, alpha = 255} -- Color of the text rgb(107, 52, 254)
local font = 9 -- Font of the text
local time = 5000 -- Duration of the display of the text : 1000ms = 1sec
local nbrDisplaying = 1

RegisterCommand('moi', function(source, args)
    local text = "L'individu a dit -->" 
    for i = 1,#args do
        text = text .. '~r~ ' .. args[i]
    end
    text = text .. ' '
    TriggerServerEvent('Nove:moi', text)
end)

RegisterNetEvent('Nove:moi')
AddEventHandler('Nove:moi', function(text, source)
    local offset = 1 + (nbrDisplaying*0.12)
    Display(GetPlayerFromServerId(source), text, offset)
end)

Citizen.CreateThread(function()
	while true do 
		print('Crée par Nove.exe |  By Nove.exe')
        Wait(60*1000*10)
	end
end)

function Display(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        print(nbrDisplaying)
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = GetDistanceBetweenCoords(coordsMe['x'], coordsMe['y'], coordsMe['z'], coords['x'], coords['y'], coords['z'], true)
            if dist < 100 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.45*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end