if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "smgMag"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Vityaz-SN"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.AimBreathingEnabled = true
	SWEP.Shell = "KK_INS2_9x19"

	SWEP.ShellViewAngleAlign = {Forward = 0, Right = 0, Up = 180}
	SWEP.ShellWorldAngleAlign = {Forward = 0, Right = 0, Up = 180}

	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_05.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_suppressor_pistol"] = {model = "models/weapons/upgrades/a_suppressor_pistol.mdl", pos = Vector(), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x_m.mdl", rLight = true, pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint_m.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", bone = "Weapon", rLight = true, pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech_m.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false},
		["cw_sil_pso1_scope"] = {model = "models/silver/stalker/weapons/attachments/a_pso2_scope.mdl", bone = "Weapon", rLight = true, pos = Vector(0, -3, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false},
		["cw_sil_ip29_scope"] = {model = "models/silver/stalker/weapons/attachments/a_ip29_scope.mdl", bone = "Weapon", rLight = true, pos = Vector(0, -3, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false},
		["cw_sil_okp7_optic"] = {model = "models/silver/stalker/weapons/attachments/a_okp7_optic.mdl", bone = "Weapon", pos = Vector(0, -0.5, 1.2), angle = Angle(0, -90, 0), size = Vector(1.3, 1.3, 1.3), merge = false},
		["cw_sil_ekp_optic"] = {model = "models/silver/stalker/weapons/attachments/a_ekp_optic.mdl", bone = "Weapon", pos = Vector(0, -0.5, 2.3), angle = Angle(0, -90, 0), size = Vector(1.3, 1.3, 1.3), merge = false},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore_m.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s_m.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1_m.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", bone = "Weapon", rLight = true, pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska_m.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps_m.mdl", bone = "Weapon", pos = Vector(0, 0, 1.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), merge = false, retSizeMult = 0.85},

	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_5.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_suppressor_pistol"] = {model = "models/weapons/upgrades/w_sil_pistol.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(4,1,-11), angle = Angle(0,180,0), size = Vector(1, 1, 1), attachment = "laser"},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(4,1,-11), angle = Angle(0,180,0), size = Vector(1, 1, 1), attachment = "laser"},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", bone = "optic", pos = Vector(-52, 11, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", bone = "optic", pos = Vector(-56, 10.5, 0), angle = Angle(0, 0, -90), size = Vector(0.9, 0.9, 0.9), merge = false},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", bone = "optic", pos = Vector(-10, 15.5, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", bone = "optic", pos = Vector(-43, 19.5, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["cw_sil_pso1_scope"] = {model = "models/silver/stalker/weapons/attachments/w_pso2_scope.mdl", bone = "optic", pos = Vector(-73, -5.2, -11.8), angle = Angle(0, 0, 20), size = Vector(1, 1, 1), merge = false},
		["cw_sil_ip29_scope"] = {model = "models/silver/stalker/weapons/attachments/w_ip29_scope.mdl", bone = "optic", pos = Vector(-62.5, 0.3, -6.8), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), merge = false},
		["cw_sil_okp7_optic"] = {model = "models/silver/stalker/weapons/attachments/w_okp7_optic.mdl", bone = "optic", pos = Vector(-54, 25.5, 0), angle = Angle(0, 0, -90), size = Vector(1.3, 1.3, 1.3), merge = false},
		["cw_sil_ekp_optic"] = {model = "models/silver/stalker/weapons/attachments/w_ekp_optic.mdl", bone = "optic", pos = Vector(-54, 25.5, 0), angle = Angle(0, 0, -90), size = Vector(1.3, 1.3, 1.3), merge = false},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", bone = "optic", pos = Vector(-42, 19.2, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", bone = "optic", pos = Vector(-52, 11, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", bone = "optic", pos = Vector(-52, 11, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", bone = "optic", pos = Vector(-62, 11, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", bone = "optic", pos = Vector(-9, 15.5, 0), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), merge = false},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", bone = "optic", pos = Vector(-9, 0, -34.5), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), merge = false},
	}

	SWEP.IronsightPos = Vector(-2.998, -2, 1.45)
	SWEP.IronsightAng = Vector(0.02, 0, 0)

	SWEP.KKINS2KobraPos = Vector(-2.970, -1, 0.7)
	SWEP.KKINS2KobraAng = Vector()

	SWEP.KKINS2EoTechPos = Vector(-2.970, -1, 0.7)
	SWEP.KKINS2EoTechAng = Vector()

	SWEP.KKINS2AimpointPos = Vector(-2.970, -1, 0.7)
	SWEP.KKINS2AimpointAng = Vector()

	SWEP.KKINS2ElcanPos = Vector(-2.997, -4, 0.46)
	SWEP.KKINS2ElcanAng = Vector()

	SWEP.CWSILPSO1Pos = Vector(-2.9502, -0.5, 0.826)
	SWEP.CWSILPSO1Ang = Vector(0, 0, 0)
	
	SWEP.CWSILIP29Pos = Vector(-3.0502, -0.5, 0.126)
	SWEP.CWSILIP29Ang = Vector(0, 0, 0)
	
	SWEP.CWSILOKP7Pos = Vector(-2.9502, 0.5, 0.766)
	SWEP.CWSILOKP7Ang = Vector(0, 0, 0)
	
	SWEP.CWSILEKPPos = Vector(-2.9502, 1, -0.286)
	SWEP.CWSILEKPAng = Vector(0, 0, 0)

	SWEP.KKINS2MagnifierPos = Vector(-2.970, -13, 0.7)
	SWEP.KKINS2MagnifierAng = Vector()

	SWEP.KKINS2CSTMCMorePos = Vector(-2.970, -2, 0.7)
	SWEP.KKINS2CSTMCMoreAng = Vector()

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.970, -1, 0.66)
	SWEP.KKINS2CSTMBarskaAng = Vector()

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.990, -1, 0.72)
	SWEP.KKINS2CSTMMicroT1Ang = Vector()

	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.970, -1, 0.78)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector()

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.990, -1, 0.72)
	SWEP.KKINS2CSTMCompM4SAng = Vector()

	SWEP.KKINS2CSTMACOGPos = Vector(-2.998, -2, 0.46)
	SWEP.KKINS2CSTMACOGAng = Vector()

	SWEP.CustomizationMenuScale = 0.010
end

SWEP.MuzzleEffect = "muzzleflash_mp5_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_mp5_3rd"

SWEP.WeaponLength = 16

SWEP.Attachments = {
	{header = "Sight", offset = {300, -700}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "cw_sil_ip29_scope", "cw_sil_pso1_scope", "cw_sil_okp7_optic", "cw_sil_ekp_optic", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {-300, -700}, atts = {"kk_ins2_suppressor_pistol"}},
	{header = "Lasers", offset = {-500, -200}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {800, -200}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	["+use"] = {header = "Sight Contract", offset = {300, -200}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {0, 300}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire","iron_fire_a","iron_fire_b","iron_fire_c","iron_fire_d","iron_fire_e","iron_fire_f"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "Silver's SWEPs - SMGs"

SWEP.Author			= "Silver"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/silver/stalker/weapons/v_vityaz.mdl"
SWEP.WorldModel		= "models/silver/stalker/weapons/w_vityaz.mdl"

SWEP.WMPos = Vector(4.871, 1.467, -1.544)
SWEP.WMAng = Vector(-10, 0, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay = 60/700
SWEP.FireSound = "CW_KK_INS2_MP5K_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_MP5K_FIRE_SUPPRESSED"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.0153
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 17

SWEP.FirstDeployTime = 1.2
SWEP.DeployTime = 0.6
SWEP.HolsterTime = 0.5

SWEP.MuzzleVelocity = 380

SWEP.ReloadTimes = {
	base_reload = {2.43, 3.1},
	base_reloadempty = {3.27, 4.45},
}