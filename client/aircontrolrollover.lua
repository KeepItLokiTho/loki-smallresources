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