--//Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Http = game:GetService("HttpService")

--//
local plr = Players.LocalPlayer
local character
local humanoid
local hrp

--// FUNCTIONS \\--
function Teleport(ChosenCFrame)
	if typeof(ChosenCFrame) == "Instance" and ChosenCFrame:IsA("Model") then
		if ChosenCFrame.PrimaryPart then
			ChosenCFrame = ChosenCFrame.PrimaryPart.CFrame
		else
			ChosenCFrame = ChosenCFrame:FindFirstAncestorOfClass("Part")
		end
	elseif typeof(ChosenCFrame) == "Instance" and ChosenCFrame:IsA("BasePart") then
		ChosenCFrame = ChosenCFrame.CFrame
	end
	HRP.CFrame = ChosenCFrame
end

--// LIBRARY \\--
local library = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/zanerBRUH/UwU-Ware/refs/heads/main/Libraries/Millenium.lua")
)()
local window = library:window({ name = "UwU", suffix = "-Ware", gameInfo = "Roblox: Bizarre Lineage" })

--// GENERAL \\--
window:seperator({ name = "General" })
local farmsTab, itemsTab = window:tab({ name = "Main", tabs = { "Farms", "Items" } })

--	//Farms
do
	local farmColumn = farmsTab:column({})
	local farmSection = farmColumn:section({ name = "Farms", default = true, toggle = false })
	farmSection:label({ name = "UwU, nuzzly farms :3", info = "UwU, nuzzly farms :3" })

	local page = farmsTab:sub_tab({ order = -10000, size = 3 }) -- -1 sets it to the top
	--		//Missions
	do
		local column = page:column({})
		local section = column:section({ name = "General", default = true })
		section:toggle({
			name = "Auto Tracked Quest",
			seperator = false,
			callback = function(bool)
				print(bool)
			end,
		})
		section:button({
			name = "TP to Quest",
			seperator = true,
			callback = function()
				Teleport(workspace.Effects.questbrick.questbrick.CFrame * CFrame.new(0, 0, 5))
			end,
		})
		section:toggle({
			name = "Auto PvE Board",
			seperator = true,
			callback = function(bool)
				print(bool)
			end,
		})
		section:toggle({
			name = "Auto Gang Contracts",
			seperator = true,
			callback = function(bool)
				print(bool)
			end,
		})
		section:toggle({
			name = "Auto World Event",
			seperator = true,
			callback = function(bool)
				print(bool)
			end,
		})
		local farmEnemyToggle = section:toggle({
			name = "Auto Farm Enemy",
			seperator = true,
			callback = function(bool)
				print(bool)
			end,
		})
		local FETSS = farmEnemyToggle:settings({})
		FETSS:list({
			name = "Enemies",
			items = { "1", "2", "3" },
			default = "N/A",
			seperator = true,
		})
		-- section:toggle({ name = "Through walls", seperator = true })
		-- local toggle = section:toggle({ name = "Shared ESP", seperator = true }):colorpicker({})

		-- -- Sub Section Example
		-- local toggle = section:toggle({ name = "Name", seperator = true })
		-- toggle:colorpicker({})
		-- local sub_section = toggle:settings({})
		-- sub_section:toggle({ name = "Show Display Names", seperator = true })
		-- sub_section:dropdown({
		-- 	name = "Font Name",
		-- 	items = { "ProggyTiny", "MonoSpace", "Tahoma" },
		-- 	default = "MonoSpace",
		-- 	seperator = true,
		-- })
		-- sub_section:colorpicker({ name = "Another Colorpicker why not", seperator = true })
		-- sub_section:keybind({
		-- 	name = "Keybind",
		-- 	callback = function(bool)
		-- 		print(bool)
		-- 	end,
		-- 	info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig",
		-- })
		-- --

		-- section
		-- 	:toggle({
		-- 		name = "Weapon",
		-- 		seperator = true,
		-- 		info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig",
		-- 	})
		-- 	:colorpicker({})
		-- section:dropdown({
		-- 	name = "Flags",
		-- 	items = { "Scoped", "Flashed", "Knocked", "Touched" },
		-- 	default = { "Scoped", "Flashed", "Knocked" },
		-- 	multi = true,
		-- 	seperator = true,
		-- })
		-- section:toggle({ name = "Other Shit", seperator = false }):colorpicker({})
	end
end

-- OLD DOCUMENTATION
-- for i = 1, 5 do
--     window:seperator({name = "General"})
--     local enemies, teammates, self_section = window:tab({name = "Players", tabs = {"Enemies", "Teammates", "Self"}})

--     for _, v in {enemies, teammates, self_section} do
--         for s, side in {"left", "right", ""} do
--             local column = v:column({})
--             local section = column:section({name = "General", size = 0.3, default = true})
--             section:toggle({name = "Enable ESP", seperator = true, callback = function(bool) print(bool) end})
--             section:toggle({name = "Through walls", seperator = true})
--             local toggle = section:toggle({name = "Shared ESP", seperator = true}):colorpicker({})

--             -- Sub Section Example
--                 local toggle = section:toggle({name = "Name", seperator = true})
--                 toggle:colorpicker({})
--                 local sub_section = toggle:settings({})
--                 sub_section:toggle({name = "Show Display Names", seperator = true})
--                 sub_section:dropdown({name = "Font Name", items = {"ProggyTiny", "MonoSpace", "Tahoma"}, default = "MonoSpace", seperator = true})
--                 sub_section:colorpicker({name = "Another Colorpicker why not", seperator = true})
--                 sub_section:keybind({name = "Keybind", callback = function(bool) print(bool) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             --

--             section:toggle({name = "Weapon", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})
--             section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true})
--             section:toggle({name = "Other Shit", seperator = false}):colorpicker({})

--             local section = column:section({name = "General", size = 0.3, default = true})
--             section:toggle({name = "Enable ESP", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             section:toggle({name = "Through walls", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             local toggle = section:toggle({name = "Shared ESP", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})

--             local section = column:section({name = "General", size = 0.4, default = true})
--             section:toggle({name = "Enable ESP", seperator = true, info = "Hello!!!!!"})
--             section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true, info = "Hello!!!!!"})
--             section:slider({name = "Slider", info = "This is extra info.", min = 0, max = 50, interval = 0.5, callback = function(int) print(int) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             section:label({name = "This is a title!", info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--         end
--     end
-- end

library:init_config(window)
