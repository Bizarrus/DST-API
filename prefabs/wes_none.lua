-- AUTOGENERATED CODE BY export_accountitems.lua

local assets =
{
	Asset("ANIM", "anim/ghost_wes_build.zip"),
	Asset("ANIM", "anim/wes.zip"),
}

return CreatePrefabSkin("wes_none",
{
	base_prefab = "wes",
	type = "base",
	assets = assets,
	build_name = "wes",
	rarity = "Common",
	skins = { ghost_skin = "ghost_wes_build", normal_skin = "wes", },
	torso_tuck_builds = { "wes", },
	has_alternate_for_body = { "wes", },
	has_alternate_for_skirt = { "wes", },
})
