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
            Citizen.Wait(20)
        end
    end
end)