print("Library Loading Started")
local LoadingTick = os.clock()
local Library = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/zanerBRUH/UwU-Ware/refs/heads/main/Libraries/Kiwisense.lua")
)()

function missing(t, f, fallback)
	if type(f) == t then
		return f
	end
	return fallback
end

queueteleport =
	missing("function", queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport))

--
--
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
local HttpService = game:GetService("HttpService")

--//Variables
local plr = Players.LocalPlayer
if plr:GetAttribute("Loaded") == false or plr:GetAttribute("Loaded") == nil then
	repeat
		task.wait()

		ReplicatedStorage:WaitForChild("requests"):WaitForChild("character"):WaitForChild("spawn"):FireServer()
		if plr.PlayerGui:FindFirstChild("Logo_Loader") then
			plr.Playergui.Logo_Loader:Destroy()
		end
		if plr.PlayerGui:FindFirstChild("Main Menu") then
			plr.PlayerGui["Main Menu"]:Destroy()
		end
	until plr:GetAttribute("Loaded") == true
		and not plr.PlayerGui:FindFirstChild("Logo_Loader")
		and not plr.PlayerGui:FindFirstChild("Main Menu")
end

local playerData = plr.PlayerData
local slotData = playerData.SlotData

local character = plr.Character or plr.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local connections = {}
local StandsList = {}
local selectedStands = {}
local standData = HttpService:JSONDecode(slotData.Stand.Value)
local skin = standData.Skin or "Default"

function Teleport(ChosenCFrame)
	if typeof(ChosenCFrame) == "Instance" and ChosenCFrame:IsA("Model") then
		if ChosenCFrame.PrimaryPart then
			ChosenCFrame = ChosenCFrame.PrimaryPart.CFrame
		else
			ChosenCFrame = ChosenCFrame:FindFirstChildOfClass("BasePart").CFrame
		end
	elseif typeof(ChosenCFrame) == "Instance" and ChosenCFrame:IsA("BasePart") then
		ChosenCFrame = ChosenCFrame.CFrame
	end
	hrp.CFrame = ChosenCFrame
end

function GetAttribute(obj, name)
	return obj:GetAttribute(name)
end

function find(obj, name)
	if typeof(obj) == "Instance" and obj:FindFirstChild(name) then
		return true
	elseif typeof(obj) == "string" and string.find(obj, name) then
		return true
	end
	return false
end

function wait(params)
	for _, v in params do
		if typeof(v) == "Instance" then
			params.obj = v
		elseif typeof(v) == "string" then
			params.name = v
		elseif typeof(v) == "number" then
			params.time = v
		end
	end

	params.time = params.time or 0.01
	if params.obj and params.name then
		return params.obj:WaitForChild(params.name, params.time)
	else
		return task.wait(params.time)
	end
end

function farming()
	if Library.Flags.autoTrackedQuest == true then
		return true
	elseif Library.Flags.autoPvEBoard == true then
		return true
	elseif Library.Flags.autoGangContracts == true then
		return true
	elseif Library.Flags.autoWorldEvent == true then
		return true
	elseif Library.Flags.autoSelectedEnemy == true then
		return true
	end

	return false
end

function getEnemyLocation(name)
	print(name)
	local locationsList = {
		["Cultist"] = CFrame.new(2429, 922, 874),
		["Cultist Leaders"] = CFrame.new(2444, 910, 1457),
		["Elite Mafia Member"] = CFrame.new(-1457, 910, 543),
		["Elite Vampire"] = CFrame.new(2227, 909, 1437),
		["Hamon Apprentice"] = CFrame.new(1324, 909, 1253),
		["Hamon Master"] = CFrame.new(1324, 909, 1253),
		["Mafia Member"] = CFrame.new(-1457, 910, 543),
		["Night Vampire"] = CFrame.new(1287, 875, -527),
		["Spin User"] = CFrame.new(1641, 940, 1470),
		["The Self"] = CFrame.new(1076, 14080, -98),
		["Vampire"] = CFrame.new(2227, 909, 1437),
		-- ["Vampire Cyborg"] = CFrame.new(),
		["Zombie"] = CFrame.new(2429, 922, 874),
		["Zombie Cyborg"] = CFrame.new(1757, 940, 1889),
		["Zombie Grunt"] = CFrame.new(1757, 940, 1889),
	}
	if locationsList[name] then
		return locationsList[name]
	end
	return
end

function autoFarmEnemy(enemy)
	character = plr.Character or plr.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")
	hrp = character:WaitForChild("HumanoidRootPart")

	while enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and humanoid.Health > 0 do
		task.wait()

		if getgenv().autoFarmOverride == true then
			getgenv().autoFarmOverride = false
			return
		end
		if farming() == false then
			return
		end

		if character:FindFirstChild("Highlight") and character.Highlight.FillTransparency <= 0 then
			local dodgeTick = tick()
			task.wait(0.1)
			repeat
				Teleport(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
				task.wait()
			until tick() - dodgeTick > 2
		end

		Teleport(enemy.HumanoidRootPart.CFrame * CFrame.new(0, -8, 0))
		hrp.CFrame = CFrame.lookAt(hrp.Position, enemy.HumanoidRootPart.Position)
	end

	return
end

function openChests()
	local data = HttpService:JSONDecode(slotData.Inventory.Value)
	for _, item in data do
		if string.find(item.Name, " Chest") then
			for i = 1, item.Amount do
				ReplicatedStorage.requests.character.use_item:FireServer(unpack({ item.Name, { UseAll = true } }))
			end
		end
	end
end

function autoSell()
	local selling = {}
	local sellNames = {
		"White Jacket",
		"Grey Jacket",
		"Balaclava",
		"Arm Wraps",
		"Shades",
		"Black Jacket",
		"Plain White Scarf",
		"Hood",
		"Simple Cape",
		"Mask",
		"Head Goggles",
		"Biker Chain",
		"Red Topcoat",
		"Green Ripped Jacket",
		"White Ripped Jacket",
		"Face Goggles",
		"Eye Patch",
		"Grey Topcoat",
		"White Topcoat",
		"Baseball Cap",
		"Gold Crown",
	}
	local data = HttpService:JSONDecode(slotData.Inventory.Value)
	for _, item in data do
		if table.find(sellNames, item.Name) then
			item.duplicates = 1
			print(item.ID, item.Name, item.Pips, item.duplicates)
			table.insert(selling, item)
		end
	end

	ReplicatedStorage.requests.general.SellItem:FireServer(unpack({ selling }))
end

print("Before Window")
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
					local trackedQuest = slotData.TrackedQuest.Value
					local questLabel = FarmsSection:Label("Tracked Quest: " .. trackedQuest, "Left")

					plr.PlayerData.SlotData.TrackedQuest.Changed:Connect(function()
						trackedQuest = slotData.TrackedQuest.Value
						questLabel:Set("Tracked Quest: " .. trackedQuest)
					end)

					FarmsSection:Toggle({
						Name = "Auto Tracked Quest",
						Flag = "autoTrackedQuest",
						Default = false,
						Callback = function(Value)
							trackedQuest = slotData.TrackedQuest.Value
							questLabel:Set("Tracked Quest: " .. trackedQuest)

							while Library.Flags.autoTrackedQuest do
								task.wait()
								local trackedQuestData

								if trackedQuest ~= slotData.TrackedQuest.Value then
									trackedQuest = slotData.TrackedQuest.Value
									questLabel:Set("Tracked Quest: " .. trackedQuest)
								end

								local questData = HttpService:JSONDecode(slotData.CurrentQuests.Value)
								if not trackedQuest or trackedQuest == "" or not questData then
									return
								end
								for index, quest in questData do
									if quest.Name == trackedQuest then
										trackedQuestData = questData[index]
										break
									end
								end

								if find(workspace.Effects, "questbrick") then
									Teleport(workspace.Effects.questbrick.questbrick.CFrame * CFrame.new(0, 0, 5))
								end

								if trackedQuestData.Talk then
									for npc, completed in trackedQuestData.Talk do
										if completed == false then
											if find(workspace.Npcs, npc) then
												Teleport(
													workspace.Npcs[npc].HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
												)
											elseif find(ReplicatedStorage.assets.npc_cache, npc) then
												Teleport(
													ReplicatedStorage.assets.npc_cache[npc].HumanoidRootPart.CFrame
														* CFrame.new(0, 0, -3)
												)
											end
											ReplicatedStorage.requests.character.dialogue:FireServer(unpack({
												wait({ workspace.Npcs, npc, 10 }),
												1,
											}))
											wait({ 1 })
										end
									end
								end

								if trackedQuestData.Kills then
									for enemy, _amount in trackedQuestData.Kills do
										local complete = false
										for _, obj in
											plr.PlayerGui.menu.task_holder.holder.newobjective.ScrollingFrame.holder:GetChildren()
										do
											if
												(find(obj, "TextLabel") and find(obj.TextLabel.Text, "Defeat" .. enemy))
												or (
													find(obj, "text")
													and find(obj.text.TextLabel.Text, "Defeat " .. enemy)
												)
											then
												if
													(find(obj, "Frame") and obj.Frame.finished.Visible == true)
													or (find(obj, "text") and obj.text.Frame.finished.Visible == true)
												then
													complete = true
												end
											end
										end
										if complete == true then
											continue
										end
										if getEnemyLocation(enemy) and enemy ~= "The Self" then
											Teleport(getEnemyLocation(enemy))
										end
										if enemy == "The Self" then
											for _, liveEnemy in workspace.Live:GetChildren() do
												if GetAttribute(liveEnemy, "Display Name") then
													autoFarmEnemy(liveEnemy)
													break
												end
											end

											if wait({ workspace.Npcs, enemy, 5 }) then
												ReplicatedStorage.requests.character.dialogue:FireServer(unpack({
													wait({ workspace.Npcs, enemy, 10 }),
													1,
												}))
												ReplicatedStorage.requests.character.dialogue:FireServer(unpack({
													wait({ workspace.Npcs, enemy, 10 }),
													"Yes.",
												}))
											else
												if find(workspace.Npcs, "Meditation") then
													Teleport(
														workspace.Npcs["Meditation"].HumanoidRootPart.CFrame
															* CFrame.new(0, 0, -3)
													)
												elseif find(ReplicatedStorage.assets.npc_cache, "Meditation") then
													Teleport(
														ReplicatedStorage.assets.npc_cache["Meditation"].HumanoidRootPart.CFrame
															* CFrame.new(0, 0, -3)
													)
													task.wait(5)
												end
												ReplicatedStorage.requests.character.dialogue:FireServer(unpack({
													wait({ workspace.Npcs, "Meditation", 10 }),
													1,
												}))
												ReplicatedStorage.requests.character.dialogue:FireServer(unpack({
													wait({ workspace.Npcs, "Meditation", 10 }),
													"Meditate.",
												}))
											end
										else
											for _, liveEnemy in workspace.Live:GetChildren() do
												if string.find(liveEnemy.Name, enemy) then
													autoFarmEnemy(liveEnemy)
													break
												end
											end
										end
									end
								end

								if trackedQuestData.TurnInItems then
									local inventoryData = HttpService:JSONDecode(slotData.Inventory.Value)
									for neededItems, amount in trackedQuestData.TurnInItems do
										for _, item in inventoryData do
											if item.Name == neededItems and item.Amount >= amount then
												for _, obj in
													plr.PlayerGui.menu.task_holder.holder.newobjective.ScrollingFrame.holder:GetChildren()
												do
													if
														(
															obj:FindFirstChild("TextLabel")
															and string.find(
																obj.TextLabel.Text,
																"Turn In " .. neededItems
															)
														)
														or (
															obj:FindFirstChild("text")
															and string.find(
																obj.text.TextLabel.Text,
																"Turn In " .. neededItems
															)
														)
													then
														local npc
														if obj:FindFirstChild("TextLabel") then
															npc = string.split(obj.TextLabel.Text, "to ")[2]
														else
															npc = string.split(obj.text.TextLabel.Text, "to ")[2]
														end
														npc = string.split(npc, "「")[1]
														if workspace.Npcs:FindFirstChild(npc) then
															Teleport(
																workspace.Npcs[npc].HumanoidRootPart.CFrame
																	* CFrame.new(0, 0, -3)
															)
														elseif
															ReplicatedStorage.assets.npc_cache:FindFirstChild(npc)
														then
															Teleport(
																ReplicatedStorage.assets.npc_cache[npc].HumanoidRootPart.CFrame
																	* CFrame.new(0, 0, -3)
															)
														end
														ReplicatedStorage.requests.character.dialogue:FireServer(
															unpack({
																workspace.Npcs:WaitForChild(npc, 10),
																1,
															})
														)
														ReplicatedStorage.requests.character.dialogue:FireServer(
															unpack({
																workspace.Npcs:WaitForChild(npc, 10),
																"Here.",
															})
														)
													end
												end
											end
										end
									end
								end

								if trackedQuestData.GangContracts then
									if workspace.Npcs:FindFirstChild("Gang Contractor") then
										Teleport(
											workspace.Npcs["Gang Contractor"].HumanoidRootPart.CFrame
												* CFrame.new(0, 0, -3)
										)
									elseif ReplicatedStorage.assets.npc_cache:FindFirstChild("Gang Contractor") then
										Teleport(
											ReplicatedStorage.assets.npc_cache["Gang Contractor"].HumanoidRootPart.CFrame
												* CFrame.new(0, 0, -3)
										)
									end
									ReplicatedStorage.requests.character.dialogue:FireServer(unpack({
										workspace.Npcs:WaitForChild("Gang Contractor", 10),
										1,
									}))
									task.wait(0.1)
									ReplicatedStorage.requests.character.dialogue:FireServer(unpack({
										workspace.Npcs:WaitForChild("Gang Contractor", 10),
										"Yes.",
									}))
									task.wait(1)
									for _, questbrick in workspace.Effects:GetChildren() do
										if
											questbrick:FindFirstChild("Quest Marker")
											and (
												string.find(
													questbrick["Quest Marker"].Image.Title.Text,
													"Rescue Gang Member"
												)
												or string.find(
													questbrick["Quest Marker"].Image.Title.Text,
													"Capture Territory"
												)
											)
										then
											Teleport(questbrick.questbrick.CFrame * CFrame.new(0, 0, -3))
											if workspace:FindFirstChild("Capture Gang Member") then
												task.wait(1)
												fireproximityprompt(
													workspace["Capture Gang Member"].HumanoidRootPart.ProximityPrompt,
													5
												)
												task.wait(12)
											else
												character.Humanoid.Health = 0
												task.wait(5)
											end
											break
										end
									end
								end
							end
							print(Value)
						end,
					})
					FarmsSection:Button({
						Name = "TP to Tracked Quest",
						Flag = "TPTrackedButton",
						Callback = function()
							Teleport(workspace.Effects.questbrick.questbrick.CFrame * CFrame.new(0, 0, 5))
						end,
					})
					FarmsSection:Toggle({
						Name = "Auto Raid",
						Flag = "autoRaid",
						Default = false,
						Callback = function()
							if Library.Flags.autoRaid then
								connections["autoRaid"] = task.spawn(function()
									print("Raid func")
									if game.PlaceId ~= 74747090658891 then
										return
									end
									while Library.Flags.autoRaid do
										task.wait()

										for _, liveEnemy in workspace.Live:GetChildren() do
											if
												liveEnemy.Name ~= "Server"
												and not string.find(liveEnemy.Name, "Hostage")
												and not Players:FindFirstChild(liveEnemy.Name)
											then
												autoFarmEnemy(liveEnemy)
											end

											if not Library.Flags.autoRaid then
												break
											end
										end

										if plr.PlayerGui:FindFirstChild("raidcomplete") then
											RS.requests.character.retryraid:FireServer()
											break
										end
									end
								end)
							else
								connections["AutoRaid"] = nil
								return
							end
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
						Name = "Auto Summon Stand",
						Flag = "autoSummonStand",
						Default = false,
						Callback = function(Value)
							if
								(
									GetAttribute(character, "SummonedStand") == nil
									or GetAttribute(character, "SummonedStand") == ""
								) and farming() == true
							then
								character.client_character_controller.SummonStand:FireServer()
							end

							character:GetAttributeChangedSignal("SummonedStand"):Connect(function()
								if
									(
										GetAttribute(character, "SummonedStand") == nil
										or GetAttribute(character, "SummonedStand") == ""
									) and farming() == true
								then
									character.client_character_controller.SummonStand:FireServer()
								end
							end)
						end,
					})
					FarmSettingsSection:Toggle({
						Name = "Auto M1",
						Flag = "autoM1",
						Default = false,
						Callback = function(Value)
							while Library.Flags.autoM1 and farming() do
								wait()
								character.client_character_controller.M1:FireServer(unpack({ true, false }))
							end
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
						Items = { "E", "R", "Z", "X", "C", "V", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" },
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
					local standLabel = ItemsSection:Label("Stand: " .. standData.Name .. " - " .. skin, "Left")
					slotData.Stand.Changed:Connect(function()
						standData = HttpService:JSONDecode(slotData.Stand.Value)
						skin = standData.Skin or "Default"
						standLabel:Set("Stand: " .. standData.Name .. " - " .. skin)
					end)
					ItemsSection:Toggle({
						Name = "Auto Stand Arrow",
						Flag = "autoStandArrow",
						Default = false,
						Callback = function()
							if
								Library.Flags.autoStandArrow
								and not table.find(selectedStands, standData.Name)
								and not (Library.Flags.keepSkins and standData.Skin ~= nil)
							then
								connections["AutoArrow"] = task.spawn(function()
									repeat
										local inventoryData = HttpService:JSONDecode(slotData.Inventory.Value)
										for _, item in inventoryData do
											if item.Name == "Stand Arrow" and item.Amount <= 1 then
												ItemsSection.Items[1]:Set(false)
											end
										end
										ReplicatedStorage.requests.character.use_item:FireServer(
											unpack({ "Stand Arrow" })
										)
										task.wait(8)
									until table.find(selectedStands, standData.Name)
										or (Library.Flags.keepSkins and standData.Skin ~= nil)
										or not Library.Flags.autoStandArrow

									getgenv().Options.autoStandArrow:Set(false)
								end)
							elseif not Library.Flags.autoStandArrow then
								connections["AutoArrow"] = nil
								return
							else
								getgenv().Options.autoStandArrow:Set(false)
							end
						end,
					})
					ItemsSection:Toggle({
						Name = "Keep Skins?",
						Flag = "keepSkins",
						Default = false,
					})
					ItemsSection:Toggle({
						Name = "Auto Sell",
						Flag = "autoSell",
						Default = false,
						Callback = function()
							if Library.Flags.autoSell then
								autoSell()
								connections["autoSell"] = slotData.Inventory.Changed:Connect(function()
									autoSell()
								end)
							else
								if connections["autoSell"] then
									connections["autoSell"]:Disconnect()
								end
								connections["autoSell"] = nil
								return
							end
						end,
					})
					ItemsSection:Toggle({
						Name = "Auto Open Chests",
						Flag = "autoOpenChests",
						Default = false,
						Callback = function()
							if Library.Flags.autoOpenChests then
								openChests()
								connections["autoOpenChests"] = slotData.Inventory.Changed:Connect(function()
									openChests()
								end)
							else
								if connections["autoOpenChests"] then
									connections["autoOpenChests"]:Disconnect()
								end
								connections["autoOpenChests"] = nil
								return
							end
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
					for _, stand in ReplicatedStorage.assets.models.stands:GetChildren() do
						if stand.Name ~= "Skins" then
							table.insert(StandsList, stand.Name)
						end
					end
					ItemSettingsSection:Dropdown({
						Name = "Stands List: ",
						Flag = "standsDropdown",
						Items = StandsList,
						Default = "",
						MaxSize = 300,
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

local TeleportCheck = false

plr.OnTeleport:Connect(function()
	if TeleportCheck == false then
		TeleportCheck = true
		queueteleport(
			"loadstring(game:HttpGet('https://raw.githubusercontent.com/zanerBRUH/UwU-Ware/refs/heads/main/Libraries/Kiwisense.lua'))()"
		)
	end
end)

Library:Notification({
	Name = "Loaded",
	Description = "Loaded library in: " .. string.format("%.4f", os.clock() - LoadingTick) .. " seconds",
	Duration = 5,
})

Library:Init() -- put this at the end of ur script or the autoload will not work
--
