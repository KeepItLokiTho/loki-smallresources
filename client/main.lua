-- Controls driveby mechanics
RegisterNetEvent('QBCore:Client:EnteredVehicle', function()
    local ped = PlayerPedId()
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
            if IsControlJustPressed(0, 25) or IsControlPressed(0, 25) or IsControlJustPressed(0, 91) or IsControlPressed(0, 91) then
                SetFollowVehicleCamViewMode(3)
            elseif IsControlJustReleased(0, 25) then
                SetFollowVehicleCamViewMode(0)
            end
            if not IsControlJustPressed(0, 91) or not IsControlPressed(0, 91) then
                DisableControlAction(0, 92, true)
            end
        end
     Wait(1)
    end
end)

-- Disables vehicle air and rollover control
RegisterNetEvent('QBCore:Client:EnteredVehicle', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if DoesEntityExist(veh) then
        local model = GetEntityModel(veh)
        -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
        if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) then
            while IsPedInAnyVehicle(ped, true) do
                local roll = GetEntityRoll(veh)
                if IsEntityInAir(veh) then --disable if airborne
                    DisableControlAction(0, 59, true) -- Disable left/right
                    DisableControlAction(0, 60, true) -- Disable up/down
                elseif (roll > 75.0 or roll < -75.0) then --disable if rolled over
                    DisableControlAction(0,59,true) -- Disable left/right
                    DisableControlAction(0,60,true) -- Disable up/down
                end
                Wait(0)
            end
        end
    end
end)

-- Makes your props not fall off when ped takes damage.
Citizen.CreateThread(function()
    if Config.PreventPropLoss then
        while true do
            Citizen.Wait(2000)
            SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
            SetPedSuffersCriticalHits(PlayerPedId(), false)
        end
    end
end)

-- Limits zoom level
Citizen.CreateThread(function()
    if Config.LimitZoomLevel then
        while true do
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                if GetFollowVehicleCamZoomLevel() == 2 then
                    SetFollowVehicleCamZoomLevel(4)
                end
            elseif GetFollowPedCamZoomLevel() == 2 then
                SetFollowPedCamViewMode(4)
            end
            Citizen.Wait(10)
        end
    end
end)
