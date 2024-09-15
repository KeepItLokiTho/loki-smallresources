lib.onCache('ped', function(ped)
    if Config.AlwaysKeepProps then
        SetPedCanLosePropsOnDamage(ped, false, 0)
    end
end)