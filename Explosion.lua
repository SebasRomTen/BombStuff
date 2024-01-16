local tw = game:GetService("TweenService")
local debris = game:GetService("Debris")

local MisL : "Library" = loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/SebasRomTen/MisL/main/source.lua"))()


local function tween(instance, timE, style, direction, properties)
	return tw:Create(instance, TweenInfo.new(timE, style, direction), properties)
end

local function decimate(part : BasePart, color)
	local Code = coroutine.wrap(function()
		if part:IsA("BasePart") then
			local s, e = pcall(function()
				if part.Parent:FindFirstChildOfClass("Humanoid") then
					debris:AddItem(part.Parent:FindFirstChildOfClass("Humanoid"))
				elseif part.Parent.Parent:FindFirstChild("Humanoid") and part.Parent.Parent:FindFirstChild("Humanoid"):IsA("Humanoid") then
					debris:AddItem(part.Parent.Parent:FindFirstChildOfClass("Humanoid"))
				else
					return
				end
			end)
			local basecf = part.CFrame
			local basesz = part.Size
			
			local v1 = math.rad(math.random(-360, 360))
			local v2 = math.rad(math.random(-360, 360))
			local v3 = math.rad(math.random(-360, 360))
			
			local v4 = math.rad(math.random(-360, 360))
			local v5 = math.rad(math.random(-360, 360))
			local v6 = math.rad(math.random(-360, 360))
			
			local cf1 = math.random(-36, 36)
			local cf2 = math.random(-36, 36)
			local cf3 = math.random(-36, 36)
			
			local cf4 = math.random(-7, 7)
			local cf5 = math.random(-7, 7)
			local cf6 = math.random(-7, 7)

			part.Name = tostring(v1..v2..v3)
			part.Anchored = true
			part.CanCollide = false
			part.Material = Enum.Material.Neon
			part.Color = color or Color3.fromRGB(255, 255, 255)
			
			local X, Y, Z = part.Size.X*6, part.Size.Y*6, part.Size.Z*6
			tween(part, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 
				{
					Size = Vector3.new(X, Y, Z),
					Transparency = 1,
					CFrame = basecf * CFrame.Angles(v1, v2, v3) * CFrame.new(cf1, cf2, cf3)}
			):Play()
			
			wait(0.65)
			tween(part, 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {
				Transparency = 0,
				Size = basesz,
				CFrame = part.CFrame * CFrame.new(cf4, cf5, cf6)
			}):Play()
			wait(0.4)
			
			tween(part, 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 
				{
					Size = Vector3.new(), 
					Transparency = 1, 
					CFrame = basecf * CFrame.Angles(v4, v5, v6)}
			):Play()
			wait(0.85)
			
			debris:AddItem(part)
		end
	end) Code()
end

local explosions = {}

explosions.Explode = function(part : BasePart, ExplosionSize : Vector3, Color, t)
	local MainExplosion = Instance.new("Part", part)
	MainExplosion.Shape = Enum.PartType.Ball
	MainExplosion.Material = Enum.Material.Neon
	MainExplosion.Size = Vector3.new(1.5, 1.5, 1.5)
	MainExplosion.Name = "Boom"
	MainExplosion.Color = Color or Color3.fromRGB(165, 165, 165)
	MainExplosion.Anchored = true
	MainExplosion.CanCollide = false
	MainExplosion.CFrame = part.CFrame
	
	
	MainExplosion.Touched:Connect(function(p)
		local a = coroutine.wrap(function()
			if p.Name == ("Baseplate" or "Base") and (p.Size.X >= 1000 and p.Size.Z >= 100) then
				return
			else
				for n, part in pairs(p:FindFirstAncestorOfClass("Model"):GetDescendants()) do
					if part:IsA("BasePart") then
						local Boom = MisL.newScript("", "server", part)
						Boom.Name = "Boom"
						decimate(part, Color)
					elseif part:IsA("Decal") then
						part.Transparency = 1
					elseif part:IsA("ShirtGraphic") then
						part:Destroy()
					end
				end
			end
		end) a()
	end)
	tween(MainExplosion, t or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {Size = ExplosionSize or Vector3.new(9, 9, 9)}):Play()
	wait(0.3)
	tween(MainExplosion, 1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, {Transparency = 1}):Play()
	wait(1)
	debris:AddItem(MainExplosion)
	wait(.5)
	debris:AddItem(script)
end
explosions.Explode(owner.Character.HumanoidRootPart, Vector3.new(10, 10, 10), Color3.new(1, 1, 1))
