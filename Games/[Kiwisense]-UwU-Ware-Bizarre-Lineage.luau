local Library = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/sametexe001/sametlibs/refs/heads/main/Kiwisense/Library.lua")
)()

--
-- Example
local LoadingTick = os.clock()
local rgb = Color3.fromRGB
local Options, MiscOptions

MiscOptions = {
	["Enabled"] = false,

	-- Boxes
	["Boxes"] = false,
	["BoxType"] = "Corner",
	["Box Gradient 1"] = { Color = rgb(0, 255, 255), Transparency = 0.9 },
	["Box Gradient 2"] = { Color = rgb(255, 0, 0), Transparency = 0.4 },
	["Box Gradient Rotation"] = 90,
	["Box Fill"] = false,
	["Box Fill 1"] = { Color = rgb(0, 255, 255), Transparency = 0.9 },
	["Box Fill 2"] = { Color = rgb(0, 255, 255), Transparency = 0.9 },
	["Box Fill Rotation"] = 0,

	["Healthbar"] = false,
	["Healthbar_Position"] = "Left",
	["Healthbar_Number"] = false,
	["Healthbar_Low"] = { Color = rgb(255, 0, 0), Transparency = 1 },
	["Healthbar_Medium"] = { Color = rgb(255, 255, 0), Transparency = 1 },
	["Healthbar_Animations"] = false,
	["Healthbar_High"] = { Color = rgb(0, 255, 0), Transparency = 1 },
	["Healthbar_Font"] = "Verdana",
	["Healthbar_Text_Size"] = 11,
	["Healthbar_Thickness"] = 1,
	["Healthbar_Tween"] = false,
	["Healthbar_EasingStyle"] = "Circular",
	["Healthbar_EasingDirection"] = "InOut",
	["Healthbar_Easing_Speed"] = 1,

	-- Text Based Elements
	["Name_Text"] = false,
	["Name_Text_Color"] = { Color = rgb(255, 255, 255) },
	["Name_Text_Position"] = "Top",
	["Name_Text_Font"] = "Verdana",
	["Name_Text_Size"] = 11,

	["Distance_Text"] = false,
	["Distance_Text_Color"] = { Color = rgb(255, 255, 255) },
	["Distance_Text_Position"] = "Bottom",
	["Distance_Text_Font"] = "Verdana",
	["Distance_Text_Size"] = 11,
}

Options = setmetatable({}, {
	__index = MiscOptions,
	__newindex = function(self, key, value) end,
})

getgenv().Options = {}

--//Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Http = game:GetService("HttpService")

--//Variables
local plr = Players.LocalPlayer
local character
local humanoid
local hrp

do
	local Window = Library:Window({
		Name = "UwU-Ware",
		Version = "v1.0",
		Logo = "135215559087473",
		FadeSpeed = 0.25,
		--Size = UDim2.new(0, 659, 0, 511)
	})

	local Watermark = Library:Watermark("UwU", "135215559087473")
	Watermark:SetVisibility(false)
	local KeybindList = Library:KeybindsList()
	KeybindList:SetVisibility(false)

	do
		local Pages = {
			["Main"] = Window:Page({
				Name = "Main",
				Icon = "111178525804834",
				SubPages = true,
				Columns = 1,
			}),

			["Misc"] = Window:Page({
				Name = "misc",
				Icon = "136623465713368",
				Columns = 2,
			}),

			["Movement"] = Window:Page({
				Name = "movement",
				Icon = "109463522861706",
				Columns = 2,
			}),

			["Settings"] = Window:Page({
				Name = "settings",
				Icon = "137300573942266",
				Columns = 2,
				SubPages = true,
			}),
		}

		do -- Misc
			local Playerlist = Pages["Misc"]:Playerlist({
				Callback = function(...)
					local Args = { ... }
					table.foreach(Args, print)
				end,
			})
		end

		do -- Main
			local Subpages = {
				["Farms"] = Pages["Main"]:SubPage({
					Name = "Farms",
					Icon = "111386589037485",
					Columns = 2,
				}),
				["Items"] = Pages["Main"]:SubPage({
					Name = "Items",
					Icon = "126028986879491",
					Columns = 2,
				}),
			}

			do
				local FarmsSection = Subpages["Farms"]:Section({ Name = "Farms", Icon = "103174889897193", Side = 1 })
				local FarmSettingsSection =
					Subpages["Farms"]:Section({ Name = "Farm Settings", Icon = "103174889897193", Side = 2 })
				do
					local trackedQuest = ""
					trackedQuest = plr.PlayerData.SlotData.TrackedQuest.Value
					FarmsSection:Label("Tracked Quest: " .. trackedQuest, "Left")
					FarmsSection:Toggle({
						Name = "Auto Tracked Quest",
						Flag = "autoTrackedQuest",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmsSection:Toggle({
						Name = "Auto PvE Board",
						Flag = "autoPvEBoard",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmsSection:Toggle({
						Name = "Auto Gang Contracts",
						Flag = "autoGangContracts",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmsSection:Toggle({
						Name = "Auto World Event",
						Flag = "autoWorldEvent",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmsSection:Dropdown({
						Name = "Select Enemies: ",
						Flag = "attackDropdown",
						Items = { "Cultist", "Corrupted Cop", "Zombie" },
						Default = "",
						MaxSize = 155,
						Multi = true,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmsSection:Toggle({
						Name = "Auto Farm Selected Enemy",
						Flag = "autoSelectedEnemy",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
				end
				do
					FarmSettingsSection:Dropdown({
						Name = "Attack From",
						Flag = "AttackDropdown",
						Items = { "Above", "Below", "Left", "Right" },
						Default = "Below",
						MaxSize = 155,
						Multi = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmSettingsSection:Slider({
						Name = "Farm Distance",
						Flag = "farmDistanceSlider",
						Min = 0,
						Default = 8,
						Max = 20,
						Suffix = " studs",
						Decimals = 1,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmSettingsSection:Toggle({
						Name = "Auto M1",
						Flag = "autoM1",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmSettingsSection:Toggle({
						Name = "Auto M2",
						Flag = "autoM2",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmSettingsSection:Dropdown({
						Name = "Use Skills: ",
						Flag = "attackDropdown",
						Items = { "E", "R", "Z", "X", "C", "V" },
						Default = "",
						MaxSize = 155,
						Multi = true,
						Callback = function(Value)
							print(Value)
						end,
					})
					FarmSettingsSection:Toggle({
						Name = "Auto Skills",
						Flag = "autoSkills",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
				end
			end

			do
				local ItemsSection = Subpages["Items"]:Section({ Name = "Items", Icon = "103174889897193", Side = 1 })
				local ItemSettingsSection =
					Subpages["Items"]:Section({ Name = "Item Settings", Icon = "103174889897193", Side = 2 })
				do
					ItemsSection:Toggle({
						Name = "Auto Stand Arrow",
						Flag = "autoStandArrow",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					ItemsSection:Toggle({
						Name = "Auto Sell",
						Flag = "autoSell",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					ItemsSection:Toggle({
						Name = "Auto Open Chests",
						Flag = "autoOpenChests",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
					ItemsSection:Toggle({
						Name = "Auto Grab Items",
						Flag = "autoGrabItems",
						Default = false,
						Callback = function(Value)
							print(Value)
						end,
					})
				end
				do
					local StandsList = {}
					local selectedStands = {}
					for _, stand in ReplicatedStorage.assets.models.stands:GetChildren() do
						if stand.Name ~= "Skins" then
							table.insert(StandsList, stand.Name)
						end
					end
					ItemSettingsSection:Dropdown({
						Name = "Stands List: ",
						Flag = "standsDropdown",
						Items = StandsList,
						Default = {
							"Star Platinum",
							"The World, High Voltage",
							"The World Over Heaven",
							"Made In Heaven",
							"The World",
							"C-Moon",
							"Whitesnake",
							"Star Platinum, The World",
							"King Crimson",
						},
						MaxSize = 155,
						Multi = true,
						Callback = function(selected)
							selectedStands = selected
						end,
					})
					ItemSettingsSection:Dropdown({
						Name = "Sell List: ",
						Flag = "sellDropdown",
						Items = {},
						Default = "",
						MaxSize = 155,
						Multi = true,
						Callback = function(selected) end,
					})
					ItemSettingsSection:Dropdown({
						Name = "Item List: ",
						Flag = "itemDropdown",
						Items = {},
						Default = "",
						MaxSize = 155,
						Multi = true,
						Callback = function(selected) end,
					})
				end
			end
		end

		do -- Settings
			local Subpages = {
				["Configs"] = Pages["Settings"]:SubPage({
					Name = "configs",
					Icon = "96491224522405",
					Columns = 2,
				}),

				["Theming"] = Pages["Settings"]:SubPage({
					Name = "theming",
					Icon = "103863157706913",
					Columns = 2,
				}),

				["Configuration"] = Pages["Settings"]:SubPage({
					Name = "configuration",
					Icon = "137300573942266",
					Columns = 2,
				}),
			}

			do -- Theming
				local ThemingSection =
					Subpages["Theming"]:Section({ Name = "theming", Icon = "103863157706913", Side = 1 })
				local ThemingProfiles =
					Subpages["Theming"]:Section({ Name = "profiles", Icon = "96491224522405", Side = 2 })
				local AutoloadSection =
					Subpages["Theming"]:Section({ Name = "autoload", Icon = "137623872962804", Side = 2 })

				for Index, Value in Library.Theme do
					Library.ThemeColorpickers[Index] = ThemingSection:Label(Index, "Left"):Colorpicker({
						Name = "Colorpicker",
						Flag = "ColorpickerTheme" .. Index,
						Default = Value,
						Alpha = 0,
						Callback = function(Color, Alpha)
							Library.Theme[Index] = Color
							Library:ChangeTheme(Index, Color)
						end,
					})
				end

				ThemingProfiles:Dropdown({
					Name = "preset themes",
					Items = { "Preset", "Halloween", "Aqua", "One Tap" },
					Default = "Preset",
					Multi = false,
					Callback = function(Value)
						local ThemeData = Library.Themes[Value]

						if not ThemeData then
							return
						end

						for Index, Value in Library.Theme do
							Library.Theme[Index] = ThemeData[Index]
							Library:ChangeTheme(Index, ThemeData[Index])

							Library.ThemeColorpickers[Index]:Set(ThemeData[Index])
						end

						task.wait(0.3)

						Library:Thread(function() -- i do this because sometimes the themes dont update
							for Index, Value in Library.Theme do
								Library.Theme[Index] = Library.Flags["ColorpickerTheme" .. Index].Color
								Library:ChangeTheme(Index, Library.Flags["ColorpickerTheme" .. Index].Color)
							end
						end)
					end,
				})

				local ThemeSelected
				local ThemeName

				do
					local ThemesDropdown = ThemingProfiles:Dropdown({
						Name = "themes",
						Flag = "ThemesList",
						Items = {},
						Multi = false,
						Callback = function(Value)
							ThemeSelected = Value
						end,
					})

					ThemingProfiles:Textbox({
						Name = "theme name",
						Default = "",
						Flag = "ThemeName",
						Placeholder = "enter text",
						Callback = function(Value)
							ThemeName = Value
						end,
					})

					ThemingProfiles:Button({
						Name = "save",
						Callback = function()
							if ThemeName and ThemeName ~= "" then
								writefile(Library.Folders.Themes .. "/" .. ThemeName .. ".json", Library:GetTheme())
								Library:RefreshThemesList(ThemesDropdown)
							end
						end,
					})

					ThemingProfiles:Button({
						Name = "load",
						Callback = function()
							if ThemeSelected then
								local Success, Result =
									Library:LoadTheme(readfile(Library.Folders.Themes .. "/" .. ThemeSelected))

								if Success then
									Library:Notification({
										Name = "Success",
										Description = "Succesfully loaded theme: " .. ThemeSelected,
										Duration = 5,
										Icon = "116339777575852",
										IconColor = Color3.fromRGB(52, 255, 164),
									})

									task.wait(0.3)

									Library:Thread(function() -- i do this because sometimes the themes dont update
										for Index, Value in Library.Theme do
											Library.Theme[Index] = Library.Flags["ColorpickerTheme" .. Index].Color
											Library:ChangeTheme(Index, Library.Flags["ColorpickerTheme" .. Index].Color)
										end
									end)
								else
									Library:Notification({
										Name = "Error!",
										Description = "Failed to load theme, error:\n",
										Duration = 5,
										Icon = "97118059177470",
										IconColor = Color3.fromRGB(255, 120, 120),
									})
								end
							end
						end,
					})

					AutoloadSection:Button({
						Name = "set selected theme as autoload",
						Callback = function()
							if ThemeSelected then
								writefile(
									Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json",
									readfile(Library.Folders.Themes .. "/" .. ThemeSelected)
								)
							end
						end,
					})

					AutoloadSection:Button({
						Name = "set current theme as autoload",
						Callback = function()
							if ThemeSelected then
								writefile(
									Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json",
									Library:GetTheme()
								)
							end
						end,
					})

					AutoloadSection:Button({
						Name = "remove autoload theme",
						Callback = function()
							writefile(Library.Folders.Directory .. "/AutoLoadTheme (do not modify this).json", "")
						end,
					})

					Library:RefreshThemesList(ThemesDropdown)
				end
			end

			do -- Configs
				local ConfigsSection =
					Subpages["Configs"]:Section({ Name = "profiles", Icon = "96491224522405", Side = 1 })
				local AutoloadSection =
					Subpages["Configs"]:Section({ Name = "autoload", Icon = "137623872962804", Side = 2 })

				local ConfigSelected
				local ConfigName

				do
					local ConfigsDropdown = ConfigsSection:Dropdown({
						Name = "configs",
						Flag = "ConfigsList",
						Items = {},
						Multi = false,
						Callback = function(Value)
							ConfigSelected = Value
						end,
					})

					ConfigsSection:Textbox({
						Name = "config name",
						Default = "",
						Flag = "ConfigName",
						Placeholder = "enter text",
						Callback = function(Value)
							ConfigName = Value
						end,
					})

					ConfigsSection:Button({
						Name = "create",
						Callback = function()
							if ConfigName and ConfigName ~= "" then
								writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
								Library:RefreshConfigsList(ConfigsDropdown)
							end
						end,
					})

					ConfigsSection:Button({
						Name = "delete",
						Callback = function()
							if ConfigSelected then
								Library:DeleteConfig(ConfigSelected)
								Library:RefreshConfigsList(ConfigsDropdown)
							end
						end,
					})

					ConfigsSection:Button({
						Name = "load",
						Callback = function()
							if ConfigSelected then
								local Success, Result =
									Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected))

								if Success then
									Library:Notification({
										Name = "Success",
										Description = "Succesfully loaded config: " .. ConfigSelected,
										Duration = 5,
										Icon = "116339777575852",
										IconColor = Color3.fromRGB(52, 255, 164),
									})

									task.wait(0.3)

									Library:Thread(function() -- i do this because sometimes the themes dont update
										for Index, Value in Library.Theme do
											Library.Theme[Index] = Library.Flags["ColorpickerTheme" .. Index].Color
											Library:ChangeTheme(Index, Library.Flags["ColorpickerTheme" .. Index].Color)
										end
									end)
								else
									Library:Notification({
										Name = "Error!",
										Description = "Failed to load config, error:\n",
										Duration = 5,
										Icon = "97118059177470",
										IconColor = Color3.fromRGB(255, 120, 120),
									})
								end
							end
						end,
					})

					ConfigsSection:Button({
						Name = "save",
						Callback = function()
							if ConfigSelected then
								Library:SaveConfig(ConfigSelected)
							end
						end,
					})

					ConfigsSection:Button({
						Name = "refresh list",
						Callback = function()
							Library:RefreshConfigsList(ConfigsDropdown)
						end,
					})

					Library:RefreshConfigsList(ConfigsDropdown)
				end

				do
					AutoloadSection:Button({
						Name = "set selected config as autoload",
						Callback = function()
							if ConfigSelected then
								writefile(
									Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json",
									readfile(Library.Folders.Configs .. "/" .. ConfigSelected)
								)
							end
						end,
					})

					AutoloadSection:Button({
						Name = "set current config as autoload",
						Callback = function()
							if ConfigSelected then
								writefile(
									Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json",
									Library:GetConfig()
								)
							end
						end,
					})

					AutoloadSection:Button({
						Name = "remove autoload config",
						Callback = function()
							writefile(Library.Folders.Directory .. "/AutoLoadConfig (do not modify this).json", "")
						end,
					})
				end
			end

			do -- Configuration
				local MenuSection =
					Subpages["Configuration"]:Section({ Name = "menu", Icon = "93007870315593", Side = 1 })
				local TweeningSection =
					Subpages["Configuration"]:Section({ Name = "tweening", Icon = "130045183204879", Side = 2 })

				do
					MenuSection:Label("menu keybind", "Left"):Keybind({
						Name = "MenuKeybind",
						Flag = "MenuKeybind",
						Mode = "toggle",
						Default = Library.MenuKeybind,
						Callback = function()
							Library.MenuKeybind = Library.Flags["MenuKeybind"].Key
						end,
					})

					MenuSection:Toggle({
						Name = "keybind list",
						Flag = "keybind list",
						Default = false,
						Callback = function(Value)
							KeybindList:SetVisibility(Value)
						end,
					})

					MenuSection:Toggle({
						Name = "watermark",
						Flag = "watermark",
						Default = false,
						Callback = function(Value)
							Watermark:SetVisibility(Value)
						end,
					})

					MenuSection:Button({
						Name = "unload",
						Callback = function()
							Library:Unload()
						end,
					})
				end

				do
					TweeningSection:Slider({
						Name = "time",
						Flag = "TweenTime",
						Default = Library.Tween.Time,
						Min = 0,
						Max = 5,
						Decimals = 0.01,
						Callback = function(Value)
							Library.Tween.Time = Value
						end,
					})

					TweeningSection:Dropdown({
						Name = "style",
						Flag = "TweenStyle",
						Default = "Cubic",
						Items = {
							"Linear",
							"Sine",
							"Quad",
							"Cubic",
							"Quart",
							"Quint",
							"Exponential",
							"Circular",
							"Back",
							"Elastic",
							"Bounce",
						},
						MaxSize = 150,
						Callback = function(Value)
							Library.Tween.Style = Enum.EasingStyle[Value]
						end,
					})

					TweeningSection:Dropdown({
						Name = "direction",
						Flag = "TweenDirection",
						MaxSize = 55,
						Default = "Out",
						Items = { "In", "Out", "InOut" },
						Callback = function(Value)
							Library.Tween.Direction = Enum.EasingDirection[Value]
						end,
					})
				end
			end
		end
	end
end

Library:Notification({
	Name = "Loaded",
	Description = "Loaded library in: " .. string.format("%.4f", os.clock() - LoadingTick) .. " seconds",
	Duration = 5,
})

Library:Init() -- put this at the end of ur script or the autoload will not work
--
