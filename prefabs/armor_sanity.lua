local assets =
{
    Asset("ANIM", "anim/armor_sanity.zip"),
}

local function OnBlocked(owner) 
    owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_nightarmour") 
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "armor_sanity", "swap_body")
    inst:ListenForEvent("blocked", OnBlocked, owner)
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    inst:RemoveEventCallback("blocked", OnBlocked, owner)
end

local function OnTakeDamage(inst, damage_amount)
    local owner = inst.components.inventoryitem.owner
    if owner then
        local sanity = owner.components.sanity
        if sanity then
            local unsaneness = damage_amount * TUNING.ARMOR_SANITY_DMG_AS_SANITY
            sanity:DoDelta(-unsaneness, false)
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("armor_sanity")
    inst.AnimState:SetBuild("armor_sanity")
    inst.AnimState:PlayAnimation("anim")
    --inst.AnimState:SetMultColour(1, 1, 1, 0.6)

    inst:AddTag("sanity")

    inst.foleysound = "dontstarve/movement/foley/nightarmour"
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    inst:AddComponent("armor")
    inst.components.armor:InitCondition(TUNING.ARMOR_SANITY, TUNING.ARMOR_SANITY_ABSORPTION)
    inst.components.armor.ontakedamage = OnTakeDamage

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable.dapperness = TUNING.CRAZINESS_SMALL

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("armor_sanity", fn, assets)