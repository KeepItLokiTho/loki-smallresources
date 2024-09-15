-- Controls driveby mechanics
RegisterNetEvent('QBCore:Client:EnteredVehicle', function()
    local ped = PlayerPedId()
    local oldView = 0
    while IsPedInAnyVehicle(ped, true) do
        local vehicle = GetVehiclePedIsIn(ped, false)
        local pedInDriver = GetPedInVehicleSeat(vehicle, -1)

        if pedInDriver == ped then
            SetPlayerCanDoDriveBy(PlayerId(), Config.DriverDriveBy)
            DisableControlAction(0, 68, Config.DriverDriveBy)
        else
            SetPlayerCanDoDriveBy(PlayerId(), Config.PassengerDriveBy)
            DisableControlAction(0, 68, Config.PassengerDriveBy)
        end
        if Config.ForceFirstPersonVeh then
            if IsControlJustPressed(0, 25) or IsControlJustPressed(0, 91) then
                oldView = GetFollowVehicleCamZoomLevel()
                print(oldView)
            end
            if IsControlJustPressed(0, 25) or IsControlPressed(0, 25) or IsControlJustPressed(0, 91) or IsControlPressed(0, 91) then
                SetFollowVehicleCamZoomLevel(3)
            elseif IsControlJustReleased(0, 25) or IsControlJustReleased(0, 91) then
                SetFollowVehicleCamZoomLevel(oldView)
            end
            if not IsControlJustPressed(0, 91) or not IsControlPressed(0, 91) then
                DisableControlAction(0, 92, true)
            end
        end
     Wait(1)
    end
end)