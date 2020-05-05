ped = PlayerPedId()
RegisterCommand('rcpweapons', function()
	CreateThread(function()
		SendNUIMessage({showmenu = true, menuclick = true, showstats = true, damage = 0, speed = 0, capacity = 0, accuracy = 0, range = 0,
    					compdamage = 0, compspeed = 0, compcapacity = 0, compaccuracy = 0, comprange = 0})
		SetNuiFocus(true, true)
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
		ped = PlayerPedId()
		pedheading = GetEntityHeading(ped)
		SetEntityHeading(ped,0.0)
		freeze = true
		local px,py,pz = table.unpack(GetEntityCoords(ped))
		FreezeEntityPosition(ped,true)
		SetEntityCoords(ped,px,py,pz+1000.0,false,false,false,false)
		x,y,z = table.unpack(GetEntityCoords(ped))

		SetCamCoord(cam,x,y,z)
    	SetCamRot(cam,0,0,0)
		RenderScriptCams(true, false, 0, 1, 0)

		local wall = GetHashKey("gr_prop_gr_target_2_04b")
    	RequestModel(wall)
    	while not HasModelLoaded(wall) do
    	    Wait(0)
    	end

    	wall1 = CreateObject(wall,x,y,z+10.0,true,true,true)
    	FreezeEntityPosition(wall1,true)
    	SetEntityCollision(wall1,false,true)

    	wall2 = CreateObject(wall,x,y,z-10.0,true,true,true)
    	FreezeEntityPosition(wall2,true)
    	SetEntityCollision(wall2,false,true)

    	wall3 = CreateObject(wall,x,y-10.0,z,true,true,true)
    	FreezeEntityPosition(wall3,true)
    	SetEntityCollision(wall3,false,true)
    	SetEntityRotation(wall3,90.0,0.0,0.0,1,true)

    	wall4 = CreateObject(wall,x,y+10.0,z,true,true,true)
    	FreezeEntityPosition(wall4,true)
    	SetEntityCollision(wall4,false,true)
    	SetEntityRotation(wall4,90.0,0.0,0.0,1,true)

    	wall5 = CreateObject(wall,x-10.0,y,z,true,true,true)
    	FreezeEntityPosition(wall5,true)
    	SetEntityCollision(wall5,false,true)
    	SetEntityRotation(wall5,0.0,90.0,0.0,1,true)

    	wall6 = CreateObject(wall,x+10.0,y,z,true,true,true)
    	FreezeEntityPosition(wall6,true)
    	SetEntityCollision(wall6,false,true)
    	SetEntityRotation(wall6,0.0,90.0,0.0,1,true)

    	SetEntityAsMissionEntity(wall1,true,true)
    	SetEntityAsMissionEntity(wall2,true,true)
    	SetEntityAsMissionEntity(wall3,true,true)
    	SetEntityAsMissionEntity(wall4,true,true)
    	SetEntityAsMissionEntity(wall5,true,true)
    	SetEntityAsMissionEntity(wall6,true,true)

    	SetEntityAlpha(ped,0,true)
    	ResetEntityAlpha(GetCurrentPedWeaponEntityIndex(ped))

    	SetPlayerHasReserveParachute(PlayerId())
    end)
end, false)

RegisterNUICallback('close', function()
	SendNUIMessage({showmenu = false, menuclick = false, showstats = false})
	SetNuiFocus(false,false)
	freeze = false
	light = false

	RenderScriptCams(false, false, 0, 1, 0)
	DetachCam(cam)
	DestroyCam(cam, false)
	SetEntityHeading(ped,pedheading)
	
	SetEntityAsNoLongerNeeded(wall1)
	SetEntityAsNoLongerNeeded(wall2)
	SetEntityAsNoLongerNeeded(wall3)
	SetEntityAsNoLongerNeeded(wall4)
	SetEntityAsNoLongerNeeded(wall5)
	SetEntityAsNoLongerNeeded(wall6)

	DeleteObject(wall1)
	DeleteObject(wall2)
	DeleteObject(wall3)
	DeleteObject(wall4)
	DeleteObject(wall5)
	DeleteObject(wall6)

	ResetEntityAlpha(ped)

	SetEntityCoords(ped,x,y,z-1000.0,false,false,false,false)
	FreezeEntityPosition(ped,false)
end)

freeze = false
CreateThread(function()
	while true do
		Wait(0)
		if freeze then
			ClearPedTasksImmediately(ped)
			HideHudAndRadarThisFrame()
			DisplayAmmoThisFrame(true)
		end
	end
end)

light = false
CreateThread(function()
	while true do
		Wait(0)
		if light then
			DrawLightWithRange((wx-weapons[w].x),(wy-weapons[w].y),(wz-weapons[w].z),255,255,255,5.0,1.0)
			--X,Y,Z,R,G,B,range num, intensity num
		end
	end
end)

weapons = {
[-1786099057] = {["name"] = "weapon_bat", 				 ["x"] = 1.02,  ["y"] = -0.07, ["z"] = -0.18, ["pitch"] = 23.08,  ["roll"] = -179.9, ["yaw"] = -102.16},
[-853065399]  = {["name"] = "weapon_battleaxe", 		 ["x"] = 0.25,  ["y"] = 0.25,  ["z"] = 0.13,  ["pitch"] = 2.71,   ["roll"] = 0.0,    ["yaw"] = 49.69},
[-102323637]  = {["name"] = "weapon_bottle", 			 ["x"] = 0.39,  ["y"] = 0.11,  ["z"] = -0.08, ["pitch"] = -46.4,  ["roll"] = 0.0,    ["yaw"] = 47.3},
[-2067956739] = {["name"] = "weapon_crowbar", 			 ["x"] = 0.25,  ["y"] = 0.07,  ["z"] = 0.22,  ["pitch"] = 27.5,   ["roll"] = 0.0,    ["yaw"] = 64.5},
[-1834847097] = {["name"] = "weapon_dagger", 			 ["x"] = 0.31,  ["y"] = 0.11,  ["z"] = 0.12,  ["pitch"] = 6.3,    ["roll"] = 0.0,    ["yaw"] = 67.21},
[-1951375401] = {["name"] = "weapon_flashlight",		 ["x"] = 0.41,  ["y"] = 0.17,  ["z"] = -0.07, ["pitch"] = -41.59, ["roll"] = 0.0,    ["yaw"] = 41.69},
[1141786504]  = {["name"] = "weapon_golfclub", 			 ["x"] = -0.06, ["y"] = 0.34,  ["z"] = 0.22,  ["pitch"] = 9.9,    ["roll"] = 0.0,    ["yaw"] = 66.5},
[1317494643]  = {["name"] = "weapon_hammer", 			 ["x"] = 0.3,   ["y"] = 0.2,   ["z"] = 0.12,  ["pitch"] = 2.8,    ["roll"] = 0.0,    ["yaw"] = 58.3},
[-102973651]  = {["name"] = "weapon_hatchet", 			 ["x"] = 0.2,   ["y"] = 0.19,  ["z"] = 0.2,   ["pitch"] = 19.4,   ["roll"] = 0.0,    ["yaw"] = 58.51},
[-1716189206] = {["name"] = "weapon_knife", 			 ["x"] = 0.29,  ["y"] = 0.15,  ["z"] = 0.07,  ["pitch"] = -3.0,   ["roll"] = 1.28,   ["yaw"] = 59.4},
[-656458692]  = {["name"] = "weapon_knuckle", 			 ["x"] = 0.46,  ["y"] = -0.04, ["z"] = -0.06, ["pitch"] = -63.7,  ["roll"] = 0.0,    ["yaw"] = 65.2},
[-581044007]  = {["name"] = "weapon_machete", 			 ["x"] = 0.26,  ["y"] = 0.19,  ["z"] = 0.04,  ["pitch"] = -6.9,   ["roll"] = 0.0,    ["yaw"] = 66.1},
[1737195953]  = {["name"] = "weapon_nightstick", 		 ["x"] = 0.21,  ["y"] = 0.21,  ["z"] = 0.15,  ["pitch"] = 0.6,    ["roll"] = 0.0,    ["yaw"] = 68.7},
[-1810795771] = {["name"] = "weapon_poolcue", 			 ["x"] = 1.05,  ["y"] = -0.1,  ["z"] = 0.05,  ["pitch"] = -5.59,  ["roll"] = 0.0,    ["yaw"] = -130.5},
[940833800]   = {["name"] = "weapon_stone_hatchet",		 ["x"] = 0.25,  ["y"] = 0.31,  ["z"] = 0.06,  ["pitch"] = -2.49,  ["roll"] = 0.0,    ["yaw"] = 49.3},
[-538741184]  = {["name"] = "weapon_switchblade", 		 ["x"] = 0.39,  ["y"] = 0.2,   ["z"] = 0.06,  ["pitch"] = -10.59, ["roll"] = 0.0,    ["yaw"] = 36.69},
[419712736]   = {["name"] = "weapon_wrench", 			 ["x"] = 0.3,   ["y"] = 0.38,  ["z"] = 0.07,  ["pitch"] = -1.59,  ["roll"] = 0.0,    ["yaw"] = 41.3},
[-1569615261] = {["name"] = "weapon_unarmed", 			 ["x"] = 0.0,   ["y"] = 0.0,   ["z"] = 0.0,   ["pitch"] = 0.0,    ["roll"] = 0.0,    ["yaw"] = 0.0,},

[584646201]   = {["name"] = "weapon_appistol", 			 ["x"] = 0.61,  ["y"] = 0.08,  ["z"] = 0.52,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[1593441988]  = {["name"] = "weapon_combatpistol", 		 ["x"] = 0.61,  ["y"] = 0.06,  ["z"] = 0.48,  ["pitch"] = 74.39,  ["roll"] = 0.0,    ["yaw"] = -8.75},
[-771403250]  = {["name"] = "weapon_heavypistol", 		 ["x"] = 0.61,  ["y"] = 0.09,  ["z"] = 0.49,  ["pitch"] = 69.89,  ["roll"] = 0.0,    ["yaw"] = -8.85},
[453432689]	  = {["name"] = "weapon_pistol", 			 ["x"] = 0.61,  ["y"] = 0.07,  ["z"] = 0.51,  ["pitch"] = 71.69,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[-1075685676] = {["name"] = "weapon_pistol_mk2", 		 ["x"] = 0.61,  ["y"] = 0.08,  ["z"] = 0.5,   ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[-1716589765] = {["name"] = "weapon_pistol50", 			 ["x"] = 0.65,  ["y"] = 0.07,  ["z"] = 0.59,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[-1076751822] = {["name"] = "weapon_snspistol", 		 ["x"] = 0.54,  ["y"] = 0.06,  ["z"] = 0.33,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[-2009644972] = {["name"] = "weapon_snspistol_mk2", 	 ["x"] = 0.59,  ["y"] = 0.08,  ["z"] = 0.45,  ["pitch"] = 69.39,  ["roll"] = 0.15,   ["yaw"] = -10.12},
[137902532]   = {["name"] = "weapon_vintagepistol", 	 ["x"] = 0.61,  ["y"] = 0.06,  ["z"] = 0.52,  ["pitch"] = 77.09,  ["roll"] = 0.0,    ["yaw"] = -5.75},
[-1746263880] = {["name"] = "weapon_doubleaction", 		 ["x"] = 0.61,  ["y"] = 0.08,  ["z"] = 0.47,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -6.15},
[-1045183535] = {["name"] = "weapon_revolver", 			 ["x"] = 0.6,   ["y"] = 0.08,  ["z"] = 0.48,  ["pitch"] = 76.29,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[-879347409]  = {["name"] = "weapon_revolver_mk2", 		 ["x"] = 0.62,  ["y"] = 0.1,   ["z"] = 0.51,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.85},
[1198879012]  = {["name"] = "weapon_flaregun", 			 ["x"] = 0.59,  ["y"] = 0.08,  ["z"] = 0.41,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[911657153]   = {["name"] = "weapon_stungun", 			 ["x"] = 0.56,  ["y"] = 0.08,  ["z"] = 0.38,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[-598887786]  = {["name"] = "weapon_marksmanpistol", 	 ["x"] = 0.65,  ["y"] = 0.07,  ["z"] = 0.56,  ["pitch"] = 84.89,  ["roll"] = 0.0,    ["yaw"] = -3.45},
[-1355376991] = {["name"] = "weapon_raypistol", 		 ["x"] = 0.57,  ["y"] = 0.09,  ["z"] = 0.39,  ["pitch"] = 69.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},

[-270015777]  = {["name"] = "weapon_assaultsmg", 		 ["x"] = 0.63,  ["y"] = 0.03,  ["z"] = 0.6,   ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -6.25},
[171789620]   = {["name"] = "weapon_combatpdw", 		 ["x"] = 0.64,  ["y"] = 0.03,  ["z"] = 0.56,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -5.05},
[-619010992]  = {["name"] = "weapon_machinepistol", 	 ["x"] = 0.63,  ["y"] = 0.03,  ["z"] = 0.56,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -1.25},
[324215364]   = {["name"] = "weapon_microsmg", 			 ["x"] = 0.62,  ["y"] = 0.03,  ["z"] = 0.56,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -9.45},
[-1121678507] = {["name"] = "weapon_minismg", 			 ["x"] = 0.58,  ["y"] = 0.04,  ["z"] = 0.46,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -3.24},
[736523883]   = {["name"] = "weapon_smg", 				 ["x"] = 0.69,  ["y"] = 0.01,  ["z"] = 0.68,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -6.65},
[2024373456]  = {["name"] = "weapon_smg_mk2", 			 ["x"] = 0.69,  ["y"] = 0.03,  ["z"] = 0.6,   ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -6.25},
[1198256469]  = {["name"] = "weapon_raycarbine", 		 ["x"] = 0.75,  ["y"] = 0.0,   ["z"] = 0.79,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -6.25},
[2144741730]  = {["name"] = "weapon_combatmg", 			 ["x"] = 0.68,  ["y"] = 0.06,  ["z"] = 0.78,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -9.85},
[-608341376]  = {["name"] = "weapon_combatmg_mk2",       ["x"] = 0.69,  ["y"] = 0.05,  ["z"] = 0.77,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.25},
[1627465347]  = {["name"] = "weapon_gusenberg", 		 ["x"] = 0.64,  ["y"] = 0.03,  ["z"] = 0.62,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.75},
[-1660422300] = {["name"] = "weapon_mg", 				 ["x"] = 0.75,  ["y"] = 0.03,  ["z"] = 0.89,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.15},

[-1357824103] = {["name"] = "weapon_advancedrifle", 	 ["x"] = 0.66,  ["y"] = 0.03,  ["z"] = 0.65,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -6.85},
[-1074790547] = {["name"] = "weapon_assaultrifle", 		 ["x"] = 0.78,  ["y"] = 0.01,  ["z"] = 0.94,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -9.95},
[961495388]   = {["name"] = "weapon_assaultrifle_mk2",   ["x"] = 0.8,   ["y"] = 0.01,  ["z"] = 0.95,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -9.75},
[2132975508]  = {["name"] = "weapon_bullpuprifle", 		 ["x"] = 0.7,   ["y"] = 0.03,  ["z"] = 0.73,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -9.55},
[-2066285827] = {["name"] = "weapon_bullpuprifle_mk2",   ["x"] = 0.7,   ["y"] = 0.04,  ["z"] = 0.77,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.35},
[-2084633992] = {["name"] = "weapon_carbinerifle", 		 ["x"] = 0.68,  ["y"] = 0.03,  ["z"] = 0.66,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -5.95},
[-86904375]   = {["name"] = "weapon_carbinerifle_mk2", 	 ["x"] = 0.75,  ["y"] = 0.03,  ["z"] = 0.79,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.15},
[1649403952]  = {["name"] = "weapon_compactrifle", 		 ["x"] = 0.65,  ["y"] = 0.01,  ["z"] = 0.58,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.15},
[-1063057011] = {["name"] = "weapon_specialcarbine", 	 ["x"] = 0.73,  ["y"] = 0.03,  ["z"] = 0.79,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -6.05},
[-1768145561] = {["name"] = "weapon_specialcarbine_mk2", ["x"] = 0.76,  ["y"] = 0.03,  ["z"] = 0.81,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.15},

[205991906]   = {["name"] = "weapon_heavysniper", 		 ["x"] = 0.84,  ["y"] = 0.03,  ["z"] = 1.01,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.15},
[177293209]   = {["name"] = "weapon_heavysniper_mk2", 	 ["x"] = 0.88,  ["y"] = 0.03,  ["z"] = 1.17,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.15},
[-952879014]  = {["name"] = "weapon_marksmanrifle", 	 ["x"] = 0.8,   ["y"] = 0.01,  ["z"] = 0.92,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.55},
[1785463520]  = {["name"] = "weapon_marksmanrifle_mk2",  ["x"] = 0.83,  ["y"] = 0.03,  ["z"] = 0.96,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -8.85},
[100416529]   = {["name"] = "weapon_sniperrifle", 		 ["x"] = 0.82,  ["y"] = 0.02,  ["z"] = 0.95,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},

[-494615257]  = {["name"] = "weapon_assaultshotgun", 	 ["x"] = 0.73,  ["y"] = 0.02,  ["z"] = 0.79,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[-1654528753] = {["name"] = "weapon_bullpupshotgun", 	 ["x"] = 0.7,   ["y"] = 0.05,  ["z"] = 0.75,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[-275439685]  = {["name"] = "weapon_dbshotgun", 		 ["x"] = 0.71,  ["y"] = 0.03,  ["z"] = 0.61,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[984333226]   = {["name"] = "weapon_heavyshotgun", 		 ["x"] = 0.8,   ["y"] = 0.02,  ["z"] = 0.89,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[487013001]   = {["name"] = "weapon_pumpshotgun", 		 ["x"] = 0.79,  ["y"] = 0.01,  ["z"] = 0.95,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[1432025498]  = {["name"] = "weapon_pumpshotgun_mk2", 	 ["x"] = 0.79,  ["y"] = 0.01,  ["z"] = 0.97,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[2017895192]  = {["name"] = "weapon_sawnoffshotgun", 	 ["x"] = 0.68,  ["y"] = 0.02,  ["z"] = 0.56,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[317205821]   = {["name"] = "weapon_autoshotgun", 		 ["x"] = 0.6,   ["y"] = 0.03,  ["z"] = 0.48,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[-1466123874] = {["name"] = "weapon_musket", 			 ["x"] = 0.81,  ["y"] = 0.02,  ["z"] = 0.98,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},

[125959754]   = {["name"] = "weapon_compactlauncher", 	 ["x"] = 0.59,  ["y"] = 0.06,  ["z"] = 0.46,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[2138347493]  = {["name"] = "weapon_firework",			 ["x"] = 0.53,  ["y"] = 0.05,  ["z"] = 0.68,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[-1568386805] = {["name"] = "weapon_grenadelauncher", 	 ["x"] = 0.7,   ["y"] = 0.05,  ["z"] = 0.62,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[1672152130]  = {["name"] = "weapon_hominglauncher", 	 ["x"] = 0.51,  ["y"] = 0.04,  ["z"] = 0.69,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[1119849093]  = {["name"] = "weapon_minigun", 			 ["x"] = 0.85,  ["y"] = -0.04, ["z"] = 1.05,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[1834241177]  = {["name"] = "weapon_railgun", 			 ["x"] = 0.73,  ["y"] = 0.04,  ["z"] = 0.78,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[-1312131151] = {["name"] = "weapon_rpg", 				 ["x"] = 0.52,  ["y"] = 0.07,  ["z"] = 0.77,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},
[-1238556825] = {["name"] = "weapon_rayminigun", 		 ["x"] = 0.77,  ["y"] = -0.19, ["z"] = 1.11,  ["pitch"] = 85.39,  ["roll"] = 0.0,    ["yaw"] = -7.35},

[600439132]   = {["name"] = "weapon_ball", 				 ["x"] = 0.32,  ["y"] = -0.04, ["z"] = 0.11,  ["pitch"] = -0.65,  ["roll"] = 0.0,    ["yaw"] = 88.39},
[-1600701090] = {["name"] = "weapon_bzgas", 			 ["x"] = 0.74,  ["y"] = -0.09, ["z"] = 0.1,   ["pitch"] = -0.92,  ["roll"] = 0.0,    ["yaw"] = -118.18},
[101631238]   = {["name"] = "weapon_fireextinguisher", 	 ["x"] = 0.22,  ["y"] = 0.13,  ["z"] = 0.39,  ["pitch"] = 8.8,    ["roll"] = 0.0,    ["yaw"] = 66.5},
[1233104067]  = {["name"] = "weapon_flare", 			 ["x"] = 0.63,  ["y"] = 0.04,  ["z"] = -0.09, ["pitch"] = -64.39, ["roll"] = 0.0,    ["yaw"] = -108.19},
[-1813897027] = {["name"] = "weapon_grenade", 			 ["x"] = 0.66,  ["y"] = -0.04, ["z"] = -0.06, ["pitch"] = -55.59, ["roll"] = 0.0,    ["yaw"] = -113.66},
[883325847]   = {["name"] = "weapon_petrolcan", 		 ["x"] = 0.12,  ["y"] = 0.01,  ["z"] = 0.25,  ["pitch"] = -2.2,   ["roll"] = 0.0,    ["yaw"] = 76.7},
[615608432]   = {["name"] = "weapon_molotov", 			 ["x"] = 0.44,  ["y"] = 0.12,  ["z"] = 0.39,  ["pitch"] = 77.52,  ["roll"] = 0.0,    ["yaw"] = -9.18},
[-1169823560] = {["name"] = "weapon_pipebomb", 			 ["x"] = 0.35,  ["y"] = 0.02,  ["z"] = -0.01, ["pitch"] = -34.3,  ["roll"] = 0.0,    ["yaw"] = 66.5},
[-1420407917] = {["name"] = "weapon_proxmine", 			 ["x"] = 0.4,   ["y"] = -0.01, ["z"] = 0.25,  ["pitch"] = 46.49,  ["roll"] = 0.0,    ["yaw"] = 62.3},
[-37975472]   = {["name"] = "weapon_smokegrenade", 		 ["x"] = 0.74,  ["y"] = -0.09, ["z"] = 0.1,   ["pitch"] = -0.92,  ["roll"] = 0.0,    ["yaw"] = -118.18},
[126349499]   = {["name"] = "weapon_snowball", 			 ["x"] = 0.32,  ["y"] = -0.04, ["z"] = 0.11,  ["pitch"] = -0.65,  ["roll"] = 0.0,    ["yaw"] = 88.39},
[741814745]   = {["name"] = "weapon_stickybomb", 		 ["x"] = 0.37,  ["y"] = 0.0,   ["z"] = 0.25,  ["pitch"] = 43.79,  ["roll"] = 0.0,    ["yaw"] = 58.7},

[-72657034]   = {["name"] = "gadget_parachute", 		 ["x"] = 0.0,   ["y"] = 0.0,   ["z"] = 0.0,   ["pitch"] = 0.0,    ["roll"] = 0.0,    ["yaw"] = 0.0},
[-38085395]   = {["name"] = "weapon_digiscanner", 		 ["x"] = 0.36,  ["y"] = 0.05,  ["z"] = -0.16, ["pitch"] = -49.09, ["roll"] = 0.0,    ["yaw"] = 74.59},
[-2000187721] = {["name"] = "weapon_briefcase", 		 ["x"] = 0.17,  ["y"] = -0.04, ["z"] = 0.22,  ["pitch"] = -3.7,   ["roll"] = 0.0,    ["yaw"] = 81.7},
[28811031]    = {["name"] = "weapon_briefcase_02", 		 ["x"] = 0.17,  ["y"] = -0.04, ["z"] = 0.22,  ["pitch"] = -3.7,   ["roll"] = 0.0,    ["yaw"] = 81.7},
}

RegisterNUICallback('weapon', function(data)
	CreateThread(function()
		w = GetHashKey(data.weapon)
		RequestWeaponAsset(tonumber(w))
        while not HasWeaponAssetLoaded(tonumber(w)) do
            Wait(0)
        end

		if GetWeapontypeGroup(w) == -37788308 then --Fire Ext slot
			GiveWeaponToPed(ped,w,10000,0,true)
		elseif GetWeapontypeGroup(w) == 1595662460 then --Jerry Can slot
			GiveWeaponToPed(ped,w,10000,0,true)
		elseif HasPedGotWeapon(ped,w,false) then
			SetCurrentPedWeapon(ped,w,true)
		else
			GiveWeaponToPed(ped,w,1,0,true)
		end
		if weapons[w] then
			wx,wy,wz = table.unpack(GetEntityCoords(ped))
			SetCamCoord(cam,wx-weapons[w].x,wy-weapons[w].y,wz-weapons[w].z)
    		SetCamRot(cam,weapons[w].pitch,weapons[w].roll,weapons[w].yaw)
    		light = true
    	end
    	UpdateStats()
		datatext = data.text.." Selected"
		DrawTextWait()
	end)
end)

RegisterNUICallback('component', function(data)
	CreateThread(function()
		local component = tostring(data.component)
		if string.find(component, "tint") then
			if string.find(component, "reserveparachute") then
				SetPedReserveParachuteTintIndex(ped,tonumber(string.sub(component,-1)))
				datatext = data.text.." Reserve Parachute Tint Set"
			elseif string.find(component, "parachute") then
				SetPedParachuteTintIndex(ped,tonumber(string.sub(component,-1)))
				datatext = data.text.." Parachute Tint Set"
			elseif string.find(component, "mk2") then
				local getnumber = string.match(component,"%d+")
				SetPedWeaponTintIndex(ped,w,tonumber(string.sub(getnumber,2)))
				datatext = data.text.." MK2 Tint Set"
			elseif string.find(component, "ray") then
				SetPedWeaponTintIndex(ped,w,tonumber(string.sub(component,-1)))
				datatext = data.text.." Ray Weapon Tint Set"
			else
				SetPedWeaponTintIndex(ped,w,tonumber(string.sub(component,-1)))
				datatext = data.text.." Tint Set"
			end
		else
			local componenthash = GetHashKey(component)
			if HasPedGotWeaponComponent(ped,w,componenthash) then
				RemoveWeaponComponentFromPed(ped,w,componenthash)
				datatext = data.text.." Removed"
			else
				GiveWeaponComponentToPed(ped,w,componenthash)
				datatext = data.text.." Added"
			end
			
		end
		UpdateStats()
		DrawTextWait()
	end)
end)

function UpdateStats()
	compdamagetotal = 0
	compspeedtotal = 0
	compcapacitytotal = 0
	compaccuracytotal = 0
	comprangetotal = 0
	for i, comphash in pairs(componentlist) do
		hash = GetHashKey(comphash)
		if HasPedGotWeaponComponent(ped,w,hash) then
			local retval,compdamage,compspeed,compcapacity,compaccuracy,comprange = GetStats(hash,0xB3CAF387AE12E9F8)
			if ((comphash == "COMPONENT_HEAVYPISTOL_CLIP_02") or (comphash == "COMPONENT_VINTAGEPISTOL_CLIP_02") or (comphash == "COMPONENT_SNSPISTOL_CLIP_02")
			or (comphash == "COMPONENT_SNSPISTOL_MK2_CLIP_02") or (comphash == "COMPONENT_HEAVYSHOTGUN_CLIP_02") or (comphash == "COMPONENT_MARKSMANRIFLE_CLIP_02")
			or (comphash == "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02")) then
				compcapacity = 100
			elseif comphash == "COMPONENT_MINISMG_CLIP_02" then
				compcapacity = 50
			elseif ((comphash == "COMPONENT_MACHINEPISTOL_CLIP_02") or (comphash == "COMPONENT_GUSENBERG_CLIP_02")) then
				compcapacity = 66
			elseif comphash == "COMPONENT_MICROSMG_CLIP_02" then
				compcapacity = 87
			elseif ((comphash == "COMPONENT_ASSAULTSHOTGUN_CLIP_02") or (comphash == "COMPONENT_HEAVYSHOTGUN_CLIP_03")) then
				compcapacity = 400
			elseif comphash == "COMPONENT_HEAVYSNIPER_MK2_CLIP_02" then
				compcapacity = 33
			elseif comphash == "COMPONENT_MACHINEPISTOL_CLIP_03" then
				compcapacity = 150
			elseif ((comphash == "COMPONENT_SMG_CLIP_03") or (comphash == "COMPONENT_COMBATPDW_CLIP_03") or (comphash == "COMPONENT_ASSAULTRIFLE_CLIP_03")
			or (comphash == "COMPONENT_CARBINERIFLE_CLIP_03") or (comphash == "COMPONENT_SPECIALCARBINE_CLIP_03") or (comphash == "COMPONENT_COMPACTRIFLE_CLIP_03")) then
				compcapacity = 233
			end

			if compdamage == 4294967291 then
				compdamage = -5
				comprange = -5
			end
			compdamagetotal = compdamagetotal + compdamage
			compspeedtotal = compspeedtotal + compspeed
			compcapacitytotal = compcapacitytotal + compcapacity
			compaccuracytotal = compaccuracytotal + compaccuracy
			comprangetotal = comprangetotal + comprange
		end
	end
	local retval,damage,speed,capacity,accuracy,range = GetStats(w,0xD92C739EE34C9EBA)
	SendNUIMessage({showmenu = true, showstats = true, damage = damage, speed = speed, capacity = capacity, accuracy = accuracy, range = range,
			compdamage = damage+compdamagetotal, compspeed = speed+compspeedtotal, compcapacity = capacity+compcapacitytotal,
			compaccuracy = accuracy+compaccuracytotal, comprange = range+comprangetotal})
end

componentlist = {
	"COMPONENT_AT_PI_SUPP",
	"COMPONENT_AT_PI_SUPP_02",
	"COMPONENT_APPISTOL_CLIP_02",
	"COMPONENT_COMBATPISTOL_CLIP_02",
	"COMPONENT_HEAVYPISTOL_CLIP_02",
	"COMPONENT_PISTOL_CLIP_02",
	"COMPONENT_PISTOL50_CLIP_02",
	"COMPONENT_AT_PI_COMP",
	"COMPONENT_AT_PI_RAIL",
	"COMPONENT_PISTOL_MK2_CLIP_02",
	"COMPONENT_PISTOL_MK2_CLIP_FMJ",
	"COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT",
	"COMPONENT_PISTOL_MK2_CLIP_INCENDIARY",
	"COMPONENT_PISTOL_MK2_CLIP_TRACER",
	"COMPONENT_AT_PI_COMP_03",
	"COMPONENT_REVOLVER_MK2_CLIP_FMJ",
	"COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT",
	"COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY",
	"COMPONENT_REVOLVER_MK2_CLIP_TRACER",
	"COMPONENT_SNSPISTOL_CLIP_02",
	"COMPONENT_AT_PI_COMP_02",
	"COMPONENT_AT_PI_RAIL_02",
	"COMPONENT_SNSPISTOL_MK2_CLIP_02",
	"COMPONENT_SNSPISTOL_MK2_CLIP_FMJ",
	"COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT",
	"COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY",
	"COMPONENT_SNSPISTOL_MK2_CLIP_TRACER",
	"COMPONENT_VINTAGEPISTOL_CLIP_02",
	"COMPONENT_AT_SCOPE_MACRO",
	"COMPONENT_AT_SCOPE_MACRO_MK2",
	"COMPONENT_AT_SCOPE_MEDIUM",
	"COMPONENT_AT_SCOPE_MEDIUM_MK2",
	"COMPONENT_AT_SCOPE_SMALL",
	"COMPONENT_AT_SCOPE_SMALL_MK2",
	"COMPONENT_AT_SIGHTS",
	"COMPONENT_AT_AR_SUPP",
	"COMPONENT_AT_AR_SUPP_02",
	"COMPONENT_AT_AR_AFGRIP",
	"COMPONENT_AT_AR_AFGRIP_02",
	"COMPONENT_AT_MUZZLE_01",
	"COMPONENT_AT_MUZZLE_02",
	"COMPONENT_AT_MUZZLE_03",
	"COMPONENT_AT_MUZZLE_04",
	"COMPONENT_AT_MUZZLE_05",
	"COMPONENT_AT_MUZZLE_06",
	"COMPONENT_AT_MUZZLE_07",
	"COMPONENT_ASSAULTSMG_CLIP_02",
	"COMPONENT_COMBATMG_CLIP_02",
	"COMPONENT_COMBATMG_MK2_CLIP_02",
	"COMPONENT_COMBATMG_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_COMBATMG_MK2_CLIP_FMJ",
	"COMPONENT_COMBATMG_MK2_CLIP_INCENDIARY",
	"COMPONENT_COMBATMG_MK2_CLIP_TRACER",
	"COMPONENT_AT_MG_BARREL_02",
	"COMPONENT_COMBATPDW_CLIP_02",
	"COMPONENT_COMBATPDW_CLIP_03",
	"COMPONENT_GUSENBERG_CLIP_02",
	"COMPONENT_MACHINEPISTOL_CLIP_02",
	"COMPONENT_MACHINEPISTOL_CLIP_03",
	"COMPONENT_MG_CLIP_02",
	"COMPONENT_AT_SCOPE_SMALL_02",
	"COMPONENT_MICROSMG_CLIP_02",
	"COMPONENT_MINISMG_CLIP_02",
	"COMPONENT_SMG_CLIP_02",
	"COMPONENT_SMG_CLIP_03",
	"COMPONENT_AT_SCOPE_MACRO_02",
	"COMPONENT_SMG_MK2_CLIP_02",
	"COMPONENT_SMG_MK2_CLIP_FMJ",
	"COMPONENT_SMG_MK2_CLIP_HOLLOWPOINT",
	"COMPONENT_SMG_MK2_CLIP_INCENDIARY",
	"COMPONENT_SMG_MK2_CLIP_TRACER",
	"COMPONENT_AT_SB_BARREL_02",
	"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
	"COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
	"COMPONENT_AT_SIGHTS_SMG",
	"COMPONENT_ADVANCEDRIFLE_CLIP_02",
	"COMPONENT_ASSAULTRIFLE_CLIP_02",
	"COMPONENT_ASSAULTRIFLE_CLIP_03",
	"COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
	"COMPONENT_ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_ASSAULTRIFLE_MK2_CLIP_FMJ",
	"COMPONENT_ASSAULTRIFLE_MK2_CLIP_INCENDIARY",
	"COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER",
	"COMPONENT_AT_AR_BARREL_02",
	"COMPONENT_BULLPUPRIFLE_CLIP_02",
	"COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
	"COMPONENT_BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_BULLPUPRIFLE_MK2_CLIP_FMJ",
	"COMPONENT_BULLPUPRIFLE_MK2_CLIP_INCENDIARY",
	"COMPONENT_BULLPUPRIFLE_MK2_CLIP_TRACER",
	"COMPONENT_AT_BP_BARREL_02",
	"COMPONENT_AT_SCOPE_MACRO_02_MK2",
	"COMPONENT_CARBINERIFLE_CLIP_02",
	"COMPONENT_CARBINERIFLE_CLIP_03",
	"COMPONENT_CARBINERIFLE_MK2_CLIP_02",
	"COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ",
	"COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY",
	"COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER",
	"COMPONENT_AT_CR_BARREL_02",
	"COMPONENT_COMPACTRIFLE_CLIP_02",
	"COMPONENT_COMPACTRIFLE_CLIP_03",
	"COMPONENT_SPECIALCARBINE_CLIP_02",
	"COMPONENT_SPECIALCARBINE_CLIP_03",
	"COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
	"COMPONENT_SPECIALCARBINE_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_SPECIALCARBINE_MK2_CLIP_FMJ",
	"COMPONENT_SPECIALCARBINE_MK2_CLIP_INCENDIARY",
	"COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER",
	"COMPONENT_AT_SC_BARREL_02",
	"COMPONENT_AT_SCOPE_LARGE",
	"COMPONENT_AT_SCOPE_MAX",
	"COMPONENT_AT_MUZZLE_08",
	"COMPONENT_AT_SR_SUPP_03",
	"COMPONENT_HEAVYSNIPER_MK2_CLIP_02",
	"COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE",
	"COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ",
	"COMPONENT_HEAVYSNIPER_MK2_CLIP_INCENDIARY",
	"COMPONENT_AT_SR_BARREL_02",
	"COMPONENT_AT_SCOPE_LARGE_MK2",
	"COMPONENT_AT_SCOPE_NV",
	"COMPONENT_AT_SCOPE_THERMAL",
	"COMPONENT_AT_MUZZLE_09",
	"COMPONENT_MARKSMANRIFLE_CLIP_02",
	"COMPONENT_MARKSMANRIFLE_MK2_CLIP_02		   ",
	"COMPONENT_MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_MARKSMANRIFLE_MK2_CLIP_FMJ",
	"COMPONENT_MARKSMANRIFLE_MK2_CLIP_INCENDIARY",
	"COMPONENT_MARKSMANRIFLE_MK2_CLIP_TRACER",
	"COMPONENT_ASSAULTSHOTGUN_CLIP_02",
	"COMPONENT_HEAVYSHOTGUN_CLIP_02",
	"COMPONENT_HEAVYSHOTGUN_CLIP_03",
	"COMPONENT_AT_SR_SUPP",
	"COMPONENT_PUMPSHOTGUN_MK2_CLIP_ARMORPIERCING",
	"COMPONENT_PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE",
	"COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT",
	"COMPONENT_PUMPSHOTGUN_MK2_CLIP_INCENDIARY",
}

function GetIntFromBlob(blob,byte)
	r = 0
	for i=1,8,1 do
		r = r | (string.byte(blob,byte+i)<<(i-1)*8)
	end
	return r
end

function GetStats(hash,native)
	local blob = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	local retval = Citizen.InvokeNative(tonumber(native), tonumber(hash), blob, Citizen.ReturnResultAnyway())
	local hudDamage = GetIntFromBlob(blob,0)
	local hudSpeed = GetIntFromBlob(blob,8)
	local hudCapacity = GetIntFromBlob(blob,16)
	local hudAccuracy = GetIntFromBlob(blob,24)
	local hudRange = GetIntFromBlob(blob,32)
	return retval, hudDamage, hudSpeed, hudCapacity, hudAccuracy, hudRange
end

RegisterNUICallback('ammo', function(data)
	CreateThread(function()
		local ammo = data.weapon
		local amount = data.amount
		AddAmmoToPed(PlayerPedId(),GetHashKey(ammo),tonumber(amount))
		datatext = amount.." Of "..data.text.." Ammo Given"
		DrawTextWait()
	end)
end)

RegisterNUICallback('currentammo', function(data)
	CreateThread(function()
		local weaponhash = GetSelectedPedWeapon(ped)
		local amount = data.amount
		AddAmmoToPed(PlayerPedId(),weaponhash,tonumber(amount))
		datatext = amount.." Of Current Weapon's Ammo Given"
		DrawTextWait()
	end)
end)

RegisterNUICallback('removeallweapons', function()
	CreateThread(function()
		RemoveAllPedWeapons(ped,true)
		GiveWeaponToPed(ped,GetHashKey("weapon_unarmed"),1,0,false)
		datatext = "All Weapons Removed"
		DrawTextWait()
	end)
end)

RegisterNUICallback('removecurrentweapon', function()
	CreateThread(function()
		local retval, hash = GetCurrentPedWeapon(ped,1)
		RemoveWeaponFromPed(ped,hash)
		datatext = "Current Weapon Removed"
		DrawTextWait()
	end)
end)

RegisterNUICallback('allweapons', function()
	CreateThread(function()
		for i, weap in pairs(weapons) do
			GiveWeaponToPed(ped,GetHashKey(weap.name),1,0,true)
		end
		datatext = "All Weapons Added"
		DrawTextWait()
	end)
end)

RegisterNUICallback('maxammo', function()
	CreateThread(function()
		for i, weap in pairs(weapons) do
			SetPedAmmo(ped,GetHashKey(weap.name),1000000)
		end
		local weaponhash = GetSelectedPedWeapon(ped)
		AddAmmoToPed(ped,weaponhash,1000000)

		datatext = "Max Ammo for All Weapons"
		DrawTextWait()
	end)
end)

local infinite = 0
RegisterNUICallback('infinite', function()
	CreateThread(function()
		if infinite == 0 then
			for i, weap in pairs(weapons) do
				SetPedInfiniteAmmo(ped,true,GetHashKey(weap.name))
			end
			datatext = "Infinite Ammo Enabled"
			infinite = 1
		elseif infinite == 1 then
			for i, weap in pairs(weapons) do
				SetPedInfiniteAmmo(ped,false,GetHashKey(weap.name))
			end
			datatext = "Infinite Ammo Disabled"
			infinite = 0
		end
		DrawTextWait()
	end)
end)

local infiniteinclip = 0
RegisterNUICallback('infiniteinclip', function()
	CreateThread(function()
		if infiniteinclip == 0 then
			SetPedInfiniteAmmoClip(ped,true)
			datatext = "Infinite Ammo In Clip Enabled"
			infiniteinclip = 1
		elseif infiniteinclip == 1 then
			SetPedInfiniteAmmoClip(ped,false)
			datatext = "Infinite Ammo In Clip Disabled"
			infiniteinclip = 0
		end
		DrawTextWait()
	end)
end)

local showimpacts = false
local impacts = 0
RegisterNUICallback('showimpacts', function()
	CreateThread(function()
		if impacts == 0 then
			impactlist = {}
			impactlisti = 1
			showimpacts = true
			datatext = "Impacts Enabled"
			impacts = 1
		elseif impacts == 1 then
			showimpacts = false
			datatext = "Impacts Disabled"
			impacts = 0
		end
		DrawTextWait()
	end)
end)

local showdamagedentities = false
local damagedentities = 0
RegisterNUICallback('showdamagedentities', function()
	CreateThread(function()
		if damagedentities == 0 then
			damagedentitieslist = {}
			damagedentitieslisti = 1
			showdamagedentities = true
			datatext = "Damaged Entity Markers Enabled"
			damagedentities = 1
		elseif damagedentities == 1 then
			showdamagedentities = false
			datatext = "Damaged Entity Markers Disabled"
			damagedentities = 0
		end
		DrawTextWait()
	end)
end)

function DrawText(text,x,y)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,255)--r,g,b,a
	SetTextCentre(true)--true,false
	SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
	SetTextEdge(1, 0, 0, 0, 255)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x,y)
end

function DrawTextWait()
	toggletext = true
	Wait(1000)
	toggletext = false
end

CreateThread(function()
	while true do
		Wait(0)
		if toggletext then
			DrawText(tostring(datatext),0.5,0.96)
		end
	end
end)

function Draw3DText(text,x,y,z)
	local retval,screenX,screenY = GetScreenCoordFromWorldCoord(x,y,z)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,255)--r,g,b,a
	SetTextCentre(true)--true,false
	SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
	SetTextEdge(1, 0, 0, 0, 255)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(screenX,screenY)
end

impactlisti = 1
CreateThread(function()
	while true do
		Wait(0)
		if showimpacts then
			local retval,coords = GetPedLastWeaponImpactCoord(ped)
			if retval then
				local ix,iy,iz = table.unpack(coords)
				if not((tostring(ix) == "0.0") and (tostring(iy) == "0.0") and (tostring(iz) == "0.0")) then
					impactlist[impactlisti] = {ix,iy,iz}
					impactlisti = impactlisti+1
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if showimpacts then
			for i, hit in ipairs(impactlist) do
				Draw3DText("O",hit[1],hit[2],hit[3])
			end
		end
	end
end)

damagedentitieslisti = 1
CreateThread(function()
	while true do
		Wait(0)
		if showdamagedentities and IsPedShooting(ped) then
			local entityhit, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
			if damagedentitieslist[entity] then
			else
				damagedentitieslist[entity] = {["id"]=entity}
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(0)
		if showdamagedentities then
			for i, hit in pairs(damagedentitieslist) do
				local hx,hy,hz = table.unpack(GetEntityCoords(hit.id))
				if not((hx == 0.0)and(hy == 0.0)and(hz == 0.0)) then
					Draw3DText("X",hx,hy,hz)
				end
			end
		end
	end
end)