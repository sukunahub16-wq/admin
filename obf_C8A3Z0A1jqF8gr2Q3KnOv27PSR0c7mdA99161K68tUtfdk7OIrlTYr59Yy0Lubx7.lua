--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local Players = game:GetService("Players");
local TextChatService = game:GetService("TextChatService");
local StarterGui = game:GetService("StarterGui");
local CoreGui = game:GetService("CoreGui");
local Workspace = game:GetService("Workspace");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local VirtualInputManager = game:GetService("VirtualInputManager");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local DONOS = {SUKUNA_333857=true,JustWX99s=true};
local MODS = {alodozhynn=true};
local TEMP_MODS = {};
local function IsDono(n)
	return DONOS[n] == true;
end
local function IsMod(n)
	return MODS[n] == true;
end
local function IsTempMod(n)
	return TEMP_MODS[n] == true;
end
local function IsAutorizado(n)
	return IsDono(n) or IsMod(n) or IsTempMod(n);
end
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local NYTHERUNE_USERS = {};
local tagsVisiveis = true;
local JAILED_PLAYERS = {};
local FROZEN_PLAYERS = {};
local JUMPSCARES = {{Name=";jumps1",ImageId="rbxassetid://126754882337711",AudioId="rbxassetid://138873214826309"},{Name=";jumps2",ImageId="rbxassetid://86379969987314",AudioId="rbxassetid://143942090"},{Name=";jumps3",ImageId="rbxassetid://127382022168206",AudioId="rbxassetid://143942090"},{Name=";jumps4",ImageId="rbxassetid://95973611964555",AudioId="rbxassetid://138873214826309"}};
local function FreezePlayer(player)
	local FlatIdent_24A02 = 0;
	local h;
	while true do
		if (FlatIdent_24A02 == 3) then
			return true;
		end
		if (FlatIdent_24A02 == 0) then
			if (not player or not player.Character) then
				return false;
			end
			h = player.Character:FindFirstChildOfClass("Humanoid");
			FlatIdent_24A02 = 1;
		end
		if (FlatIdent_24A02 == 2) then
			h.WalkSpeed = 0;
			h.JumpPower = 0;
			FlatIdent_24A02 = 3;
		end
		if (FlatIdent_24A02 == 1) then
			if (not h or FROZEN_PLAYERS[player.Name]) then
				return false;
			end
			FROZEN_PLAYERS[player.Name] = {WalkSpeed=h.WalkSpeed,JumpPower=h.JumpPower};
			FlatIdent_24A02 = 2;
		end
	end
end
local function UnfreezePlayer(player)
	if (not player or not FROZEN_PLAYERS[player.Name]) then
		return false;
	end
	local s = FROZEN_PLAYERS[player.Name];
	if player.Character then
		local FlatIdent_63487 = 0;
		local h;
		while true do
			if (FlatIdent_63487 == 0) then
				h = player.Character:FindFirstChildOfClass("Humanoid");
				if h then
					local FlatIdent_44839 = 0;
					while true do
						if (FlatIdent_44839 == 0) then
							h.WalkSpeed = s.WalkSpeed;
							h.JumpPower = s.JumpPower;
							break;
						end
					end
				end
				break;
			end
		end
	end
	FROZEN_PLAYERS[player.Name] = nil;
	return true;
end
local function CreateAndManageJail(player)
	local FlatIdent_25011 = 0;
	local e;
	local hrp;
	local m;
	local s;
	local p;
	local t;
	while true do
		if (FlatIdent_25011 == 2) then
			m = Instance.new("Model", Workspace);
			m.Name = "Jail_" .. player.Name;
			s = 8;
			FlatIdent_25011 = 3;
		end
		if (FlatIdent_25011 == 3) then
			p = hrp.Position;
			t = {Base=Instance.new("Part", m),Roof=Instance.new("Part", m),Wall1=Instance.new("Part", m),Wall2=Instance.new("Part", m),Wall3=Instance.new("Part", m),Wall4=Instance.new("Part", m)};
			t.Base.Size = Vector3.new(s, 0.5, s);
			FlatIdent_25011 = 4;
		end
		if (FlatIdent_25011 == 5) then
			t.Wall1.Size = Vector3.new(0.5, s, s);
			t.Wall1.Position = t.Base.Position + Vector3.new(s / 2, s / 2, 0);
			t.Wall2.Size = Vector3.new(0.5, s, s);
			FlatIdent_25011 = 6;
		end
		if (4 == FlatIdent_25011) then
			t.Base.Position = p - Vector3.new(0, player.Character.Humanoid.HipHeight + 0.25, 0);
			t.Roof.Size = Vector3.new(s, 0.5, s);
			t.Roof.Position = t.Base.Position + Vector3.new(0, s, 0);
			FlatIdent_25011 = 5;
		end
		if (FlatIdent_25011 == 1) then
			if (JAILED_PLAYERS[player.Name] and JAILED_PLAYERS[player.Name].loop) then
				task.cancel(JAILED_PLAYERS[player.Name].loop);
			end
			hrp = player.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then
				return false;
			end
			FlatIdent_25011 = 2;
		end
		if (FlatIdent_25011 == 7) then
			t.Wall4.Size = Vector3.new(s, s, 0.5);
			t.Wall4.Position = t.Base.Position + Vector3.new(0, s / 2, -s / 2);
			for _, v in pairs(t) do
				local FlatIdent_2FD19 = 0;
				while true do
					if (FlatIdent_2FD19 == 0) then
						v.Anchored = true;
						v.CanCollide = true;
						FlatIdent_2FD19 = 1;
					end
					if (FlatIdent_2FD19 == 1) then
						v.Material = Enum.Material.Neon;
						v.Color = Color3.fromRGB(0, 200, 255);
						FlatIdent_2FD19 = 2;
					end
					if (FlatIdent_2FD19 == 2) then
						v.Transparency = 0.6;
						break;
					end
				end
			end
			FlatIdent_25011 = 8;
		end
		if (FlatIdent_25011 == 8) then
			if (player == LocalPlayer) then
				local FlatIdent_1B51D = 0;
				local l;
				while true do
					if (FlatIdent_1B51D == 0) then
						l = task.spawn(function()
							local c = t.Base.Position + Vector3.new(0, player.Character.Humanoid.HipHeight, 0);
							while JAILED_PLAYERS[player.Name] and player.Parent and player.Character and player.Character.Parent do
								local FlatIdent_17196 = 0;
								local h;
								while true do
									if (FlatIdent_17196 == 1) then
										task.wait(0.1);
										break;
									end
									if (FlatIdent_17196 == 0) then
										h = player.Character:FindFirstChild("HumanoidRootPart");
										if (h and ((h.Position - c).Magnitude > ((s / 2) - 1))) then
											h.CFrame = CFrame.new(c);
										end
										FlatIdent_17196 = 1;
									end
								end
							end
						end);
						JAILED_PLAYERS[player.Name] = {loop=l};
						break;
					end
				end
			else
				JAILED_PLAYERS[player.Name] = {};
			end
			return true;
		end
		if (FlatIdent_25011 == 6) then
			t.Wall2.Position = t.Base.Position + Vector3.new(-s / 2, s / 2, 0);
			t.Wall3.Size = Vector3.new(s, s, 0.5);
			t.Wall3.Position = t.Base.Position + Vector3.new(0, s / 2, s / 2);
			FlatIdent_25011 = 7;
		end
		if (0 == FlatIdent_25011) then
			if (not player or not player.Character) then
				return false;
			end
			e = Workspace:FindFirstChild("Jail_" .. player.Name);
			if e then
				e:Destroy();
			end
			FlatIdent_25011 = 1;
		end
	end
end
local function RemoveJail(player)
	local FlatIdent_5BA5E = 0;
	local w;
	local d;
	while true do
		if (FlatIdent_5BA5E == 0) then
			w = Workspace:FindFirstChild("Jail_" .. player.Name);
			if w then
				w:Destroy();
			end
			FlatIdent_5BA5E = 1;
		end
		if (FlatIdent_5BA5E == 3) then
			return true;
		end
		if (FlatIdent_5BA5E == 2) then
			if d.loop then
				task.cancel(d.loop);
			end
			JAILED_PLAYERS[player.Name] = nil;
			FlatIdent_5BA5E = 3;
		end
		if (FlatIdent_5BA5E == 1) then
			if (not player or not JAILED_PLAYERS[player.Name]) then
				return false;
			end
			d = JAILED_PLAYERS[player.Name];
			FlatIdent_5BA5E = 2;
		end
	end
end
local function FloatPlayer(player)
	local FlatIdent_494DF = 0;
	local targetHrp;
	local targetHumanoid;
	local targetPos;
	local bodyVelocity;
	local maxHeight;
	local connection;
	while true do
		if (FlatIdent_494DF == 1) then
			targetHumanoid.WalkSpeed = 0;
			targetHumanoid.JumpHeight = 0;
			bodyVelocity = Instance.new("BodyVelocity", targetHrp);
			bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0);
			FlatIdent_494DF = 2;
		end
		if (FlatIdent_494DF == 3) then
			connection = RunService.Heartbeat:Connect(function()
				if (not player.Character or not player.Character.Parent or not targetHrp.Parent or not targetHumanoid.Parent) then
					local FlatIdent_8D1A5 = 0;
					while true do
						if (0 == FlatIdent_8D1A5) then
							if (bodyVelocity and bodyVelocity.Parent) then
								bodyVelocity:Destroy();
							end
							if connection then
								connection:Disconnect();
							end
							FlatIdent_8D1A5 = 1;
						end
						if (1 == FlatIdent_8D1A5) then
							return;
						end
					end
				end
				if (targetHrp.Position.Y >= maxHeight) then
					if (bodyVelocity and bodyVelocity.Parent) then
						bodyVelocity:Destroy();
					end
					if connection then
						connection:Disconnect();
					end
					targetHumanoid.Health = 0;
				end
			end);
			return true;
		end
		if (FlatIdent_494DF == 0) then
			if (not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") or not player.Character:FindFirstChildOfClass("Humanoid")) then
				return false;
			end
			targetHrp = player.Character.HumanoidRootPart;
			targetHumanoid = player.Character:FindFirstChildOfClass("Humanoid");
			targetPos = targetHrp.Position;
			FlatIdent_494DF = 1;
		end
		if (FlatIdent_494DF == 2) then
			bodyVelocity.Velocity = Vector3.new(0, 10, 0);
			bodyVelocity.Name = "FloatVelocity";
			maxHeight = targetPos.Y + 50;
			connection = nil;
			FlatIdent_494DF = 3;
		end
	end
end
local function KillPlus(player)
	if (not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart")) then
		return false;
	end
	local targetHrp = player.Character.HumanoidRootPart;
	local targetPos = targetHrp.Position;
	local parts = {};
	local numParts = 5;
	local folder = Instance.new("Folder", Workspace);
	folder.Name = "KillPlusTemp_" .. player.Name;
	for i = 1, numParts do
		local FlatIdent_6DC53 = 0;
		local part;
		while true do
			if (FlatIdent_6DC53 == 4) then
				part.Parent = folder;
				table.insert(parts, part);
				break;
			end
			if (0 == FlatIdent_6DC53) then
				part = Instance.new("Part");
				part.Name = "KillPlusPart_" .. player.Name .. "_" .. i;
				FlatIdent_6DC53 = 1;
			end
			if (2 == FlatIdent_6DC53) then
				part.Anchored = true;
				part.CanCollide = true;
				FlatIdent_6DC53 = 3;
			end
			if (1 == FlatIdent_6DC53) then
				part.Size = Vector3.new(2, 2, 2);
				part.Position = targetPos + Vector3.new(math.random(-10, 10), -5, math.random(-10, 10));
				FlatIdent_6DC53 = 2;
			end
			if (3 == FlatIdent_6DC53) then
				part.Material = Enum.Material.Neon;
				part.Color = Color3.fromRGB(255, 0, 0);
				FlatIdent_6DC53 = 4;
			end
		end
	end
	local speed = 50;
	for _, part in ipairs(parts) do
		local FlatIdent_7F121 = 0;
		local distance;
		local duration;
		local tweenInfo;
		local tween;
		while true do
			if (FlatIdent_7F121 == 3) then
				part.Touched:Connect(function(hit)
					if ((hit.Parent == player.Character) and player.Character:FindFirstChild("HumanoidRootPart")) then
						local FlatIdent_69253 = 0;
						local bodyVelocity;
						while true do
							if (0 == FlatIdent_69253) then
								bodyVelocity = Instance.new("BodyVelocity", targetHrp);
								bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge);
								FlatIdent_69253 = 1;
							end
							if (1 == FlatIdent_69253) then
								bodyVelocity.Velocity = Vector3.new(math.random(-50, 50), 100, math.random(-50, 50));
								Debris:AddItem(bodyVelocity, 0.5);
								break;
							end
						end
					end
				end);
				break;
			end
			if (FlatIdent_7F121 == 0) then
				distance = (targetPos - part.Position).Magnitude;
				duration = math.max(0.1, distance / speed);
				FlatIdent_7F121 = 1;
			end
			if (2 == FlatIdent_7F121) then
				part.Anchored = false;
				tween:Play();
				FlatIdent_7F121 = 3;
			end
			if (FlatIdent_7F121 == 1) then
				tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear);
				tween = TweenService:Create(part, tweenInfo, {Position=(targetPos + Vector3.new(0, 1, 0))});
				FlatIdent_7F121 = 2;
			end
		end
	end
	Debris:AddItem(folder, 5);
	return true;
end
local function TriggerJumpscare(player, jumpscare)
	local FlatIdent_6A091 = 0;
	local screenGui;
	local imageLabel;
	local sound;
	local flashCount;
	local flashInterval;
	while true do
		if (FlatIdent_6A091 == 6) then
			sound:Stop();
			screenGui:Destroy();
			return true;
		end
		if (FlatIdent_6A091 == 4) then
			sound.Volume = 1;
			sound.Looped = false;
			sound:Play();
			FlatIdent_6A091 = 5;
		end
		if (FlatIdent_6A091 == 3) then
			imageLabel.Image = jumpscare.ImageId;
			sound = Instance.new("Sound", screenGui);
			sound.SoundId = jumpscare.AudioId;
			FlatIdent_6A091 = 4;
		end
		if (FlatIdent_6A091 == 0) then
			if (not player or (player ~= LocalPlayer)) then
				return false;
			end
			screenGui = Instance.new("ScreenGui", CoreGui);
			screenGui.Name = "JumpscareGui";
			FlatIdent_6A091 = 1;
		end
		if (FlatIdent_6A091 == 5) then
			flashCount = 10;
			flashInterval = 0.2;
			for i = 1, flashCount do
				if not screenGui.Parent then
					break;
				end
				imageLabel.ImageTransparency = (((i % 2) == 0) and 0.3) or 0;
				task.wait(flashInterval);
			end
			FlatIdent_6A091 = 6;
		end
		if (FlatIdent_6A091 == 1) then
			screenGui.IgnoreGuiInset = true;
			screenGui.ResetOnSpawn = false;
			imageLabel = Instance.new("ImageLabel", screenGui);
			FlatIdent_6A091 = 2;
		end
		if (FlatIdent_6A091 == 2) then
			imageLabel.Size = UDim2.new(1, 0, 1, 0);
			imageLabel.Position = UDim2.new(0, 0, 0, 0);
			imageLabel.BackgroundTransparency = 1;
			FlatIdent_6A091 = 3;
		end
	end
end
Players.PlayerRemoving:Connect(function(player)
	local FlatIdent_580CB = 0;
	while true do
		if (FlatIdent_580CB == 2) then
			if (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
				local bodyVelocity = player.Character.HumanoidRootPart:FindFirstChild("FloatVelocity");
				if bodyVelocity then
					bodyVelocity:Destroy();
				end
			end
			for i = 1, 5 do
				local FlatIdent_67517 = 0;
				local part;
				while true do
					if (FlatIdent_67517 == 0) then
						part = Workspace:FindFirstChild("KillPlusPart_" .. player.Name .. "_" .. i);
						if part then
							part:Destroy();
						end
						break;
					end
				end
			end
			break;
		end
		if (FlatIdent_580CB == 1) then
			NYTHERUNE_USERS[player.Name] = nil;
			TEMP_MODS[player.Name] = nil;
			FlatIdent_580CB = 2;
		end
		if (FlatIdent_580CB == 0) then
			RemoveJail(player);
			UnfreezePlayer(player);
			FlatIdent_580CB = 1;
		end
	end
end);
local function CreateAdminUI()
	if CoreGui:FindFirstChild("NythAdminUI") then
		return;
	end
	local screen = Instance.new("ScreenGui", CoreGui);
	screen.Name = "NythAdminUI";
	screen.ResetOnSpawn = false;
	local panel = Instance.new("Frame", screen);
	panel.Size = UDim2.new(0, 320, 0, 450);
	panel.Position = UDim2.new(0.5, -160, 0.5, -225);
	panel.BackgroundColor3 = Color3.fromRGB(48, 0, 48);
	panel.Active = true;
	panel.Draggable = true;
	Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 8);
	local fullSz = panel.Size;
	local header = Instance.new("Frame", panel);
	header.Size = UDim2.new(1, 0, 0, 36);
	header.BackgroundTransparency = 1;
	local title = Instance.new("TextLabel", header);
	title.Text = "Nytherune Hub";
	title.Size = UDim2.new(1, -70, 1, 0);
	title.Position = UDim2.new(0, 10, 0, 0);
	title.BackgroundTransparency = 1;
	title.TextColor3 = Color3.new(1, 1, 1);
	title.Font = Enum.Font.GothamBold;
	title.TextSize = 18;
	title.TextXAlignment = Enum.TextXAlignment.Left;
	local btnClose = Instance.new("TextButton", header);
	btnClose.Text = "✖";
	btnClose.Font = Enum.Font.GothamBold;
	btnClose.TextSize = 14;
	btnClose.TextColor3 = Color3.new(1, 1, 1);
	btnClose.BackgroundTransparency = 1;
	btnClose.Size = UDim2.new(0, 25, 0, 25);
	btnClose.Position = UDim2.new(1, -30, 0, 5);
	btnClose.MouseButton1Click:Connect(function()
		screen:Destroy();
	end);
	local btnMin = Instance.new("TextButton", header);
	btnMin.Text = "=";
	btnMin.Font = Enum.Font.GothamBold;
	btnMin.TextSize = 14;
	btnMin.TextColor3 = Color3.new(1, 1, 1);
	btnMin.BackgroundTransparency = 1;
	btnMin.Size = UDim2.new(0, 25, 0, 25);
	btnMin.Position = UDim2.new(1, -60, 0, 5);
	local tabContainer = Instance.new("Frame", panel);
	tabContainer.Size = UDim2.new(1, 0, 0, 30);
	tabContainer.Position = UDim2.new(0, 0, 0, 36);
	tabContainer.BackgroundTransparency = 1;
	local tabLayout = Instance.new("UIListLayout", tabContainer);
	tabLayout.FillDirection = Enum.FillDirection.Horizontal;
	tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	tabLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	tabLayout.Padding = UDim.new(0, 5);
	local body = Instance.new("Frame", panel);
	body.Size = UDim2.new(1, 0, 1, -70);
	body.Position = UDim2.new(0, 0, 0, 70);
	body.BackgroundTransparency = 1;
	local minimized = false;
	btnMin.MouseButton1Click:Connect(function()
		local FlatIdent_31ECC = 0;
		while true do
			if (FlatIdent_31ECC == 0) then
				minimized = not minimized;
				body.Visible = not minimized;
				FlatIdent_31ECC = 1;
			end
			if (FlatIdent_31ECC == 1) then
				tabContainer.Visible = not minimized;
				if minimized then
					panel.Size = UDim2.new(0, 180, 0, 36);
					btnMin.Text = "+";
				else
					local FlatIdent_69C4C = 0;
					while true do
						if (FlatIdent_69C4C == 0) then
							panel.Size = fullSz;
							btnMin.Text = "";
							break;
						end
					end
				end
				break;
			end
		end
	end);
	local cmdFrame = Instance.new("ScrollingFrame", body);
	cmdFrame.Size = UDim2.new(1, 0, 1, 0);
	cmdFrame.BackgroundTransparency = 1;
	cmdFrame.BorderSizePixel = 0;
	cmdFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 105, 180);
	cmdFrame.ScrollBarThickness = 6;
	local cmdListLayout = Instance.new("UIListLayout", cmdFrame);
	cmdListLayout.Padding = UDim.new(0, 8);
	cmdListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	cmdListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	local avatarFrame = Instance.new("ScrollingFrame", body);
	avatarFrame.Size = UDim2.new(1, 0, 1, 0);
	avatarFrame.BackgroundTransparency = 1;
	avatarFrame.BorderSizePixel = 0;
	avatarFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 105, 180);
	avatarFrame.ScrollBarThickness = 6;
	avatarFrame.Visible = false;
	local avatarListLayout = Instance.new("UIListLayout", avatarFrame);
	avatarListLayout.Padding = UDim.new(0, 8);
	avatarListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	avatarListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	local terrorFrame = Instance.new("ScrollingFrame", body);
	terrorFrame.Size = UDim2.new(1, 0, 1, 0);
	terrorFrame.BackgroundTransparency = 1;
	terrorFrame.BorderSizePixel = 0;
	terrorFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 105, 180);
	terrorFrame.ScrollBarThickness = 6;
	terrorFrame.Visible = false;
	local terrorListLayout = Instance.new("UIListLayout", terrorFrame);
	terrorListLayout.Padding = UDim.new(0, 8);
	terrorListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
	terrorListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
	local btnTabCmds = Instance.new("TextButton", tabContainer);
	btnTabCmds.Name = "CmdsTab";
	btnTabCmds.Text = "Comandos";
	btnTabCmds.Font = Enum.Font.GothamBold;
	btnTabCmds.TextSize = 14;
	btnTabCmds.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
	btnTabCmds.TextColor3 = Color3.new(1, 1, 1);
	btnTabCmds.Size = UDim2.new(0.33, -5, 1, 0);
	local btnTabAvatar = Instance.new("TextButton", tabContainer);
	btnTabAvatar.Name = "AvatarTab";
	btnTabAvatar.Text = "Avatar";
	btnTabAvatar.Font = Enum.Font.Gotham;
	btnTabAvatar.TextSize = 14;
	btnTabAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
	btnTabAvatar.TextColor3 = Color3.new(0.8, 0.8, 0.8);
	btnTabAvatar.Size = UDim2.new(0.33, -5, 1, 0);
	local btnTabTerror = Instance.new("TextButton", tabContainer);
	btnTabTerror.Name = "TerrorTab";
	btnTabTerror.Text = "Terror";
	btnTabTerror.Font = Enum.Font.Gotham;
	btnTabTerror.TextSize = 14;
	btnTabTerror.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
	btnTabTerror.TextColor3 = Color3.new(0.8, 0.8, 0.8);
	btnTabTerror.Size = UDim2.new(0.33, -5, 1, 0);
	local function switchTab(tab)
		if (tab == "cmds") then
			local FlatIdent_8B272 = 0;
			while true do
				if (2 == FlatIdent_8B272) then
					btnTabCmds.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
					btnTabAvatar.Font = Enum.Font.Gotham;
					FlatIdent_8B272 = 3;
				end
				if (FlatIdent_8B272 == 3) then
					btnTabAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
					btnTabTerror.Font = Enum.Font.Gotham;
					FlatIdent_8B272 = 4;
				end
				if (0 == FlatIdent_8B272) then
					cmdFrame.Visible = true;
					avatarFrame.Visible = false;
					FlatIdent_8B272 = 1;
				end
				if (FlatIdent_8B272 == 1) then
					terrorFrame.Visible = false;
					btnTabCmds.Font = Enum.Font.GothamBold;
					FlatIdent_8B272 = 2;
				end
				if (4 == FlatIdent_8B272) then
					btnTabTerror.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
					break;
				end
			end
		elseif (tab == "avatar") then
			local FlatIdent_1468D = 0;
			while true do
				if (4 == FlatIdent_1468D) then
					btnTabTerror.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
					break;
				end
				if (FlatIdent_1468D == 3) then
					btnTabCmds.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
					btnTabTerror.Font = Enum.Font.Gotham;
					FlatIdent_1468D = 4;
				end
				if (FlatIdent_1468D == 1) then
					terrorFrame.Visible = false;
					btnTabAvatar.Font = Enum.Font.GothamBold;
					FlatIdent_1468D = 2;
				end
				if (FlatIdent_1468D == 2) then
					btnTabAvatar.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
					btnTabCmds.Font = Enum.Font.Gotham;
					FlatIdent_1468D = 3;
				end
				if (FlatIdent_1468D == 0) then
					avatarFrame.Visible = true;
					cmdFrame.Visible = false;
					FlatIdent_1468D = 1;
				end
			end
		else
			terrorFrame.Visible = true;
			cmdFrame.Visible = false;
			avatarFrame.Visible = false;
			btnTabTerror.Font = Enum.Font.GothamBold;
			btnTabTerror.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
			btnTabCmds.Font = Enum.Font.Gotham;
			btnTabCmds.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
			btnTabAvatar.Font = Enum.Font.Gotham;
			btnTabAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
		end
	end
	btnTabCmds.MouseButton1Click:Connect(function()
		switchTab("cmds");
	end);
	btnTabAvatar.MouseButton1Click:Connect(function()
		switchTab("avatar");
	end);
	btnTabTerror.MouseButton1Click:Connect(function()
		switchTab("terror");
	end);
	local selectedCmdTarget = nil;
	local ddCmd = Instance.new("TextButton", cmdFrame);
	ddCmd.Name = "Dropdown";
	ddCmd.Text = "🎯 Selecionar jogador";
	ddCmd.Font = Enum.Font.Gotham;
	ddCmd.TextSize = 14;
	ddCmd.TextColor3 = Color3.new(1, 1, 1);
	ddCmd.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
	ddCmd.Size = UDim2.new(1, -20, 0, 30);
	ddCmd.LayoutOrder = 1;
	local openCmd = false;
	local frameDDCmd = nil;
	ddCmd.MouseButton1Click:Connect(function()
		local FlatIdent_21CA5 = 0;
		local lst;
		local playersInServer;
		while true do
			if (2 == FlatIdent_21CA5) then
				frameDDCmd.ClipsDescendants = true;
				frameDDCmd.LayoutOrder = 2;
				lst = Instance.new("UIListLayout", frameDDCmd);
				FlatIdent_21CA5 = 3;
			end
			if (FlatIdent_21CA5 == 3) then
				lst.Padding = UDim.new(0, 2);
				playersInServer = {};
				for _, p in ipairs(Players:GetPlayers()) do
					table.insert(playersInServer, p.Name);
				end
				FlatIdent_21CA5 = 4;
			end
			if (0 == FlatIdent_21CA5) then
				if (openCmd and frameDDCmd) then
					local FlatIdent_77478 = 0;
					while true do
						if (FlatIdent_77478 == 0) then
							frameDDCmd:Destroy();
							openCmd = false;
							FlatIdent_77478 = 1;
						end
						if (1 == FlatIdent_77478) then
							return;
						end
					end
				end
				frameDDCmd = Instance.new("ScrollingFrame", cmdFrame);
				frameDDCmd.Position = UDim2.new(0.5, -((cmdFrame.AbsoluteSize.X - 20) / 2), 0, 40);
				FlatIdent_21CA5 = 1;
			end
			if (FlatIdent_21CA5 == 4) then
				table.sort(playersInServer);
				for _, name in ipairs(playersInServer) do
					local FlatIdent_145D2 = 0;
					local b;
					while true do
						if (FlatIdent_145D2 == 3) then
							b.Size = UDim2.new(1, 0, 0, 25);
							b.MouseButton1Click:Connect(function()
								local FlatIdent_86E18 = 0;
								while true do
									if (FlatIdent_86E18 == 1) then
										frameDDCmd:Destroy();
										openCmd = false;
										break;
									end
									if (FlatIdent_86E18 == 0) then
										selectedCmdTarget = name;
										ddCmd.Text = "🎯 " .. name;
										FlatIdent_86E18 = 1;
									end
								end
							end);
							break;
						end
						if (FlatIdent_145D2 == 0) then
							b = Instance.new("TextButton", frameDDCmd);
							b.Text = name;
							FlatIdent_145D2 = 1;
						end
						if (FlatIdent_145D2 == 1) then
							b.Font = Enum.Font.Gotham;
							b.TextSize = 14;
							FlatIdent_145D2 = 2;
						end
						if (2 == FlatIdent_145D2) then
							b.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
							b.TextColor3 = Color3.new(1, 1, 1);
							FlatIdent_145D2 = 3;
						end
					end
				end
				openCmd = true;
				break;
			end
			if (FlatIdent_21CA5 == 1) then
				frameDDCmd.Size = UDim2.new(1, -20, 0, 120);
				frameDDCmd.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
				frameDDCmd.BorderSizePixel = 0;
				FlatIdent_21CA5 = 2;
			end
		end
	end);
	local cmdContainer = Instance.new("Frame", cmdFrame);
	cmdContainer.BackgroundTransparency = 1;
	cmdContainer.Size = UDim2.new(1, -20, 0, 0);
	cmdContainer.AutomaticSize = Enum.AutomaticSize.Y;
	cmdContainer.LayoutOrder = 3;
	local uiListLayout = Instance.new("UIListLayout", cmdContainer);
	uiListLayout.Padding = UDim.new(0, 6);
	local cmds = {";verifique",";kick",";crash",";kill",";killplus",";bring",";jail",";unjail",";freeze",";unfreeze",";adm",";unadm",";tag",";untag",";tag all",";untag all",";float"};
	local needsTarget = {";kick",";crash",";kill",";killplus",";bring",";jail",";unjail",";freeze",";unfreeze",";adm",";unadm",";float"};
	for _, lbl in ipairs(cmds) do
		local FlatIdent_C595 = 0;
		local b;
		while true do
			if (FlatIdent_C595 == 3) then
				b.Text = lbl;
				b.MouseButton1Click:Connect(function()
					local FlatIdent_5AB84 = 0;
					local cmdText;
					local requiresTarget;
					while true do
						if (FlatIdent_5AB84 == 2) then
							pcall(function()
								local FlatIdent_6066D = 0;
								local channel;
								while true do
									if (FlatIdent_6066D == 0) then
										channel = nil;
										if TextChatService:FindFirstChild("TextChannels") then
											channel = TextChatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral") or TextChatService:WaitForChild("TextChannels"):GetChildren()[1];
										end
										FlatIdent_6066D = 1;
									end
									if (FlatIdent_6066D == 1) then
										if channel then
											channel:SendAsync(cmdText);
											if (cmdText == ";verifique") then
												StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] Comando ;verifique enviado com sucesso!",Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
											end
										else
											StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] Erro: Canal de chat não encontrado!",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
										end
										break;
									end
								end
							end);
							break;
						end
						if (FlatIdent_5AB84 == 1) then
							if (requiresTarget and not selectedCmdTarget) then
								StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Selecione um jogador na aba de Comandos!",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
								return;
							end
							if requiresTarget then
								cmdText = lbl .. " " .. selectedCmdTarget;
							end
							FlatIdent_5AB84 = 2;
						end
						if (FlatIdent_5AB84 == 0) then
							cmdText = lbl;
							requiresTarget = table.find(needsTarget, lbl);
							FlatIdent_5AB84 = 1;
						end
					end
				end);
				break;
			end
			if (FlatIdent_C595 == 0) then
				b = Instance.new("TextButton", cmdContainer);
				b.Size = UDim2.new(1, 0, 0, 36);
				FlatIdent_C595 = 1;
			end
			if (FlatIdent_C595 == 1) then
				b.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
				b.TextColor3 = Color3.new(1, 1, 1);
				FlatIdent_C595 = 2;
			end
			if (FlatIdent_C595 == 2) then
				b.Font = Enum.Font.GothamBold;
				b.TextSize = 16;
				FlatIdent_C595 = 3;
			end
		end
	end
	local chatAsLabel = Instance.new("TextLabel", cmdContainer);
	chatAsLabel.Size = UDim2.new(1, 0, 0, 20);
	chatAsLabel.BackgroundTransparency = 1;
	chatAsLabel.TextColor3 = Color3.new(1, 1, 1);
	chatAsLabel.Font = Enum.Font.GothamBold;
	chatAsLabel.Text = "Enviar mensagem como alvo:";
	chatAsLabel.TextXAlignment = Enum.TextXAlignment.Left;
	chatAsLabel.TextSize = 14;
	local txtChatAs = Instance.new("TextBox", cmdContainer);
	txtChatAs.Size = UDim2.new(1, 0, 0, 36);
	txtChatAs.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
	txtChatAs.TextColor3 = Color3.new(1, 1, 1);
	txtChatAs.Font = Enum.Font.Gotham;
	txtChatAs.TextSize = 14;
	txtChatAs.PlaceholderText = "Digite a mensagem aqui...";
	local btnChatAs = Instance.new("TextButton", cmdContainer);
	btnChatAs.Size = UDim2.new(1, 0, 0, 36);
	btnChatAs.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
	btnChatAs.TextColor3 = Color3.new(1, 1, 1);
	btnChatAs.Font = Enum.Font.GothamBold;
	btnChatAs.TextSize = 16;
	btnChatAs.Text = ";ch (Enviar)";
	btnChatAs.MouseButton1Click:Connect(function()
		local msgToSend = txtChatAs.Text;
		if not selectedCmdTarget then
			StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Selecione um jogador alvo primeiro!",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
			return;
		end
		if (msgToSend == "") then
			local FlatIdent_77529 = 0;
			while true do
				if (0 == FlatIdent_77529) then
					StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Digite uma mensagem para enviar!",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
					return;
				end
			end
		end
		local cmdText = ";ch " .. selectedCmdTarget .. " " .. msgToSend;
		pcall(function()
			local channel = nil;
			if TextChatService:FindFirstChild("TextChannels") then
				channel = TextChatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral") or TextChatService:WaitForChild("TextChannels"):GetChildren()[1];
			end
			if channel then
				local FlatIdent_84B7E = 0;
				while true do
					if (FlatIdent_84B7E == 0) then
						channel:SendAsync(cmdText);
						StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] Mensagem enviada como " .. selectedCmdTarget),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
						FlatIdent_84B7E = 1;
					end
					if (1 == FlatIdent_84B7E) then
						txtChatAs.Text = "";
						break;
					end
				end
			else
				StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] Erro: Canal de chat não encontrado!",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
			end
		end);
	end);
	local selectedCopier, selectedAvatarTarget = nil, nil;
	local labelCopier = Instance.new("TextLabel", avatarFrame);
	labelCopier.Text = "👤 Quem vai copiar (Copiador):";
	labelCopier.Font = Enum.Font.GothamBold;
	labelCopier.TextColor3 = Color3.new(1, 1, 1);
	labelCopier.BackgroundTransparency = 1;
	labelCopier.Size = UDim2.new(1, -20, 0, 20);
	labelCopier.TextXAlignment = Enum.TextXAlignment.Left;
	labelCopier.LayoutOrder = 1;
	local ddCopier = Instance.new("TextButton", avatarFrame);
	ddCopier.Name = "DropdownCopier";
	ddCopier.Text = "👇 Selecione o copiador";
	ddCopier.Font = Enum.Font.Gotham;
	ddCopier.TextSize = 14;
	ddCopier.TextColor3 = Color3.new(1, 1, 1);
	ddCopier.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
	ddCopier.Size = UDim2.new(1, -20, 0, 30);
	ddCopier.LayoutOrder = 2;
	local openCopier, frameDDCopier = false, nil;
	ddCopier.MouseButton1Click:Connect(function()
		local FlatIdent_14124 = 0;
		local lst;
		local playersInServer;
		while true do
			if (FlatIdent_14124 == 3) then
				table.sort(playersInServer);
				for _, name in ipairs(playersInServer) do
					local FlatIdent_11AA1 = 0;
					local b;
					while true do
						if (1 == FlatIdent_11AA1) then
							b.Font = Enum.Font.Gotham;
							b.TextSize = 14;
							FlatIdent_11AA1 = 2;
						end
						if (FlatIdent_11AA1 == 0) then
							b = Instance.new("TextButton", frameDDCopier);
							b.Text = name;
							FlatIdent_11AA1 = 1;
						end
						if (FlatIdent_11AA1 == 2) then
							b.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
							b.TextColor3 = Color3.new(1, 1, 1);
							FlatIdent_11AA1 = 3;
						end
						if (FlatIdent_11AA1 == 3) then
							b.Size = UDim2.new(1, 0, 0, 25);
							b.MouseButton1Click:Connect(function()
								local FlatIdent_6F99F = 0;
								while true do
									if (FlatIdent_6F99F == 0) then
										selectedCopier = name;
										ddCopier.Text = "👤 " .. name;
										FlatIdent_6F99F = 1;
									end
									if (FlatIdent_6F99F == 1) then
										frameDDCopier:Destroy();
										openCopier = false;
										break;
									end
								end
							end);
							break;
						end
					end
				end
				openCopier = true;
				break;
			end
			if (FlatIdent_14124 == 2) then
				lst = Instance.new("UIListLayout", frameDDCopier);
				lst.Padding = UDim.new(0, 2);
				playersInServer = {};
				for _, p in ipairs(Players:GetPlayers()) do
					table.insert(playersInServer, p.Name);
				end
				FlatIdent_14124 = 3;
			end
			if (FlatIdent_14124 == 0) then
				if (openCopier and frameDDCopier) then
					frameDDCopier:Destroy();
					openCopier = false;
					return;
				end
				frameDDCopier = Instance.new("ScrollingFrame", avatarFrame);
				frameDDCopier.Position = UDim2.new(0.5, -((avatarFrame.AbsoluteSize.X - 20) / 2), 0, 90);
				frameDDCopier.Size = UDim2.new(1, -20, 0, 120);
				FlatIdent_14124 = 1;
			end
			if (FlatIdent_14124 == 1) then
				frameDDCopier.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
				frameDDCopier.BorderSizePixel = 0;
				frameDDCopier.ClipsDescendants = true;
				frameDDCopier.LayoutOrder = 3;
				FlatIdent_14124 = 2;
			end
		end
	end);
	local labelTarget = Instance.new("TextLabel", avatarFrame);
	labelTarget.Text = "🎯 Copiar avatar de (Alvo):";
	labelTarget.Font = Enum.Font.GothamBold;
	labelTarget.TextColor3 = Color3.new(1, 1, 1);
	labelTarget.BackgroundTransparency = 1;
	labelTarget.Size = UDim2.new(1, -20, 0, 20);
	labelTarget.TextXAlignment = Enum.TextXAlignment.Left;
	labelTarget.LayoutOrder = 4;
	local ddAvatarTarget = Instance.new("TextButton", avatarFrame);
	ddAvatarTarget.Name = "DropdownTarget";
	ddAvatarTarget.Text = "👇 Selecione o alvo";
	ddAvatarTarget.Font = Enum.Font.Gotham;
	ddAvatarTarget.TextSize = 14;
	ddAvatarTarget.TextColor3 = Color3.new(1, 1, 1);
	ddAvatarTarget.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
	ddAvatarTarget.Size = UDim2.new(1, -20, 0, 30);
	ddAvatarTarget.LayoutOrder = 5;
	local openAvatarTarget, frameDDAvatarTarget = false, nil;
	ddAvatarTarget.MouseButton1Click:Connect(function()
		if (openAvatarTarget and frameDDAvatarTarget) then
			local FlatIdent_8A8EC = 0;
			while true do
				if (0 == FlatIdent_8A8EC) then
					frameDDAvatarTarget:Destroy();
					openAvatarTarget = false;
					FlatIdent_8A8EC = 1;
				end
				if (FlatIdent_8A8EC == 1) then
					return;
				end
			end
		end
		frameDDAvatarTarget = Instance.new("ScrollingFrame", avatarFrame);
		frameDDAvatarTarget.Position = UDim2.new(0.5, -((avatarFrame.AbsoluteSize.X - 20) / 2), 0, 180);
		frameDDAvatarTarget.Size = UDim2.new(1, -20, 0, 120);
		frameDDAvatarTarget.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
		frameDDAvatarTarget.BorderSizePixel = 0;
		frameDDAvatarTarget.ClipsDescendants = true;
		frameDDAvatarTarget.LayoutOrder = 6;
		local lst = Instance.new("UIListLayout", frameDDAvatarTarget);
		lst.Padding = UDim.new(0, 2);
		local playersInServer = {};
		for _, p in ipairs(Players:GetPlayers()) do
			table.insert(playersInServer, p.Name);
		end
		table.sort(playersInServer);
		for _, name in ipairs(playersInServer) do
			local FlatIdent_4F2F2 = 0;
			local b;
			while true do
				if (FlatIdent_4F2F2 == 1) then
					b.Font = Enum.Font.Gotham;
					b.TextSize = 14;
					FlatIdent_4F2F2 = 2;
				end
				if (FlatIdent_4F2F2 == 3) then
					b.Size = UDim2.new(1, 0, 0, 25);
					b.MouseButton1Click:Connect(function()
						selectedAvatarTarget = name;
						ddAvatarTarget.Text = "🎯 " .. name;
						frameDDAvatarTarget:Destroy();
						openAvatarTarget = false;
					end);
					break;
				end
				if (FlatIdent_4F2F2 == 0) then
					b = Instance.new("TextButton", frameDDAvatarTarget);
					b.Text = name;
					FlatIdent_4F2F2 = 1;
				end
				if (FlatIdent_4F2F2 == 2) then
					b.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
					b.TextColor3 = Color3.new(1, 1, 1);
					FlatIdent_4F2F2 = 3;
				end
			end
		end
		openAvatarTarget = true;
	end);
	local btnCopyAvatar = Instance.new("TextButton", avatarFrame);
	btnCopyAvatar.Size = UDim2.new(1, -20, 0, 36);
	btnCopyAvatar.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
	btnCopyAvatar.TextColor3 = Color3.new(1, 1, 1);
	btnCopyAvatar.Font = Enum.Font.GothamBold;
	btnCopyAvatar.TextSize = 16;
	btnCopyAvatar.Text = "Copiar Avatar";
	btnCopyAvatar.LayoutOrder = 7;
	btnCopyAvatar.MouseButton1Click:Connect(function()
		local FlatIdent_74B46 = 0;
		local cmdText;
		while true do
			if (FlatIdent_74B46 == 1) then
				pcall(function()
					local FlatIdent_23521 = 0;
					local channel;
					while true do
						if (1 == FlatIdent_23521) then
							if channel then
								channel:SendAsync(cmdText);
							end
							break;
						end
						if (FlatIdent_23521 == 0) then
							channel = nil;
							if TextChatService:FindFirstChild("TextChannels") then
								channel = TextChatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral") or TextChatService:WaitForChild("TextChannels"):GetChildren()[1];
							end
							FlatIdent_23521 = 1;
						end
					end
				end);
				break;
			end
			if (FlatIdent_74B46 == 0) then
				if (not selectedCopier or not selectedAvatarTarget) then
					local FlatIdent_3E44E = 0;
					while true do
						if (FlatIdent_3E44E == 0) then
							StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Selecione o Copiador e o Alvo na aba Avatar!",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
							return;
						end
					end
				end
				cmdText = ";copy " .. selectedAvatarTarget .. " " .. selectedCopier;
				FlatIdent_74B46 = 1;
			end
		end
	end);
	local selectedJumpscareTarget = nil;
	local ddJumpscare = Instance.new("TextButton", terrorFrame);
	ddJumpscare.Name = "DropdownJumpscare";
	ddJumpscare.Text = "🎯 Selecionar jogador";
	ddJumpscare.Font = Enum.Font.Gotham;
	ddJumpscare.TextSize = 14;
	ddJumpscare.TextColor3 = Color3.new(1, 1, 1);
	ddJumpscare.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
	ddJumpscare.Size = UDim2.new(1, -20, 0, 30);
	ddJumpscare.LayoutOrder = 1;
	local openJumpscare = false;
	local frameDDJumpscare = nil;
	ddJumpscare.MouseButton1Click:Connect(function()
		local FlatIdent_974E = 0;
		local lst;
		local playersInServer;
		while true do
			if (FlatIdent_974E == 4) then
				table.sort(playersInServer);
				for _, name in ipairs(playersInServer) do
					local FlatIdent_12E4E = 0;
					local b;
					while true do
						if (1 == FlatIdent_12E4E) then
							b.Font = Enum.Font.Gotham;
							b.TextSize = 14;
							FlatIdent_12E4E = 2;
						end
						if (FlatIdent_12E4E == 2) then
							b.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
							b.TextColor3 = Color3.new(1, 1, 1);
							FlatIdent_12E4E = 3;
						end
						if (FlatIdent_12E4E == 3) then
							b.Size = UDim2.new(1, 0, 0, 25);
							b.MouseButton1Click:Connect(function()
								local FlatIdent_1B5ED = 0;
								while true do
									if (FlatIdent_1B5ED == 0) then
										selectedJumpscareTarget = name;
										ddJumpscare.Text = "🎯 " .. name;
										FlatIdent_1B5ED = 1;
									end
									if (FlatIdent_1B5ED == 1) then
										frameDDJumpscare:Destroy();
										openJumpscare = false;
										break;
									end
								end
							end);
							break;
						end
						if (0 == FlatIdent_12E4E) then
							b = Instance.new("TextButton", frameDDJumpscare);
							b.Text = name;
							FlatIdent_12E4E = 1;
						end
					end
				end
				openJumpscare = true;
				break;
			end
			if (FlatIdent_974E == 0) then
				if (openJumpscare and frameDDJumpscare) then
					frameDDJumpscare:Destroy();
					openJumpscare = false;
					return;
				end
				frameDDJumpscare = Instance.new("ScrollingFrame", terrorFrame);
				frameDDJumpscare.Position = UDim2.new(0.5, -((terrorFrame.AbsoluteSize.X - 20) / 2), 0, 40);
				FlatIdent_974E = 1;
			end
			if (FlatIdent_974E == 2) then
				frameDDJumpscare.ClipsDescendants = true;
				frameDDJumpscare.LayoutOrder = 2;
				lst = Instance.new("UIListLayout", frameDDJumpscare);
				FlatIdent_974E = 3;
			end
			if (FlatIdent_974E == 1) then
				frameDDJumpscare.Size = UDim2.new(1, -20, 0, 120);
				frameDDJumpscare.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
				frameDDJumpscare.BorderSizePixel = 0;
				FlatIdent_974E = 2;
			end
			if (3 == FlatIdent_974E) then
				lst.Padding = UDim.new(0, 2);
				playersInServer = {};
				for _, p in ipairs(Players:GetPlayers()) do
					table.insert(playersInServer, p.Name);
				end
				FlatIdent_974E = 4;
			end
		end
	end);
	for _, jumpscare in ipairs(JUMPSCARES) do
		local FlatIdent_94BA0 = 0;
		local b;
		while true do
			if (FlatIdent_94BA0 == 3) then
				b.Text = jumpscare.Name;
				b.LayoutOrder = 3;
				FlatIdent_94BA0 = 4;
			end
			if (FlatIdent_94BA0 == 4) then
				b.MouseButton1Click:Connect(function()
					if not selectedJumpscareTarget then
						local FlatIdent_C342 = 0;
						while true do
							if (FlatIdent_C342 == 0) then
								StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Selecione um jogador na aba Terror!",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
								return;
							end
						end
					end
					local cmdText = jumpscare.Name .. " " .. selectedJumpscareTarget;
					pcall(function()
						local channel = nil;
						if TextChatService:FindFirstChild("TextChannels") then
							channel = TextChatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral") or TextChatService:WaitForChild("TextChannels"):GetChildren()[1];
						end
						if channel then
							channel:SendAsync(cmdText);
						end
					end);
				end);
				break;
			end
			if (FlatIdent_94BA0 == 2) then
				b.Font = Enum.Font.GothamBold;
				b.TextSize = 16;
				FlatIdent_94BA0 = 3;
			end
			if (0 == FlatIdent_94BA0) then
				b = Instance.new("TextButton", terrorFrame);
				b.Size = UDim2.new(1, -20, 0, 36);
				FlatIdent_94BA0 = 1;
			end
			if (FlatIdent_94BA0 == 1) then
				b.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
				b.TextColor3 = Color3.new(1, 1, 1);
				FlatIdent_94BA0 = 2;
			end
		end
	end
end
local function DestroyAdminUI()
	local FlatIdent_85FF9 = 0;
	local ui;
	while true do
		if (FlatIdent_85FF9 == 0) then
			ui = CoreGui:FindFirstChild("NythAdminUI");
			if (ui and ui.Parent) then
				ui:Destroy();
			end
			break;
		end
	end
end
local function CreateMovableButton()
	local FlatIdent_2E3CE = 0;
	local screenGui;
	local button;
	while true do
		if (FlatIdent_2E3CE == 1) then
			button = Instance.new("ImageButton", screenGui);
			button.Size = UDim2.new(0, 50, 0, 50);
			button.Position = UDim2.new(0, 100, 0, 100);
			button.BackgroundTransparency = 1;
			FlatIdent_2E3CE = 2;
		end
		if (0 == FlatIdent_2E3CE) then
			if CoreGui:FindFirstChild("NythMovableButtonGui") then
				return;
			end
			screenGui = Instance.new("ScreenGui", CoreGui);
			screenGui.Name = "NythMovableButtonGui";
			screenGui.ResetOnSpawn = false;
			FlatIdent_2E3CE = 1;
		end
		if (FlatIdent_2E3CE == 2) then
			button.Image = "rbxassetid://137769737773573";
			button.Active = true;
			button.Draggable = true;
			button.MouseButton1Click:Connect(function()
				local FlatIdent_80652 = 0;
				local ui;
				while true do
					if (FlatIdent_80652 == 0) then
						ui = CoreGui:FindFirstChild("NythAdminUI");
						if ui then
							ui:Destroy();
						else
							CreateAdminUI();
						end
						break;
					end
				end
			end);
			break;
		end
	end
end
local function ExecuteAvatarCopy(targetPlayerName, copierPlayerName)
	if (not IsAutorizado(LocalPlayer.Name) or (copierPlayerName:lower() ~= LocalPlayer.Name:lower())) then
		return false;
	end
	local targetPlayer = Players:FindFirstChild(targetPlayerName);
	local copierPlayer = LocalPlayer;
	if not (targetPlayer and copierPlayer and copierPlayer.Character and targetPlayer.Character) then
		local FlatIdent_2A1A = 0;
		while true do
			if (0 == FlatIdent_2A1A) then
				StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] Não foi possível encontrar os jogadores para copiar o avatar.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
				return false;
			end
		end
	end
	local success = pcall(function()
		local FlatIdent_62CB4 = 0;
		local copierHumanoid;
		local targetHumanoid;
		local copierDesc;
		local targetDesc;
		local argsBody;
		local targetSkinColor;
		local targetBag;
		while true do
			if (FlatIdent_62CB4 == 4) then
				if tonumber(targetDesc.Pants) then
					local FlatIdent_67408 = 0;
					while true do
						if (FlatIdent_67408 == 0) then
							Remotes.Wear:InvokeServer(tonumber(targetDesc.Pants));
							task.wait(0.3);
							break;
						end
					end
				end
				if tonumber(targetDesc.Face) then
					local FlatIdent_79F35 = 0;
					while true do
						if (FlatIdent_79F35 == 0) then
							Remotes.Wear:InvokeServer(tonumber(targetDesc.Face));
							task.wait(0.3);
							break;
						end
					end
				end
				for _, v in ipairs(targetDesc:GetAccessories(true)) do
					if (v.AssetId and tonumber(v.AssetId)) then
						local FlatIdent_C758 = 0;
						while true do
							if (FlatIdent_C758 == 0) then
								Remotes.Wear:InvokeServer(tonumber(v.AssetId));
								task.wait(0.3);
								break;
							end
						end
					end
				end
				FlatIdent_62CB4 = 5;
			end
			if (FlatIdent_62CB4 == 1) then
				for _, acc in ipairs(copierDesc:GetAccessories(true)) do
					if (acc.AssetId and tonumber(acc.AssetId)) then
						Remotes.Wear:InvokeServer(tonumber(acc.AssetId));
						task.wait(0.2);
					end
				end
				if tonumber(copierDesc.Shirt) then
					local FlatIdent_69486 = 0;
					while true do
						if (FlatIdent_69486 == 0) then
							Remotes.Wear:InvokeServer(tonumber(copierDesc.Shirt));
							task.wait(0.2);
							break;
						end
					end
				end
				if tonumber(copierDesc.Pants) then
					Remotes.Wear:InvokeServer(tonumber(copierDesc.Pants));
					task.wait(0.2);
				end
				FlatIdent_62CB4 = 2;
			end
			if (FlatIdent_62CB4 == 0) then
				copierHumanoid = copierPlayer.Character:WaitForChild("Humanoid");
				targetHumanoid = targetPlayer.Character:WaitForChild("Humanoid");
				copierDesc = copierHumanoid:GetAppliedDescription();
				FlatIdent_62CB4 = 1;
			end
			if (FlatIdent_62CB4 == 7) then
				return true;
			end
			if (FlatIdent_62CB4 == 6) then
				targetBag = targetPlayer:FindFirstChild("PlayersBag");
				if targetBag then
					local FlatIdent_2F3FA = 0;
					while true do
						if (FlatIdent_2F3FA == 0) then
							if (targetBag:FindFirstChild("RPName") and (targetBag.RPName.Value ~= "")) then
								Remotes.RPNameText:FireServer("RolePlayName", targetBag.RPName.Value);
								task.wait(0.3);
							end
							if (targetBag:FindFirstChild("RPBio") and (targetBag.RPBio.Value ~= "")) then
								local FlatIdent_25747 = 0;
								while true do
									if (FlatIdent_25747 == 0) then
										Remotes.RPNameText:FireServer("RolePlayBio", targetBag.RPBio.Value);
										task.wait(0.3);
										break;
									end
								end
							end
							FlatIdent_2F3FA = 1;
						end
						if (1 == FlatIdent_2F3FA) then
							if targetBag:FindFirstChild("RPNameColor") then
								local FlatIdent_90271 = 0;
								while true do
									if (FlatIdent_90271 == 0) then
										Remotes.RPNameColor:FireServer("PickingRPNameColor", targetBag.RPNameColor.Value);
										task.wait(0.3);
										break;
									end
								end
							end
							if targetBag:FindFirstChild("RPBioColor") then
								local FlatIdent_1C534 = 0;
								while true do
									if (FlatIdent_1C534 == 0) then
										Remotes.RPNameColor:FireServer("PickingRPBioColor", targetBag.RPBioColor.Value);
										task.wait(0.3);
										break;
									end
								end
							end
							break;
						end
					end
				end
				StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] Avatar copiado com sucesso!",Color=Color3.fromRGB(255, 105, 180),Font=Enum.Font.GothamBold});
				FlatIdent_62CB4 = 7;
			end
			if (FlatIdent_62CB4 == 5) then
				targetSkinColor = targetPlayer.Character:FindFirstChild("Body Colors");
				if targetSkinColor then
					local FlatIdent_602BB = 0;
					while true do
						if (FlatIdent_602BB == 0) then
							Remotes.ChangeBodyColor:FireServer(tostring(targetSkinColor.HeadColor));
							task.wait(0.3);
							break;
						end
					end
				end
				if tonumber(targetDesc.IdleAnimation) then
					local FlatIdent_6038 = 0;
					while true do
						if (FlatIdent_6038 == 0) then
							Remotes.Wear:InvokeServer(tonumber(targetDesc.IdleAnimation));
							task.wait(0.3);
							break;
						end
					end
				end
				FlatIdent_62CB4 = 6;
			end
			if (FlatIdent_62CB4 == 2) then
				if tonumber(copierDesc.Face) then
					local FlatIdent_185A5 = 0;
					while true do
						if (0 == FlatIdent_185A5) then
							Remotes.Wear:InvokeServer(tonumber(copierDesc.Face));
							task.wait(0.2);
							break;
						end
					end
				end
				targetDesc = targetHumanoid:GetAppliedDescription();
				argsBody = {[1]={[1]=targetDesc.Torso,[2]=targetDesc.RightArm,[3]=targetDesc.LeftArm,[4]=targetDesc.RightLeg,[5]=targetDesc.LeftLeg,[6]=targetDesc.Head}};
				FlatIdent_62CB4 = 3;
			end
			if (3 == FlatIdent_62CB4) then
				Remotes.ChangeCharacterBody:InvokeServer(unpack(argsBody));
				task.wait(0.5);
				if tonumber(targetDesc.Shirt) then
					local FlatIdent_4CEEC = 0;
					while true do
						if (FlatIdent_4CEEC == 0) then
							Remotes.Wear:InvokeServer(tonumber(targetDesc.Shirt));
							task.wait(0.3);
							break;
						end
					end
				end
				FlatIdent_62CB4 = 4;
			end
		end
	end);
	return success;
end
local function findPlayerByPartialName(partialName)
	if (not partialName or (partialName == "")) then
		return nil;
	end
	local lowerPartialName = partialName:lower():gsub("%s+", "");
	for _, p in ipairs(Players:GetPlayers()) do
		if (p.Name:lower():find(lowerPartialName, 1, true) or p.DisplayName:lower():find(lowerPartialName, 1, true)) then
			return p;
		end
	end
	return nil;
end
local function analisarChatDe(chatter, message)
	local msg = message:lower():gsub("%s+", " ");
	local args = {};
	for word in msg:gmatch("%S+") do
		table.insert(args, word);
	end
	if (msg == ";verifique") then
		local FlatIdent_5B476 = 0;
		while true do
			if (FlatIdent_5B476 == 0) then
				if not IsAutorizado(chatter.Name) then
					local FlatIdent_2E7F5 = 0;
					while true do
						if (FlatIdent_2E7F5 == 0) then
							if (chatter == LocalPlayer) then
								StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Você não tem permissão para usar ;verifique.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
							end
							return;
						end
					end
				end
				StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] Comando ;verifique detectado de " .. chatter.Name),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
				FlatIdent_5B476 = 1;
			end
			if (FlatIdent_5B476 == 1) then
				if not IsAutorizado(LocalPlayer.Name) then
					task.delay(math.random(0.1, 0.8), function()
						pcall(function()
							local FlatIdent_1F1FE = 0;
							local channel;
							while true do
								if (FlatIdent_1F1FE == 0) then
									channel = nil;
									if TextChatService:FindFirstChild("TextChannels") then
										channel = TextChatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral") or TextChatService:WaitForChild("TextChannels"):GetChildren()[1];
									end
									FlatIdent_1F1FE = 1;
								end
								if (FlatIdent_1F1FE == 1) then
									if channel then
										local FlatIdent_6FF03 = 0;
										while true do
											if (FlatIdent_6FF03 == 0) then
												channel:SendAsync("Nytherune_####");
												StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] " .. LocalPlayer.Name .. " respondeu com Nytherune_####"),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
												break;
											end
										end
									end
									break;
								end
							end
						end);
					end);
				end
				return;
			end
		end
	end
	if (msg == "nytherune_####") then
		local FlatIdent_6BDA4 = 0;
		while true do
			if (FlatIdent_6BDA4 == 0) then
				NYTHERUNE_USERS[chatter.Name] = true;
				StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] " .. chatter.Name .. " identificado como Usuário Nytherune"),Color=Color3.fromRGB(255, 105, 180),Font=Enum.Font.GothamBold});
				FlatIdent_6BDA4 = 1;
			end
			if (FlatIdent_6BDA4 == 1) then
				return;
			end
		end
	end
	if not IsAutorizado(chatter.Name) then
		local FlatIdent_D895 = 0;
		while true do
			if (FlatIdent_D895 == 0) then
				if (chatter == LocalPlayer) then
					StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Você não tem permissão para usar este comando.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
				end
				return;
			end
		end
	end
	if ((args[1] == ";ch") and (#args >= 3)) then
		local targetPartialName = args[2];
		local messageToSend = table.concat(args, " ", 3);
		local targetPlayer = findPlayerByPartialName(targetPartialName);
		if (targetPlayer and (targetPlayer == LocalPlayer) and (messageToSend ~= "")) then
			pcall(function()
				local channel = nil;
				if TextChatService:FindFirstChild("TextChannels") then
					channel = TextChatService:WaitForChild("TextChannels"):FindFirstChild("RBXGeneral") or TextChatService:WaitForChild("TextChannels"):GetChildren()[1];
				end
				if channel then
					channel:SendAsync(messageToSend);
					StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] Mensagem enviada como " .. targetPlayer.Name),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
				end
			end);
		elseif (chatter == LocalPlayer) then
			StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Jogador alvo não encontrado ou mensagem inválida.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
		end
		return;
	end
	if ((args[1] == ";copy") and (#args == 3)) then
		local FlatIdent_60344 = 0;
		local partialTarget;
		local partialCopier;
		local targetPlayer;
		local copierPlayer;
		while true do
			if (FlatIdent_60344 == 1) then
				targetPlayer = findPlayerByPartialName(partialTarget);
				copierPlayer = findPlayerByPartialName(partialCopier);
				FlatIdent_60344 = 2;
			end
			if (FlatIdent_60344 == 0) then
				partialTarget = args[2];
				partialCopier = args[3];
				FlatIdent_60344 = 1;
			end
			if (FlatIdent_60344 == 2) then
				if (targetPlayer and copierPlayer) then
					if (ExecuteAvatarCopy(targetPlayer.Name, copierPlayer.Name) and (chatter == LocalPlayer)) then
						StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] Avatar copiado de " .. targetPlayer.Name .. " para " .. copierPlayer.Name),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
					end
				elseif (chatter == LocalPlayer) then
					StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Jogador alvo ou copiador não encontrado.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
				end
				return;
			end
		end
	end
	for _, jumpscare in ipairs(JUMPSCARES) do
		if ((args[1] == jumpscare.Name) and (#args == 2)) then
			local FlatIdent_11D04 = 0;
			local targetPlayer;
			while true do
				if (FlatIdent_11D04 == 1) then
					return;
				end
				if (FlatIdent_11D04 == 0) then
					targetPlayer = findPlayerByPartialName(args[2]);
					if targetPlayer then
						if (TriggerJumpscare(targetPlayer, jumpscare) and (chatter == LocalPlayer)) then
							StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] " .. jumpscare.Name .. " acionado em " .. targetPlayer.Name),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
						end
					elseif (chatter == LocalPlayer) then
						StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Jogador alvo não encontrado.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
					end
					FlatIdent_11D04 = 1;
				end
			end
		end
	end
	local targetCommands = {";kick",";crash",";kill",";killplus",";bring",";jail",";unjail",";freeze",";unfreeze",";adm",";unadm",";float"};
	if (table.find(targetCommands, args[1]) and (#args == 2)) then
		local targetPlayer = findPlayerByPartialName(args[2]);
		if not targetPlayer then
			if (chatter == LocalPlayer) then
				StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Jogador alvo não encontrado.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
			end
			return;
		end
		local success = false;
		if (args[1] == ";jail") then
			success = CreateAndManageJail(targetPlayer);
		elseif (args[1] == ";unjail") then
			success = RemoveJail(targetPlayer);
		elseif (args[1] == ";freeze") then
			success = FreezePlayer(targetPlayer);
		elseif (args[1] == ";unfreeze") then
			success = UnfreezePlayer(targetPlayer);
		elseif ((args[1] == ";adm") and IsDono(chatter.Name)) then
			TEMP_MODS[targetPlayer.Name] = true;
			success = true;
			if (targetPlayer == LocalPlayer) then
				local FlatIdent_4185D = 0;
				while true do
					if (FlatIdent_4185D == 0) then
						CreateAdminUI();
						CreateMovableButton();
						break;
					end
				end
			end
		elseif ((args[1] == ";unadm") and IsDono(chatter.Name)) then
			local FlatIdent_4FBC5 = 0;
			while true do
				if (FlatIdent_4FBC5 == 1) then
					if (targetPlayer == LocalPlayer) then
						local FlatIdent_4609C = 0;
						local btnGui;
						while true do
							if (FlatIdent_4609C == 0) then
								DestroyAdminUI();
								btnGui = CoreGui:FindFirstChild("NythMovableButtonGui");
								FlatIdent_4609C = 1;
							end
							if (FlatIdent_4609C == 1) then
								if btnGui then
									btnGui:Destroy();
								end
								break;
							end
						end
					end
					break;
				end
				if (0 == FlatIdent_4FBC5) then
					TEMP_MODS[targetPlayer.Name] = nil;
					success = true;
					FlatIdent_4FBC5 = 1;
				end
			end
		elseif (args[1] == ";kick") then
			local FlatIdent_28DC7 = 0;
			while true do
				if (FlatIdent_28DC7 == 0) then
					if ((targetPlayer == LocalPlayer) and IsDono(LocalPlayer.Name) and not IsDono(chatter.Name)) then
						if (chatter == LocalPlayer) then
							StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] ❌ Você não pode expulsar um dono.",Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
						end
						return;
					end
					targetPlayer:Kick("Você foi removido pelos seus atos --equipe Nytherune");
					FlatIdent_28DC7 = 1;
				end
				if (FlatIdent_28DC7 == 1) then
					success = true;
					break;
				end
			end
		elseif (args[1] == ";kill") then
			if (targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid")) then
				local FlatIdent_1D0A6 = 0;
				while true do
					if (FlatIdent_1D0A6 == 0) then
						targetPlayer.Character.Humanoid.Health = 0;
						success = true;
						break;
					end
				end
			end
		elseif (args[1] == ";killplus") then
			success = KillPlus(targetPlayer);
		elseif (args[1] == ";bring") then
			if (chatter.Character and chatter.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")) then
				local FlatIdent_63284 = 0;
				while true do
					if (FlatIdent_63284 == 0) then
						targetPlayer.Character:SetPrimaryPartCFrame(chatter.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5));
						success = true;
						break;
					end
				end
			end
		elseif (args[1] == ";crash") then
			local FlatIdent_74EA4 = 0;
			while true do
				if (FlatIdent_74EA4 == 0) then
					if (targetPlayer == LocalPlayer) then
						while true do
							Instance.new("Part");
						end
					end
					success = true;
					break;
				end
			end
		elseif (args[1] == ";float") then
			success = FloatPlayer(targetPlayer);
		end
		if ((chatter == LocalPlayer) and success) then
			StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] " .. args[1] .. " executado com sucesso em " .. ((targetPlayer and targetPlayer.Name) or "unknown")),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
		elseif (chatter == LocalPlayer) then
			StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] ❌ Falha ao executar " .. args[1] .. " em " .. targetPlayer.Name .. ". Verifique se o jogador está no jogo."),Color=Color3.fromRGB(255, 100, 100),Font=Enum.Font.GothamBold});
		end
		return;
	end
	if (msg == ";untag all") then
		tagsVisiveis = false;
		StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] Todas as tags removidas.",Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
		return;
	end
	if (msg == ";tag all") then
		local FlatIdent_84C31 = 0;
		while true do
			if (0 == FlatIdent_84C31) then
				tagsVisiveis = true;
				StarterGui:SetCore("ChatMakeSystemMessage", {Text="[Nytherune Hub] Todas as tags restauradas.",Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
				FlatIdent_84C31 = 1;
			end
			if (FlatIdent_84C31 == 1) then
				return;
			end
		end
	end
	if ((msg == ";untag") and (chatter == LocalPlayer)) then
		local FlatIdent_4BEE8 = 0;
		while true do
			if (FlatIdent_4BEE8 == 0) then
				tagsVisiveis = false;
				StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] Tags removidas para " .. LocalPlayer.Name),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
				FlatIdent_4BEE8 = 1;
			end
			if (FlatIdent_4BEE8 == 1) then
				return;
			end
		end
	end
	if ((msg == ";tag") and (chatter == LocalPlayer)) then
		tagsVisiveis = true;
		StarterGui:SetCore("ChatMakeSystemMessage", {Text=("[Nytherune Hub] Tags restauradas para " .. LocalPlayer.Name),Color=Color3.fromRGB(0, 255, 0),Font=Enum.Font.GothamBold});
		return;
	end
end
for _, player in ipairs(Players:GetPlayers()) do
	player.Chatted:Connect(function(message)
		analisarChatDe(player, message);
	end);
end
Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		analisarChatDe(player, message);
	end);
end);
local tags = {};
local function CriarTag(txt, c1, c2)
	local g = Instance.new("BillboardGui");
	g.Size = UDim2.new(0, 180, 0, 30);
	g.StudsOffset = Vector3.new(0, 2.5, 0);
	g.AlwaysOnTop = true;
	local f = Instance.new("Frame", g);
	f.Size = UDim2.new(1, 0, 1, 0);
	f.BackgroundColor3 = Color3.new(0, 0, 0);
	f.BackgroundTransparency = 0.3;
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8);
	local l = Instance.new("TextLabel", f);
	l.Size = UDim2.new(1, 0, 1, 0);
	l.BackgroundTransparency = 1;
	l.Text = txt;
	l.Font = Enum.Font.GothamBold;
	l.TextScaled = true;
	l.TextStrokeTransparency = 0.5;
	l.TextColor3 = c1;
	coroutine.wrap(function()
		while g.Parent do
			l.TextColor3 = c1;
			task.wait(0.5);
			l.TextColor3 = c2;
			task.wait(0.5);
		end
	end)();
	return g;
end
task.spawn(function()
	while task.wait(1) do
		if not tagsVisiveis then
			for p, tagGui in pairs(tags) do
				local FlatIdent_4FAC8 = 0;
				while true do
					if (FlatIdent_4FAC8 == 0) then
						if (tagGui and tagGui.Parent) then
							tagGui:Destroy();
						end
						tags[p] = nil;
						break;
					end
				end
			end
			while not tagsVisiveis do
				task.wait(1);
			end
		end
		for _, p in ipairs(Players:GetPlayers()) do
			if ((p ~= LocalPlayer) and p.Character and p.Character:FindFirstChild("Head")) then
				local FlatIdent_9010 = 0;
				local root;
				local head;
				while true do
					if (FlatIdent_9010 == 1) then
						if root then
							local FlatIdent_5062 = 0;
							local d;
							while true do
								if (0 == FlatIdent_5062) then
									d = (root.Position - head.Position).Magnitude;
									if ((d <= 25) and not tags[p]) then
										local FlatIdent_439F8 = 0;
										local tag;
										while true do
											if (1 == FlatIdent_439F8) then
												if tag then
													local FlatIdent_40D0 = 0;
													while true do
														if (FlatIdent_40D0 == 0) then
															tag.Adornee = head;
															tag.Parent = p.Character;
															FlatIdent_40D0 = 1;
														end
														if (1 == FlatIdent_40D0) then
															tags[p] = tag;
															break;
														end
													end
												end
												break;
											end
											if (FlatIdent_439F8 == 0) then
												tag = nil;
												if IsDono(p.Name) then
													tag = CriarTag("Dono Nytherune", Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 60, 60));
												elseif (IsMod(p.Name) or IsTempMod(p.Name)) then
													tag = CriarTag("Moderador Nytherune", Color3.fromRGB(0, 191, 255), Color3.fromRGB(255, 105, 180));
												elseif NYTHERUNE_USERS[p.Name] then
													tag = CriarTag("Usuário Nytherune", Color3.new(1, 1, 1), Color3.new(0.78, 0.78, 0.78));
												end
												FlatIdent_439F8 = 1;
											end
										end
									elseif (((d > 30) or not p.Parent) and tags[p]) then
										tags[p]:Destroy();
										tags[p] = nil;
									end
									break;
								end
							end
						elseif (not p.Parent and tags[p]) then
							local FlatIdent_9917B = 0;
							while true do
								if (FlatIdent_9917B == 0) then
									tags[p]:Destroy();
									tags[p] = nil;
									break;
								end
							end
						end
						break;
					end
					if (FlatIdent_9010 == 0) then
						root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
						head = p.Character.Head;
						FlatIdent_9010 = 1;
					end
				end
			end
		end
	end
end);
if IsAutorizado(LocalPlayer.Name) then
	local FlatIdent_89311 = 0;
	while true do
		if (FlatIdent_89311 == 0) then
			CreateAdminUI();
			CreateMovableButton();
			break;
		end
	end
end