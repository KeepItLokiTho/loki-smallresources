lib.onCache('ped', function(ped)
    if Config.HeadshotDisabled then
        SetPedCanLosePropsOnDamage(ped, false, 0)
    end
end)