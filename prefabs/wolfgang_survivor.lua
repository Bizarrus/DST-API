-- AUTOGENERATED CODE BY export_accountitems.lua

local assets =
{
	Asset("ANIM", "anim/ghost_wolfgang_build.zip"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/wolfgang_mighty_survivor.zip"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/wolfgang_survivor.zip"),
	Asset("DYNAMIC_ANIM", "anim/dynamic/wolfgang_skinny_survivor.zip"),
}

return CreatePrefabSkin("wolfgang_survivor",
{
	base_prefab = "wolfgang",
	type = "base",
	assets = assets,
	build_name = "wolfgang_survivor",
	rarity = "Elegant",
	skins = { ghost_skin = "ghost_wolfgang_build", mighty_skin = "wolfgang_mighty_survivor", normal_skin = "wolfgang_survivor", wimpy_skin = "wolfgang_skinny_survivor", },
	torso_tuck_builds = { "wolfgang_survivor", "wolfgang_skinny_survivor", "wolfgang_mighty_survivor", },
})
