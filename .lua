local Library = {}
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local HS = game:GetService("HttpService")
local TxtS = game:GetService("TextService")
local CG = game:GetService("CoreGui")
local Plrs = game:GetService("Players")
local LP = Plrs.LocalPlayer
local Mouse = LP:GetMouse()
local Stats = game:GetService("Stats")

local CurrentFPS = 60
local Frames = 0
local LastTick = os.clock()

RS.Heartbeat:Connect(function()
    Frames = Frames + 1
    local Now = os.clock()
    if Now - LastTick >= 1 then
        CurrentFPS = Frames
        Frames = 0
        LastTick = Now
    end
end)

local NetworkStats = Stats:FindFirstChild("Network")
local ServerStats = NetworkStats and NetworkStats:FindFirstChild("ServerStatsItem")
local DataPing = ServerStats and ServerStats:FindFirstChild("Data Ping")

local KeyMap = {
    Zero = "0", One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9",
    KeypadZero = "0", KeypadOne = "1", KeypadTwo = "2", KeypadThree = "3", KeypadFour = "4", KeypadFive = "5", KeypadSix = "6", KeypadSeven = "7", KeypadEight = "8", KeypadNine = "9"
}

Library.Flags = {}
Library.Items = {}
Library.TextObjects = {} 
Library.GradientObjects = {} 
Library.CornerObjects = {}
Library.ThemeObjects = {     
    Main = {},
    Second = {},
    Accent = {},
    ElementAccent = {},
    Text = {},
    TextDark = {},
    Toggles = {},
    TabLabels = {},
    Keybinds = {}
}

Library.ThemeFolder = "SolarisUI-Themes"

local AvailableFonts = {
    "Gotham", "GothamBold", "SourceSans", "SourceSansBold", 
    "Oswald", "Roboto", "RobotoMono", "Sarpanch", "Code", "AmaticSC",
    "FredokaOne", "Jura", "Arcade", "SciFi", "Ubuntu", "Arial",
    "Cartoon", "Highway", "Bodoni", "Garamond", "Nunito"
}

Library.GlobalFont = Enum.Font.Gotham
Library.GlobalFontBold = Enum.Font.GothamBold
Library.GlobalCornerValue = 10

local Themes = {
    Default = {
        Main = Color3.fromRGB(25, 25, 30),
        Second = Color3.fromRGB(35, 35, 40),
        Accent = Color3.fromRGB(255, 255, 255),
        ElementAccent = Color3.fromRGB(0, 160, 255),
        GradientStart = Color3.fromRGB(255, 255, 255),
        GradientEnd = Color3.fromRGB(200, 200, 200),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(170, 170, 170),
        Error = Color3.fromRGB(255, 60, 60),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Blood = {
        Main = Color3.fromRGB(20, 15, 15),
        Second = Color3.fromRGB(30, 20, 20),
        Accent = Color3.fromRGB(220, 40, 40),
        ElementAccent = Color3.fromRGB(220, 40, 40),
        GradientStart = Color3.fromRGB(255, 0, 0),
        GradientEnd = Color3.fromRGB(150, 0, 0),
        Text = Color3.fromRGB(255, 240, 240),
        TextDark = Color3.fromRGB(170, 120, 120),
        Error = Color3.fromRGB(255, 0, 0),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Purple = {
        Main = Color3.fromRGB(20, 15, 25),
        Second = Color3.fromRGB(30, 25, 40),
        Accent = Color3.fromRGB(160, 80, 255),
        ElementAccent = Color3.fromRGB(160, 80, 255),
        GradientStart = Color3.fromRGB(140, 0, 255),
        GradientEnd = Color3.fromRGB(255, 0, 255),
        Text = Color3.fromRGB(240, 230, 255),
        TextDark = Color3.fromRGB(160, 140, 190),
        Error = Color3.fromRGB(255, 0, 100),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Abyss = {
        Main = Color3.fromRGB(20, 15, 25),
        Second = Color3.fromRGB(30, 25, 40),
        Accent = Color3.fromRGB(100, 0, 255),
        ElementAccent = Color3.fromRGB(100, 0, 255),
        GradientStart = Color3.fromRGB(80, 0, 200),
        GradientEnd = Color3.fromRGB(120, 50, 255),
        Text = Color3.fromRGB(240, 230, 255),
        TextDark = Color3.fromRGB(160, 140, 190),
        Error = Color3.fromRGB(255, 0, 100),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Ocean = {
        Main = Color3.fromRGB(15, 25, 35),
        Second = Color3.fromRGB(25, 35, 45),
        Accent = Color3.fromRGB(0, 255, 200),
        ElementAccent = Color3.fromRGB(0, 255, 200),
        GradientStart = Color3.fromRGB(0, 200, 255),
        GradientEnd = Color3.fromRGB(0, 255, 150),
        Text = Color3.fromRGB(220, 255, 255),
        TextDark = Color3.fromRGB(120, 170, 170),
        Error = Color3.fromRGB(255, 80, 80),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Toxic = {
        Main = Color3.fromRGB(10, 20, 10),
        Second = Color3.fromRGB(20, 30, 20),
        Accent = Color3.fromRGB(50, 255, 100),
        ElementAccent = Color3.fromRGB(50, 255, 100),
        GradientStart = Color3.fromRGB(0, 255, 0),
        GradientEnd = Color3.fromRGB(150, 255, 150),
        Text = Color3.fromRGB(220, 255, 220),
        TextDark = Color3.fromRGB(120, 170, 170),
        Error = Color3.fromRGB(255, 50, 50),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Sunrise = {
        Main = Color3.fromRGB(30, 20, 15),
        Second = Color3.fromRGB(40, 30, 25),
        Accent = Color3.fromRGB(255, 150, 0),
        ElementAccent = Color3.fromRGB(255, 150, 0),
        GradientStart = Color3.fromRGB(255, 100, 0),
        GradientEnd = Color3.fromRGB(255, 200, 0),
        Text = Color3.fromRGB(255, 240, 230),
        TextDark = Color3.fromRGB(170, 140, 120),
        Error = Color3.fromRGB(255, 0, 0),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Vaporwave = {
        Main = Color3.fromRGB(30, 20, 35),
        Second = Color3.fromRGB(45, 30, 50),
        Accent = Color3.fromRGB(255, 100, 200),
        ElementAccent = Color3.fromRGB(255, 100, 200),
        GradientStart = Color3.fromRGB(255, 0, 255),
        GradientEnd = Color3.fromRGB(0, 255, 255),
        Text = Color3.fromRGB(255, 230, 255),
        TextDark = Color3.fromRGB(170, 120, 170),
        Error = Color3.fromRGB(255, 50, 100),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Gold = {
        Main = Color3.fromRGB(25, 20, 10),
        Second = Color3.fromRGB(35, 30, 20),
        Accent = Color3.fromRGB(255, 200, 50),
        ElementAccent = Color3.fromRGB(255, 200, 50),
        GradientStart = Color3.fromRGB(255, 215, 0),
        GradientEnd = Color3.fromRGB(255, 150, 0),
        Text = Color3.fromRGB(255, 250, 220),
        TextDark = Color3.fromRGB(170, 160, 120),
        Error = Color3.fromRGB(255, 50, 50),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Orange = {
        Main = Color3.fromRGB(20, 20, 20),
        Second = Color3.fromRGB(35, 30, 25),
        Accent = Color3.fromRGB(218, 165, 32),
        ElementAccent = Color3.fromRGB(218, 165, 32),
        GradientStart = Color3.fromRGB(255, 215, 0),
        GradientEnd = Color3.fromRGB(184, 134, 11),
        Text = Color3.fromRGB(255, 250, 220),
        TextDark = Color3.fromRGB(170, 160, 120),
        Error = Color3.fromRGB(255, 50, 50),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Mint = {
        Main = Color3.fromRGB(20, 25, 25),
        Second = Color3.fromRGB(30, 35, 35),
        Accent = Color3.fromRGB(100, 255, 180),
        ElementAccent = Color3.fromRGB(100, 255, 180),
        GradientStart = Color3.fromRGB(50, 200, 120),
        GradientEnd = Color3.fromRGB(150, 255, 200),
        Text = Color3.fromRGB(230, 255, 240),
        TextDark = Color3.fromRGB(120, 160, 140),
        Error = Color3.fromRGB(255, 80, 80),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Night = {
        Main = Color3.fromRGB(10, 10, 20),
        Second = Color3.fromRGB(20, 20, 35),
        Accent = Color3.fromRGB(80, 120, 255),
        ElementAccent = Color3.fromRGB(80, 120, 255),
        GradientStart = Color3.fromRGB(50, 50, 255),
        GradientEnd = Color3.fromRGB(150, 150, 255),
        Text = Color3.fromRGB(230, 230, 255),
        TextDark = Color3.fromRGB(100, 120, 160),
        Error = Color3.fromRGB(255, 80, 80),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    },
    Void = {
        Main = Color3.fromRGB(12, 12, 12),
        Second = Color3.fromRGB(22, 22, 22),
        Accent = Color3.fromRGB(220, 220, 220),
        ElementAccent = Color3.fromRGB(220, 220, 220),
        GradientStart = Color3.fromRGB(150, 150, 150),
        GradientEnd = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(240, 240, 240),
        TextDark = Color3.fromRGB(120, 120, 120),
        Error = Color3.fromRGB(255, 100, 100),
        Transparency = 0.25,
        ImageTransparency = 0,
        OrbsTransparency = 0.90,
        Font = "Gotham",
        Background = ""
    }
}

local function GetGradientSeq(theme)
    local startC = theme.GradientStart or theme.Accent
    local endC = theme.GradientEnd or theme.Accent
    return ColorSequence.new{
        ColorSequenceKeypoint.new(0, startC), 
        ColorSequenceKeypoint.new(1, endC)
    }
end

for _, t in pairs(Themes) do
    if not t.Gradient then
        t.Gradient = GetGradientSeq(t)
    end
    if not t.ElementAccent then
        t.ElementAccent = t.Accent
    end
    if not t.Font then
        t.Font = "Gotham"
    end
end

local function GetAssetId(id)
    if not id or id == "" then
        return ""
    end
    local str = tostring(id)
    if str:find("rbxasset://") or str:find("rbxthumb://") or str:find("rbxassetid://") then
        return str
    end
    local num = str:match("%d+")
    if num then
        return "rbxassetid://" .. num
    end
    return ""
end

local function SetImageAsync(instance, property, idStr)
    local parsedId = GetAssetId(idStr)
    if parsedId == "" then
        instance[property] = ""
        return
    end
    
    instance[property] = parsedId
    
    if parsedId:find("rbxassetid://") then
        task.spawn(function()
            local success, result = pcall(function()
                return game:GetObjects(parsedId)[1]
            end)
            if success and result and result:IsA("Decal") then
                if instance.Parent then
                    instance[property] = result.Texture
                end
            end
        end)
    end
end

local function GetTheme(cfg)
    if type(cfg) == "table" then 
        local mapped = {}
        mapped.Main = cfg["Main color"] or cfg.Main
        mapped.Second = cfg["SecondColor"] or cfg.Second
        mapped.Accent = cfg["AccentColor"] or cfg.Accent
        mapped.ElementAccent = cfg["ElementColor"] or cfg.ElementAccent
        mapped.Text = cfg["TextColor"] or cfg.Text
        mapped.GradientStart = cfg["GradientStart"] or mapped.Accent
        mapped.GradientEnd = cfg["GradientEnd"] or mapped.Accent
        
        if cfg["BGTransparency"] then
            mapped.Transparency = tonumber(cfg["BGTransparency"]) / 100 
        else
            mapped.Transparency = cfg.Transparency
        end
        
        if cfg["ImageTransparency"] then
            mapped.ImageTransparency = tonumber(cfg["ImageTransparency"]) / 100
        else
            mapped.ImageTransparency = cfg.ImageTransparency
        end
        
        if cfg["OrbsTransparency"] then
            mapped.OrbsTransparency = tonumber(cfg["OrbsTransparency"]) / 100
        else
            mapped.OrbsTransparency = cfg.OrbsTransparency
        end

        if cfg["BackgroundID"] then
            mapped.Background = GetAssetId(cfg["BackgroundID"])
        else 
            mapped.Background = GetAssetId(cfg.Background) 
        end

        if cfg["Font"] then
            mapped.Font = cfg["Font"]
        end

        if cfg["CornerRadius"] ~= nil then
            mapped.CornerRadius = cfg["CornerRadius"]
        end

        if not mapped.Main then mapped.Main = Themes.Default.Main end
        if not mapped.Second then mapped.Second = Themes.Default.Second end
        if not mapped.Accent then mapped.Accent = Themes.Default.Accent end
        if not mapped.ElementAccent then mapped.ElementAccent = mapped.Accent end
        if not mapped.Text then mapped.Text = Themes.Default.Text end
        if not mapped.TextDark then mapped.TextDark = Color3.fromRGB(170, 170, 170) end
        if not mapped.Error then mapped.Error = Color3.fromRGB(255, 60, 60) end
        if not mapped.GradientStart then mapped.GradientStart = mapped.Accent end
        if not mapped.GradientEnd then mapped.GradientEnd = mapped.Accent end
        
        mapped.Gradient = GetGradientSeq(mapped)
        return mapped
    end

    if isfile(Library.ThemeFolder .. "/" .. tostring(cfg) .. ".json") then
        local content = readfile(Library.ThemeFolder .. "/" .. tostring(cfg) .. ".json")
        local parsed = HS:JSONDecode(content)
        local restored = {}
        for k, v in pairs(parsed) do
            if type(v) == "table" and v.R then
                restored[k] = Color3.new(v.R, v.G, v.B)
            else
                restored[k] = v
            end
        end
        if restored.GradientStart and restored.GradientEnd then
            restored.Gradient = ColorSequence.new{
                ColorSequenceKeypoint.new(0, restored.GradientStart),
                ColorSequenceKeypoint.new(1, restored.GradientEnd)
            }
        else
            restored.GradientStart = restored.Accent
            restored.GradientEnd = restored.Accent
            restored.Gradient = ColorSequence.new{
                ColorSequenceKeypoint.new(0, restored.Accent),
                ColorSequenceKeypoint.new(1, restored.Accent)
            }
        end
        if not restored.ElementAccent then restored.ElementAccent = restored.Accent end
        if not restored.Font then restored.Font = "Gotham" end
        if not restored.TextDark then restored.TextDark = Color3.fromRGB(170, 170, 170) end
        if not restored.Error then restored.Error = Color3.fromRGB(255, 60, 60) end
        if restored.CornerRadius == nil then restored.CornerRadius = 10 end
        return restored
    end
    return Themes[cfg] or Themes.Default
end

local function Create(class, properties)
    local tag = properties.ThemeTag
    properties.ThemeTag = nil
    local instance = Instance.new(class)
    for k, v in pairs(properties) do
        instance[k] = v
    end
    if class == "TextLabel" or class == "TextButton" or class == "TextBox" then
        table.insert(Library.TextObjects, instance)
        if not properties.Font then
            instance.Font = Library.GlobalFont
        end
    end
    if tag and Library.ThemeObjects[tag] then
        table.insert(Library.ThemeObjects[tag], instance)
    end
    return instance
end

local function UpdateFonts(FontName)
    local NewFont = Enum.Font[FontName] or Enum.Font.Gotham
    Library.GlobalFont = NewFont
    local BoldName = FontName .. "Bold"
    if pcall(function() return Enum.Font[BoldName] end) then
        Library.GlobalFontBold = Enum.Font[BoldName]
    else
        Library.GlobalFontBold = NewFont
    end

    for _, obj in pairs(Library.TextObjects) do
        if obj and obj.Parent then
            local s = tostring(obj.Font)
            if s:find("Bold") then
                obj.Font = Library.GlobalFontBold
            else
                obj.Font = Library.GlobalFont
            end
        end
    end
end

local function UpdateThemeObjects()
    for i = #Library.ThemeObjects.Main, 1, -1 do
        local obj = Library.ThemeObjects.Main[i]
        if obj and obj.Parent then
            obj.BackgroundColor3 = Themes.Default.Main
        else
            table.remove(Library.ThemeObjects.Main, i)
        end
    end
    for i = #Library.ThemeObjects.Second, 1, -1 do
        local obj = Library.ThemeObjects.Second[i]
        if obj and obj.Parent then
            obj.BackgroundColor3 = Themes.Default.Second
        else
            table.remove(Library.ThemeObjects.Second, i)
        end
    end
    for i = #Library.ThemeObjects.Accent, 1, -1 do
        local obj = Library.ThemeObjects.Accent[i]
        if obj and obj.Parent then
            if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                obj.ImageColor3 = Themes.Default.Accent
            elseif obj:IsA("UIStroke") then
                obj.Color = Themes.Default.Accent
            else
                obj.BackgroundColor3 = Themes.Default.Accent
            end
        else
            table.remove(Library.ThemeObjects.Accent, i)
        end
    end
    for i = #Library.ThemeObjects.ElementAccent, 1, -1 do
        local obj = Library.ThemeObjects.ElementAccent[i]
        if obj and obj.Parent then
            if obj:IsA("ImageLabel") then
                obj.ImageColor3 = Themes.Default.ElementAccent
            elseif obj:IsA("UIStroke") then
                obj.Color = Themes.Default.ElementAccent
            else
                obj.BackgroundColor3 = Themes.Default.ElementAccent
            end
        else
            table.remove(Library.ThemeObjects.ElementAccent, i)
        end
    end
    for i = #Library.ThemeObjects.Text, 1, -1 do
        local obj = Library.ThemeObjects.Text[i]
        if obj and obj.Parent then 
            if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
                obj.TextColor3 = Themes.Default.Text 
            elseif obj:IsA("Frame") then
                obj.BackgroundColor3 = Themes.Default.Text
            end
        else
            table.remove(Library.ThemeObjects.Text, i)
        end
    end
    for i = #Library.ThemeObjects.TextDark, 1, -1 do
        local obj = Library.ThemeObjects.TextDark[i]
        if obj and obj.Parent then 
            if obj:IsA("ImageLabel") then
                obj.ImageColor3 = Themes.Default.TextDark
            elseif obj:IsA("Frame") then
                obj.BackgroundColor3 = Themes.Default.TextDark
            elseif obj:IsA("UIStroke") then
                obj.Color = Themes.Default.TextDark
            else
                obj.TextColor3 = Themes.Default.TextDark
            end
        else
            table.remove(Library.ThemeObjects.TextDark, i)
        end
    end
    for i = #Library.ThemeObjects.Toggles, 1, -1 do
        local t = Library.ThemeObjects.Toggles[i]
        if t.Box and t.Box.Parent and t.Stroke and t.Stroke.Parent and t.Square and t.Square.Parent then
            if t.State() then
                t.Stroke.Color = Themes.Default.ElementAccent
                t.Stroke.Transparency = 0
                t.Square.BackgroundColor3 = Themes.Default.ElementAccent
            else
                t.Stroke.Color = Themes.Default.TextDark
                t.Stroke.Transparency = 0.8
                t.Square.BackgroundColor3 = Themes.Default.TextDark
            end
        else
            table.remove(Library.ThemeObjects.Toggles, i)
        end
    end
    for i = #Library.ThemeObjects.TabLabels, 1, -1 do
        local tab = Library.ThemeObjects.TabLabels[i]
        if tab.Label and tab.Label.Parent then
            if tab.Btn.BackgroundTransparency < 0.8 then 
                tab.Label.TextColor3 = Themes.Default.Text 
                if tab.Icon then
                    tab.Icon.ImageColor3 = Themes.Default.ElementAccent
                end
            else 
                tab.Label.TextColor3 = Themes.Default.TextDark 
                if tab.Icon then
                    tab.Icon.ImageColor3 = Themes.Default.TextDark
                end
            end
        else
            table.remove(Library.ThemeObjects.TabLabels, i)
        end
    end
    for i = #Library.ThemeObjects.Keybinds, 1, -1 do
        local btn = Library.ThemeObjects.Keybinds[i]
        if btn and btn.Parent then
            if btn.Text == "..." then
                btn.TextColor3 = Themes.Default.Accent
            else
                btn.TextColor3 = Themes.Default.TextDark
            end
        else
            table.remove(Library.ThemeObjects.Keybinds, i)
        end
    end
end

local function UpdateGradients(newGradient)
    for _, grad in pairs(Library.GradientObjects) do
        if grad and grad.Parent then
            grad.Color = newGradient
        end
    end
end

local function UpdateCorners(val)
    Library.GlobalCornerValue = val
    for i = #Library.CornerObjects, 1, -1 do
        local obj = Library.CornerObjects[i]
        if obj.Corner and obj.Corner.Parent then
            obj.Corner.CornerRadius = UDim.new(0, math.floor(obj.BaseRadius * (val / 10)))
        else
            table.remove(Library.CornerObjects, i)
        end
    end
end

local function AddCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, math.floor(radius * (Library.GlobalCornerValue / 10)))
    corner.Parent = instance
    table.insert(Library.CornerObjects, {Corner = corner, BaseRadius = radius})
    return corner
end

local function CreateDropShadow(parent, blurRadius, opacity)
    local Shadow = Create("ImageLabel", {
        Parent = parent,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, blurRadius * 2, 1, blurRadius * 2),
        BackgroundTransparency = 1,
        Image = "rbxassetid://5554836806", 
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = opacity or 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(120, 120, 136, 136),
        ZIndex = (parent.ZIndex or 1) - 1
    })
    return Shadow
end

local function AddStroke(instance, theme)
    local stroke = Create("UIStroke", {
        Color = Color3.new(1, 1, 1),
        Thickness = 1.2,
        Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = instance
    })
    local gradient = Create("UIGradient", {
        Color = theme.Gradient,
        Rotation = 45,
        Parent = stroke
    })
    table.insert(Library.GradientObjects, gradient)
    return stroke
end

local function AddSoftOrbs(parent, theme)
    local Container = Create("Frame", {
        Parent = parent,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ZIndex = 2,
        ClipsDescendants = true
    })
    AddCorner(Container, 12)
    
    local function Spawn(size, color)
        local Orb = Create("Frame", {
            Parent = Container,
            Size = UDim2.fromOffset(size, size),
            Position = UDim2.fromScale(math.random(5, 95) / 100, math.random(5, 95) / 100),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = color,
            BackgroundTransparency = theme.OrbsTransparency or 0.9,
            BorderSizePixel = 0,
            ZIndex = 2
        })
        AddCorner(Orb, 1000)
        
        Create("UIGradient", {
            Parent = Orb,
            Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.3),
                NumberSequenceKeypoint.new(1, 1)
            }
        })
        
        task.spawn(function()
            while Orb.Parent do
                if parent.AbsoluteSize.X == 0 or not parent.Visible then
                    task.wait(1)
                    continue
                end

                local targetPos = UDim2.fromScale(math.random(10, 90) / 100, math.random(10, 90) / 100)
                local tween = TS:Create(Orb, TweenInfo.new(math.random(15, 30), Enum.EasingStyle.Sine), {Position = targetPos})
                tween:Play()
                tween.Completed:Wait()
            end
        end)
    end
    
    for i = 1, 8 do
        local orbSize = math.random(150, 400)
        local orbColor = (i % 2 == 0) and theme.Accent or theme.Second
        Spawn(orbSize, orbColor)
    end
    
    return Container
end

local function CreateRipple(btn, color)
    btn.ClipsDescendants = true
    btn.MouseButton1Click:Connect(function()
        local ripple = Create("ImageLabel", {
            Name = "Ripple",
            Parent = btn,
            Image = "rbxassetid://4743389506",
            ImageColor3 = color,
            BackgroundTransparency = 1,
            ImageTransparency = 0.5,
            Position = UDim2.new(0, Mouse.X - btn.AbsolutePosition.X, 0, Mouse.Y - btn.AbsolutePosition.Y),
            Size = UDim2.new(0, 0, 0, 0),
            ZIndex = 20,
            AnchorPoint = Vector2.new(0.5, 0.5)
        })
        local tween = TS:Create(ripple, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 500), ImageTransparency = 1})
        tween:Play()
        tween.Completed:Connect(function()
            ripple:Destroy()
        end)
    end)
end

local function MakeDraggable(topbar, frame)
    local dragging, dragInput, dragStart, startPos
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    topbar.InputChanged:Connect(function(input) 
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end 
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TS:Create(frame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
end

local function MakeResizable(handle, frame)
    local dragging, dragStart, startSize
    local MinSize = Vector2.new(500, 350)
    local MaxSize = Vector2.new(1000, 800)
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startSize = frame.AbsoluteSize
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newX = math.clamp(startSize.X + delta.X, MinSize.X, MaxSize.X)
            local newY = math.clamp(startSize.Y + delta.Y, MinSize.Y, MaxSize.Y)
            TS:Create(frame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(newX, newY)}):Play()
        end
    end)
end

local function AttachHorizontalScroll(box, scrollingFrame, defaultAlignment)
    defaultAlignment = defaultAlignment or Enum.TextXAlignment.Left
    
    box:GetPropertyChangedSignal("TextBounds"):Connect(function()
        if scrollingFrame.AbsoluteWindowSize.X > 0 and box.TextBounds.X > scrollingFrame.AbsoluteWindowSize.X then
            box.TextXAlignment = Enum.TextXAlignment.Left
        else
            box.TextXAlignment = defaultAlignment
        end
    end)

    box:GetPropertyChangedSignal("CursorPosition"):Connect(function()
        if box:IsFocused() and box.CursorPosition > 0 then
            
            local textToCursor = string.sub(box.Text, 1, box.CursorPosition - 1)
            local size = TxtS:GetTextSize(textToCursor, box.TextSize, box.Font, Vector2.new(10000, 100))
            
            local visibleStart = scrollingFrame.CanvasPosition.X
            local visibleEnd = visibleStart + scrollingFrame.AbsoluteWindowSize.X
            
            local padding = 12
            if box.TextXAlignment == Enum.TextXAlignment.Left then
                if size.X > visibleEnd - padding then
                    TS:Create(scrollingFrame, TweenInfo.new(0.1), {CanvasPosition = Vector2.new(size.X - scrollingFrame.AbsoluteWindowSize.X + padding * 2, 0)}):Play()
                elseif size.X < visibleStart + padding then
                    TS:Create(scrollingFrame, TweenInfo.new(0.1), {CanvasPosition = Vector2.new(math.max(0, size.X - padding * 2), 0)}):Play()
                end
            end
        end
    end)
end

function Library:KeySystem(Settings)
    local Config = Settings or {}
    local Key = Config.Key
    if not Key or Key == "" then
        return
    end
    
    local LinkToCopy = tostring(Config.Link or "https://google.com")
    local SelectedTheme = GetTheme(Config.Theme)
    local Validated = false

    local ScreenGui = Create("ScreenGui", {
        Name = "KeyUI",
        ResetOnSpawn = false,
        DisplayOrder = 20000
    })
    
    if RS:IsStudio() then
        ScreenGui.Parent = LP:WaitForChild("PlayerGui")
    else
        pcall(function()
            ScreenGui.Parent = CG
        end)
        if not ScreenGui.Parent then
            ScreenGui.Parent = LP:WaitForChild("PlayerGui")
        end
    end

    local VP = workspace.CurrentCamera.ViewportSize
    local IsMobile = UIS.TouchEnabled and (VP.X < 850 or VP.Y < 600)
    local KeySizeX = IsMobile and math.min(VP.X - 40, 450) or 450
    local KeySizeY = IsMobile and math.min(VP.Y - 40, 260) or 260

    local KeyContainer = Create("Frame", {
        Parent = ScreenGui,
        Size = UDim2.fromOffset(0, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ZIndex = 2
    })
    
    local Main = Create("Frame", {
        Parent = KeyContainer,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = SelectedTheme.Main,
        BackgroundTransparency = 0.05,
        ClipsDescendants = true
    })
    AddCorner(Main, 12)
    AddStroke(Main, SelectedTheme)
    AddSoftOrbs(Main, SelectedTheme)
    
    local Shadow1 = CreateDropShadow(KeyContainer, 80, 0.3)
    local Shadow2 = CreateDropShadow(KeyContainer, 30, 0.4)
    Shadow1.ImageTransparency = 1
    Shadow2.ImageTransparency = 1

    TS:Create(KeyContainer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(KeySizeX, KeySizeY)}):Play()
    TS:Create(Shadow1, TweenInfo.new(0.6), {ImageTransparency = 0.3}):Play()
    TS:Create(Shadow2, TweenInfo.new(0.6), {ImageTransparency = 0.4}):Play()
    
    local Content = Create("Frame", {
        Parent = Main,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ZIndex = 2
    })
    
    Create("TextLabel", {
        Parent = Content,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Text = Config.Title or "Security Access",
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 24,
        ZIndex = 3
    })
    
    local InputBG = Create("ScrollingFrame", {
        Parent = Content,
        Size = UDim2.new(1, -60, 0, 48),
        Position = UDim2.new(0, 30, 0, 75),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.4,
        ZIndex = 3,
        ClipsDescendants = true,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.X,
        AutomaticCanvasSize = Enum.AutomaticSize.X
    })
    AddCorner(InputBG, 8)
    
    Create("UIPadding", {
        Parent = InputBG,
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    })
    
    local InputStroke = AddStroke(InputBG, SelectedTheme)
    InputStroke.Transparency = 0.8
    
    local Input = Create("TextBox", {
        Parent = InputBG,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = "Enter License Key...",
        TextColor3 = SelectedTheme.Text,
        Font = Library.GlobalFont,
        TextSize = 15,
        ZIndex = 4,
        TextWrapped = false,
        ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    AttachHorizontalScroll(Input, InputBG, Enum.TextXAlignment.Left)

    Input.Focused:Connect(function()
        TS:Create(InputStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
    end)
    Input.FocusLost:Connect(function()
        TS:Create(InputStroke, TweenInfo.new(0.3), {Transparency = 0.8}):Play()
    end)

    local CheckColor = Color3.new(SelectedTheme.Accent.R * 0.8, SelectedTheme.Accent.G * 0.8, SelectedTheme.Accent.B * 0.8)
    
    local CheckBtn = Create("TextButton", {
        Parent = Content,
        Size = UDim2.new(0.5, -40, 0, 42),
        Position = UDim2.new(0, 30, 0, 145),
        BackgroundColor3 = CheckColor,
        BackgroundTransparency = 0.1,
        Text = "Verify Key",
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Main,
        TextSize = 14,
        ZIndex = 3
    })
    AddCorner(CheckBtn, 8)
    CreateRipple(CheckBtn, Color3.new(1, 1, 1))
    
    local GetKeyBtn = Create("TextButton", {
        Parent = Content,
        Size = UDim2.new(0.5, -40, 0, 42),
        Position = UDim2.new(0.5, 10, 0, 145),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.4,
        Text = "Get Key Link",
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 14,
        ZIndex = 3
    })
    AddCorner(GetKeyBtn, 8)
    CreateRipple(GetKeyBtn, SelectedTheme.Accent)
    AddStroke(GetKeyBtn, SelectedTheme).Transparency = 0.7
    
    local Status = Create("TextLabel", {
        Parent = Content,
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 1, -35),
        BackgroundTransparency = 1,
        Text = "Protected System",
        Font = Library.GlobalFont,
        TextColor3 = SelectedTheme.TextDark,
        TextSize = 13,
        ZIndex = 3
    })

    local function BtnHover(btn, isAccent)
        local hoverTween, leaveTween
        btn.MouseEnter:Connect(function()
            if leaveTween then leaveTween:Cancel() end
            hoverTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = isAccent and 0 or 0.2})
            hoverTween:Play()
        end)
        btn.MouseLeave:Connect(function()
            if hoverTween then hoverTween:Cancel() end
            leaveTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = isAccent and 0.1 or 0.4})
            leaveTween:Play()
        end)
    end
    BtnHover(CheckBtn, true)
    BtnHover(GetKeyBtn, false)

    GetKeyBtn.MouseButton1Click:Connect(function() 
        local success, err = pcall(function()
            if setclipboard then
                setclipboard(LinkToCopy)
                return true
            elseif toclipboard then
                toclipboard(LinkToCopy)
                return true
            elseif syn and syn.write_clipboard then
                syn.write_clipboard(LinkToCopy)
                return true
            elseif Clipboard and Clipboard.set then
                Clipboard.set(LinkToCopy)
                return true
            end
            return false
        end)
        if success then
            Status.Text = "Link copied to clipboard!"
            Status.TextColor3 = SelectedTheme.Accent
        else
            Status.Text = "Check Console (F9)"
            Status.TextColor3 = SelectedTheme.Error
        end
        task.wait(2)
        Status.Text = "Protected System"
        Status.TextColor3 = SelectedTheme.TextDark
    end)

    CheckBtn.MouseButton1Click:Connect(function()
        if Input.Text == Key then 
            TS:Create(KeyContainer, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)}):Play()
            TS:Create(Shadow1, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
            TS:Create(Shadow2, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
            task.wait(0.4)
            ScreenGui:Destroy()
            Validated = true
        else
            Status.Text = "Incorrect or Invalid Key!"
            Status.TextColor3 = SelectedTheme.Error
            InputStroke.Color = SelectedTheme.Error
            InputStroke.Transparency = 0
            
            local x = KeyContainer.Position.X.Scale
            local y = KeyContainer.Position.Y.Scale
            for i = 1, 5 do
                KeyContainer.Position = UDim2.fromScale(x + math.random(-1, 1) / 150, y)
                task.wait(0.04)
            end
            
            KeyContainer.Position = UDim2.fromScale(x, y)
            task.wait(1)
            
            InputStroke.Color = Color3.new(1, 1, 1)
            InputStroke.Transparency = 0.8
            Status.Text = "Protected System"
            Status.TextColor3 = SelectedTheme.TextDark
        end
    end)
    
    repeat
        task.wait()
    until Validated
end

function Library:CreateWindow(Settings)
    local Config = Settings or {}
    local Title = Config.Title or "UI"
    local SelectedTheme = GetTheme(Config.Theme)
    
    Library.GlobalCornerValue = Config.CornerRadius or SelectedTheme.CornerRadius or 10

    Library.ConfigFolder = Config.ConfigFolder or "SolarisUI-Configs"
    if not isfolder(Library.ConfigFolder) then makefolder(Library.ConfigFolder) end
    if not isfolder(Library.ThemeFolder) then makefolder(Library.ThemeFolder) end

    Themes.Default.Main = SelectedTheme.Main
    Themes.Default.Second = SelectedTheme.Second
    Themes.Default.Accent = SelectedTheme.Accent
    Themes.Default.ElementAccent = SelectedTheme.ElementAccent
    Themes.Default.Text = SelectedTheme.Text
    Themes.Default.TextDark = SelectedTheme.TextDark
    Themes.Default.Error = SelectedTheme.Error
    Themes.Default.GradientStart = SelectedTheme.GradientStart
    Themes.Default.GradientEnd = SelectedTheme.GradientEnd
    Themes.Default.Gradient = SelectedTheme.Gradient

    if SelectedTheme.Font then
        UpdateFonts(SelectedTheme.Font)
    end

    Library.ToggleKey = Config.ToggleKey or Enum.KeyCode.RightControl
    local WindowTrans = SelectedTheme.Transparency or Config.Transparency or 0.25 
    local ImageTrans = SelectedTheme.ImageTransparency or 0
    local OrbsTrans = SelectedTheme.OrbsTransparency or 0.90 
    
    local WatermarkConfig = { Enabled = true, Title = true, User = true, FPS = true, Time = true, Ping = true }
    if type(Config.ShowWatermark) == "table" then
        for k, v in pairs(Config.ShowWatermark) do
            WatermarkConfig[k] = v
        end
    elseif Config.ShowWatermark == false then
        WatermarkConfig.Enabled = false
    end

    local CustomIconID = Config.CustomIcon

    local ScreenGui = Create("ScreenGui", {
        Name = "MainUI",
        ResetOnSpawn = false,
        DisplayOrder = 10000
    })
    
    if RS:IsStudio() then
        ScreenGui.Parent = LP:WaitForChild("PlayerGui")
    else
        pcall(function()
            ScreenGui.Parent = CG
        end)
        if not ScreenGui.Parent then
            ScreenGui.Parent = LP:WaitForChild("PlayerGui")
        end
    end

    function Library:GetThemes()
        local list = {}
        if isfolder(Library.ThemeFolder) then
            for _, file in pairs(listfiles(Library.ThemeFolder)) do
                if file:sub(-5) == ".json" then
                    table.insert(list, (file:match("([^/]+)%.json$") or file))
                end
            end
        end
        return list
    end
    
    function Library:GetConfigs()
        local list = {}
        if isfolder(Library.ConfigFolder) then
            for _, file in pairs(listfiles(Library.ConfigFolder)) do
                if file:sub(-5) == ".json" then
                    local success, decoded = pcall(function()
                        return HS:JSONDecode(readfile(file))
                    end)
                    if success and type(decoded) == "table" and decoded["Settings_Identifier"] == Title then
                        table.insert(list, file:match("([^/]+)%.json$") or file)
                    end
                end
            end
        end
        return list
    end

    function Library:SaveConfig(Name)
        local ConfigToSave = {}
        for flag, value in pairs(Library.Flags) do
            if string.sub(flag, 1, 9) ~= "Settings_" then
                ConfigToSave[flag] = value
            end
        end
        ConfigToSave["Settings_Identifier"] = Title
        local json = HS:JSONEncode(ConfigToSave)
        local path = Library.ConfigFolder .. "/" .. Name .. ".json"
        writefile(path, json)
        Library:Notify({Title = "Config Saved", Content = "Successfully saved " .. Name, Duration = 3})
    end

    function Library:LoadConfig(Name)
        local path = Library.ConfigFolder .. "/" .. Name .. ".json"
        if isfile(path) then
            local success, err = pcall(function()
                local json = readfile(path)
                local data = HS:JSONDecode(json)
                for flag, value in pairs(data) do
                    if Library.Items[flag] then
                        task.spawn(function()
                            Library.Items[flag].Set(value)
                        end)
                    end
                end
            end)
            if success then
                Library:Notify({Title = "Config Loaded", Content = "Successfully loaded " .. Name, Duration = 3})
            else
                Library:Notify({Title = "Config Error", Content = "Corrupted JSON file", Duration = 3})
            end
        end
    end

    function Library:DeleteConfig(Name)
        local path = Library.ConfigFolder .. "/" .. Name .. ".json"
        if isfile(path) then
            delfile(path)
            Library:Notify({Title = "Config Deleted", Content = "Deleted " .. Name, Duration = 3})
        end
    end

    local AutoloadPath = Library.ConfigFolder .. "/Autoload.txt"
    if isfile(AutoloadPath) then
        local cfgToLoad = readfile(AutoloadPath)
        if cfgToLoad ~= "" then
            task.delay(1, function()
                Library:LoadConfig(cfgToLoad)
            end)
        end
    end

    if WatermarkConfig.Enabled then
        local HudFrame = Create("Frame", {
            Name = "Watermark",
            Parent = ScreenGui,
            Size = UDim2.fromOffset(0, 38),
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, -0.1, 0),
            BackgroundColor3 = Color3.new(0, 0, 0),
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            ZIndex = 5000
        })
        AddCorner(HudFrame, 6)
        
        local HudStroke = AddStroke(HudFrame, SelectedTheme)
        HudStroke.Transparency = 1 
        MakeDraggable(HudFrame, HudFrame) 
        
        TS:Create(HudFrame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0, 20)}):Play()
        TS:Create(HudStroke, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0.5}):Play()
        
        local Layout = Create("UIListLayout", {
            Parent = HudFrame,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        Create("UIPadding", {
            Parent = HudFrame,
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 4)
        })

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TS:Create(HudFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, Layout.AbsoluteContentSize.X + 24, 0, 38)}):Play()
        end)

        local function CreateHudItem(order, iconId, textFunc)
            local ItemContainer = Create("Frame", {
                Parent = HudFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 1, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                LayoutOrder = order,
                ZIndex = 5001
            })
            
            Create("UIListLayout", {
                Parent = ItemContainer,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 6),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            local Icon = Create("ImageLabel", {
                Parent = ItemContainer,
                Size = UDim2.new(0, 24, 0, 24),
                BackgroundTransparency = 1,
                ImageColor3 = SelectedTheme.Accent,
                ImageTransparency = 1,
                ZIndex = 5002,
                LayoutOrder = 1,
                ThemeTag = "Accent"
            })
            SetImageAsync(Icon, "Image", iconId)
            
            local Label = Create("TextLabel", {
                Parent = ItemContainer,
                Size = UDim2.new(0, 0, 1, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                Font = Library.GlobalFontBold,
                TextSize = 14,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextStrokeTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = "...",
                TextTransparency = 1,
                ZIndex = 5002,
                LayoutOrder = 2
            })
            
            TS:Create(Icon, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
            TS:Create(Label, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
            
            if order > 1 then 
                local Split = Create("Frame", {
                    Parent = HudFrame,
                    LayoutOrder = order - 1,
                    Size = UDim2.new(0, 1, 0, 20),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    ZIndex = 5002
                })
                TS:Create(Split, TweenInfo.new(1), {BackgroundTransparency = 0.7}):Play() 
            end
            
            task.spawn(function() 
                while ItemContainer.Parent do 
                    local txt = textFunc()
                    if Label.Text ~= txt then
                        Label.Text = txt
                    end
                    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    task.wait(1) 
                end 
            end)
        end

        local Order = 1
        local titleIcon = (CustomIconID and CustomIconID ~= "") and CustomIconID or "rbxassetid://10884488899"
        
        if WatermarkConfig.Title then
            CreateHudItem(Order, titleIcon, function() return Title end)
            Order = Order + 2
        end
        if WatermarkConfig.User then
            CreateHudItem(Order, "rbxassetid://10884490076", function() return LP.DisplayName end)
            Order = Order + 2
        end
        if WatermarkConfig.FPS then
            CreateHudItem(Order, "rbxassetid://10884494953", function() return CurrentFPS .. " FPS" end)
            Order = Order + 2
        end
        if WatermarkConfig.Time then
            CreateHudItem(Order, "rbxassetid://10884491769", function() return os.date("%H:%M:%S") end)
            Order = Order + 2
        end
        if WatermarkConfig.Ping then
            CreateHudItem(Order, "rbxassetid://10884496263", function() 
                if DataPing then
                    return math.floor(DataPing:GetValue()) .. " ms"
                end
                return "0 ms"
            end)
            Order = Order + 2
        end
        
        task.spawn(function()
            task.wait(0.1)
            HudFrame.Size = UDim2.new(0, Layout.AbsoluteContentSize.X + 24, 0, 38)
        end)
    end

    local NotifContainer = Create("Frame", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 320, 1, -20),
        Position = UDim2.new(1, -340, 0, 50),
        BackgroundTransparency = 1,
        ZIndex = 10000
    })
    
    Create("UIListLayout", {
        Parent = NotifContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 12)
    })

    function Library:Notify(Config)
        local Title = Config.Title or "Notification"
        local Content = Config.Content or "Message"
        local Duration = Config.Duration or 3
        
        if #Title > 30 then
            Title = string.sub(Title, 1, 27) .. "..."
        end
        
        local ImageUrl = Config.ImageID or "rbxassetid://3944703587"

        local ContentSize = TxtS:GetTextSize(Content, 13, Library.GlobalFont, Vector2.new(230, 1000))
        local TotalHeight = math.max(70, 55 + ContentSize.Y)

        local NotifHolder = Create("Frame", {
            Parent = NotifContainer,
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = false 
        })
        
        local Frame = Create("Frame", {
            Parent = NotifHolder,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = SelectedTheme.Main,
            BackgroundTransparency = 0,
            ZIndex = 10001,
            ClipsDescendants = true,
            ThemeTag = "Main"
        })
        AddCorner(Frame, 5)
        
        local Stroke = AddStroke(Frame, SelectedTheme)
        Stroke.Transparency = 1 

        local Shadow = CreateDropShadow(NotifHolder, 45, 0)
        Shadow.ImageTransparency = 1
        
        local Icon = Create("ImageLabel", {
            Parent = Frame,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, 31, 0, 31),
            BackgroundTransparency = 1,
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            ZIndex = 10002,
            ImageTransparency = 1,
            Rotation = -15
        })
        SetImageAsync(Icon, "Image", ImageUrl)
        
        local TitleLabel = Create("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -64, 0, 20),
            Position = UDim2.new(0, 60, 0, 12),
            BackgroundTransparency = 1,
            Text = Title,
            Font = Library.GlobalFontBold,
            TextColor3 = SelectedTheme.Text,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 10002,
            TextTransparency = 1,
            ThemeTag = "Text"
        })
        
        local ContentLabel = Create("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -64, 1, -34),
            Position = UDim2.new(0, 60, 0, 34),
            BackgroundTransparency = 1,
            Text = Content,
            Font = Library.GlobalFont,
            TextColor3 = SelectedTheme.TextDark,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            ZIndex = 10002,
            TextWrapped = true,
            TextTransparency = 1,
            ThemeTag = "TextDark"
        })

        local BarBg = Create("Frame", {
            Parent = Frame,
            Size = UDim2.new(1, -28, 0, 3),
            Position = UDim2.new(0, 14, 1, -8),
            BackgroundColor3 = SelectedTheme.Second,
            BorderSizePixel = 0,
            ZIndex = 10002,
            BackgroundTransparency = 1,
            ThemeTag = "Second"
        })
        AddCorner(BarBg, 3)
        
        local Bar = Create("Frame", {
            Parent = BarBg,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = SelectedTheme.ElementAccent,
            BorderSizePixel = 0,
            ZIndex = 10003,
            BackgroundTransparency = 1,
            ThemeTag = "ElementAccent"
        })
        AddCorner(Bar, 3)
        
        local InInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local LinearInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        
        TS:Create(NotifHolder, InInfo, {Size = UDim2.new(1, 0, 0, TotalHeight)}):Play()
        TS:Create(Frame, LinearInfo, {BackgroundTransparency = 0.15}):Play()
        TS:Create(Stroke, LinearInfo, {Transparency = 0.4}):Play()
        TS:Create(Shadow, LinearInfo, {ImageTransparency = 0.35}):Play()
        TS:Create(Icon, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 38, 0, 38), Position = UDim2.new(0, 12, 0, 12), ImageTransparency = 0, Rotation = 0}):Play()
        TS:Create(TitleLabel, LinearInfo, {TextTransparency = 0}):Play()
        TS:Create(ContentLabel, LinearInfo, {TextTransparency = 0}):Play()
        TS:Create(BarBg, LinearInfo, {BackgroundTransparency = 0.5}):Play()
        TS:Create(Bar, LinearInfo, {BackgroundTransparency = 0}):Play()
        
        local TimerTween = TS:Create(Bar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)})
        TimerTween:Play()
        
        TimerTween.Completed:Connect(function()
            local OutInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            TS:Create(NotifHolder, OutInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            TS:Create(Frame, OutInfo, {BackgroundTransparency = 1}):Play()
            TS:Create(Stroke, OutInfo, {Transparency = 1}):Play()
            TS:Create(Shadow, OutInfo, {ImageTransparency = 1}):Play()
            TS:Create(Icon, OutInfo, {ImageTransparency = 1, Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0, 31, 0, 31)}):Play()
            TS:Create(TitleLabel, OutInfo, {TextTransparency = 1}):Play()
            TS:Create(ContentLabel, OutInfo, {TextTransparency = 1}):Play()
            TS:Create(BarBg, OutInfo, {BackgroundTransparency = 1}):Play()
            TS:Create(Bar, OutInfo, {BackgroundTransparency = 1}):Play()
            task.delay(0.5, function()
                NotifHolder:Destroy()
            end)
        end)
    end

    local VP = workspace.CurrentCamera.ViewportSize
    local IsMobile = UIS.TouchEnabled and (VP.X < 850 or VP.Y < 600)
    local WindowSizeX = IsMobile and math.clamp(VP.X - 40, 300, 780) or 780
    local WindowSizeY = IsMobile and math.clamp(VP.Y - 40, 200, 540) or 540
    local WindowSize = UDim2.fromOffset(WindowSizeX, WindowSizeY)

    local WindowContainer = Create("Frame", {
        Name = "WindowContainer",
        Parent = ScreenGui,
        Size = UDim2.fromOffset(0, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    
    local Main = Create("Frame", {
        Name = "Main",
        Parent = WindowContainer,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = SelectedTheme.Main,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 2
    })
    
    local Shadow1 = CreateDropShadow(WindowContainer, 120, 0.35)
    local Shadow2 = CreateDropShadow(WindowContainer, 35, 0.4) 
    Shadow1.ImageTransparency = 1
    Shadow2.ImageTransparency = 1

    local MainBgImage = Create("ImageLabel", {
        Parent = Main,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ImageTransparency = ImageTrans,
        ScaleType = Enum.ScaleType.Crop,
        ZIndex = 1
    })
    SetImageAsync(MainBgImage, "Image", SelectedTheme.Background)
    AddCorner(MainBgImage, 12)
    
    local MainBgColor = Create("Frame", {
        Parent = Main,
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = SelectedTheme.Main,
        BackgroundTransparency = WindowTrans,
        ZIndex = 2,
        ThemeTag = "Main"
    })
    AddCorner(MainBgColor, 12)

    local OrbContainer = AddSoftOrbs(Main, SelectedTheme) 
    
    AddCorner(Main, 12)
    AddStroke(Main, SelectedTheme)
    
    TS:Create(WindowContainer, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = WindowSize}):Play()
    TS:Create(Shadow1, TweenInfo.new(0.7), {ImageTransparency = 0.35}):Play()
    TS:Create(Shadow2, TweenInfo.new(0.7), {ImageTransparency = 0.4}):Play()

    local ResizeBtn = Create("TextButton", {
        Parent = Main,
        Size = UDim2.fromOffset(25, 25),
        Position = UDim2.new(1, 0, 1, 0),
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        Text = "◢",
        Font = Library.GlobalFont,
        TextColor3 = SelectedTheme.TextDark,
        TextSize = 10,
        ZIndex = 2000,
        ThemeTag = "TextDark"
    })
    MakeResizable(ResizeBtn, WindowContainer)

    local TopBar = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundTransparency = 1,
        ZIndex = 5
    })
    MakeDraggable(TopBar, WindowContainer)
    
    Create("Frame", {
        Parent = TopBar,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = SelectedTheme.TextDark,
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        ZIndex = 6,
        ThemeTag = "TextDark"
    })
    
    local TitleOffsetX = 18
    if CustomIconID and CustomIconID ~= "" then
        TitleOffsetX = 48
        local TopIcon = Create("ImageLabel", {
            Parent = TopBar,
            Size = UDim2.new(0, 26, 0, 26),
            Position = UDim2.new(0, 16, 0.5, -13),
            BackgroundTransparency = 1,
            ZIndex = 6
        })
        SetImageAsync(TopIcon, "Image", CustomIconID)
    end

    Create("TextLabel", {
        Parent = TopBar,
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, TitleOffsetX, 0, 0),
        BackgroundTransparency = 1,
        Text = Title,
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        ThemeTag = "Text"
    })
    
    local Close = Create("TextButton", {
        Parent = TopBar,
        Size = UDim2.new(0, 45, 1, 0),
        Position = UDim2.new(1, -45, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 6
    })
    
    local Cross1 = Create("Frame", {
        Parent = Close,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 2),
        BackgroundColor3 = SelectedTheme.Text,
        Rotation = 45,
        ZIndex = 6,
        ThemeTag = "Text"
    })
    AddCorner(Cross1, 2)
    
    local Cross2 = Create("Frame", {
        Parent = Close,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 12, 0, 2),
        BackgroundColor3 = SelectedTheme.Text,
        Rotation = -45,
        ZIndex = 6,
        ThemeTag = "Text"
    })
    AddCorner(Cross2, 2)
    
    Close.MouseEnter:Connect(function() 
        TS:Create(Cross1, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Error}):Play() 
        TS:Create(Cross2, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Error}):Play() 
    end)
    Close.MouseLeave:Connect(function() 
        TS:Create(Cross1, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Text}):Play() 
        TS:Create(Cross2, TweenInfo.new(0.2), {BackgroundColor3 = SelectedTheme.Text}):Play() 
    end)
    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local TabContainer = Create("ScrollingFrame", {
        Parent = Main,
        Size = UDim2.new(0, 165, 1, -171),
        Position = UDim2.new(0, 15, 0, 60),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.5,
        ScrollBarThickness = 0,
        BorderSizePixel = 0,
        ZIndex = 5,
        ThemeTag = "Second"
    })
    AddCorner(TabContainer, 8)

    local TabContainerStroke = AddStroke(TabContainer, SelectedTheme)
    TabContainerStroke.Transparency = 0.8
    Create("UIListLayout", {
        Parent = TabContainer,
        Padding = UDim.new(0, 6)
    })
    Create("UIPadding", {
        Parent = TabContainer,
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6)
    })
    
    local OpenSettingsBtn = Create("TextButton", {
        Parent = Main,
        Size = UDim2.new(0, 165, 0, 40),
        Position = UDim2.new(0, 15, 1, -103),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.5,
        Text = "GUI Settings",
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 13,
        ZIndex = 6,
        ThemeTag = "Second"
    })
    AddCorner(OpenSettingsBtn, 8)
    table.insert(Library.ThemeObjects.Text, OpenSettingsBtn)

    CreateRipple(OpenSettingsBtn, SelectedTheme.Accent)
    AddStroke(OpenSettingsBtn, SelectedTheme).Transparency = 0.8
    
    local hoverTweenSettings, leaveTweenSettings
    OpenSettingsBtn.MouseEnter:Connect(function()
        if leaveTweenSettings then leaveTweenSettings:Cancel() end
        hoverTweenSettings = TS:Create(OpenSettingsBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2})
        hoverTweenSettings:Play()
    end)
    OpenSettingsBtn.MouseLeave:Connect(function()
        if hoverTweenSettings then hoverTweenSettings:Cancel() end
        leaveTweenSettings = TS:Create(OpenSettingsBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5})
        leaveTweenSettings:Play()
    end)
    OpenSettingsBtn.MouseButton1Down:Connect(function()
        TS:Create(OpenSettingsBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 161, 0, 36), Position = UDim2.new(0, 17, 1, -101)}):Play()
    end)
    OpenSettingsBtn.MouseButton1Up:Connect(function()
        TS:Create(OpenSettingsBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 165, 0, 40), Position = UDim2.new(0, 15, 1, -103)}):Play()
    end)

    local ProfileFrame = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(0, 165, 0, 40),
        Position = UDim2.new(0, 15, 1, -55),
        BackgroundColor3 = SelectedTheme.Second,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ZIndex = 5,
        ThemeTag = "Second"
    })
    AddCorner(ProfileFrame, 8)
    AddStroke(ProfileFrame, SelectedTheme).Transparency = 0.8

    local AvatarImg = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    pcall(function()
        AvatarImg = Plrs:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    end)
    
    local Avatar = Create("ImageLabel", {
        Parent = ProfileFrame,
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(0, 6, 0.5, -14),
        BackgroundTransparency = 1,
        Image = AvatarImg,
        ZIndex = 6
    })
    AddCorner(Avatar, 100)
    
    Create("TextLabel", {
        Parent = ProfileFrame,
        Size = UDim2.new(1, -45, 0, 16),
        Position = UDim2.new(0, 40, 0, 5),
        BackgroundTransparency = 1,
        Text = LP.DisplayName,
        Font = Library.GlobalFontBold,
        TextColor3 = SelectedTheme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ThemeTag = "Text"
    })
    Create("TextLabel", {
        Parent = ProfileFrame,
        Size = UDim2.new(1, -45, 0, 14),
        Position = UDim2.new(0, 40, 0, 20),
        BackgroundTransparency = 1,
        Text = "@" .. LP.Name,
        Font = Library.GlobalFont,
        TextColor3 = SelectedTheme.TextDark,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 6,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ThemeTag = "TextDark"
    })

    local PageContainer = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(1, -210, 1, -75),
        Position = UDim2.new(0, 195, 0, 60),
        BackgroundTransparency = 1,
        ZIndex = 5,
        ClipsDescendants = true
    })

    local IsOpen, LastSize = true, WindowSize
    
    local function ToggleUI()
        IsOpen = not IsOpen 
        if IsOpen then 
            WindowContainer.Visible = true 
            TS:Create(WindowContainer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = LastSize}):Play() 
            TS:Create(Shadow1, TweenInfo.new(0.6), {ImageTransparency = 0.35}):Play()
            TS:Create(Shadow2, TweenInfo.new(0.6), {ImageTransparency = 0.4}):Play()
        else 
            LastSize = WindowContainer.Size 
            local close = TS:Create(WindowContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            close:Play() 
            TS:Create(Shadow1, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
            TS:Create(Shadow2, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
            close.Completed:Connect(function()
                if not IsOpen then
                    WindowContainer.Visible = false
                end
            end) 
        end
    end

    if UIS.TouchEnabled then
        local MobileBtn = Create("ImageButton", {
            Name = "MobileToggle",
            Parent = ScreenGui,
            Size = UDim2.fromOffset(50, 50),
            Position = UDim2.new(0.9, 0, 0.5, 0),
            BackgroundColor3 = SelectedTheme.Main,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            Image = "rbxassetid://10884488899",
            ImageColor3 = SelectedTheme.Accent,
            ThemeTag = "Main"
        })
        AddCorner(MobileBtn, 14)
        AddStroke(MobileBtn, SelectedTheme)
        MakeDraggable(MobileBtn, MobileBtn)
        CreateDropShadow(MobileBtn, 35, 0.3)
        table.insert(Library.ThemeObjects.Accent, MobileBtn)
        
        MobileBtn.MouseButton1Click:Connect(ToggleUI)
    end

    UIS.InputBegan:Connect(function(input, gpe)
        if gpe or UIS:GetFocusedTextBox() then
            return
        end
        
        local currentToggle = Library.ToggleKey
        if Library.Flags["Settings_ToggleKey"] then
            local s, k = pcall(function() return Enum.KeyCode[Library.Flags["Settings_ToggleKey"]] end)
            if s and k then
                currentToggle = k
            end
        end

        if input.KeyCode == currentToggle then 
            ToggleUI()
        end
    end)
    
    local TabCount = 0
    local ActiveTab = nil
    local Funcs = {}

    function Funcs:CreateTab(TabName, Two_Column, ImageID)
        TabCount = TabCount + 1
        local MyIndex = TabCount
        local Tab = {}
        
        local HasIcon = (ImageID ~= nil and ImageID ~= "")
        
        local TabBtn = Create("TextButton", {
            Name = "TabBtn",
            Parent = TabContainer,
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = SelectedTheme.Main,
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 6,
            ThemeTag = "Main"
        })
        AddCorner(TabBtn, 6)

        local TabLabel
        local ActiveLine
        local TabIcon

        if HasIcon then
            TabLabel = Create("TextLabel", {
                Name = "TabLabel",
                Parent = TabBtn,
                Size = UDim2.new(1, -44, 1, 0),
                Position = UDim2.new(0, 38, 0, 0),
                BackgroundTransparency = 1,
                Text = TabName,
                Font = Library.GlobalFontBold,
                TextColor3 = SelectedTheme.TextDark,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7
            })
            
            TabIcon = Create("ImageLabel", {
                Name = "TabIcon",
                Parent = TabBtn,
                Size = UDim2.new(0, 22, 0, 22),
                Position = UDim2.new(0, 10, 0.5, -11),
                BackgroundTransparency = 1,
                ImageColor3 = SelectedTheme.TextDark,
                ZIndex = 7
            })
            SetImageAsync(TabIcon, "Image", ImageID)
            table.insert(Library.ThemeObjects.TabLabels, {Label = TabLabel, Btn = TabBtn, Icon = TabIcon})
        else
            TabLabel = Create("TextLabel", {
                Name = "TabLabel",
                Parent = TabBtn,
                Size = UDim2.new(1, -25, 1, 0),
                Position = UDim2.new(0, 20, 0, 0),
                BackgroundTransparency = 1,
                Text = TabName,
                Font = Library.GlobalFontBold,
                TextColor3 = SelectedTheme.TextDark,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 7
            })
            
            ActiveLine = Create("Frame", {
                Name = "ActiveLine",
                Parent = TabBtn,
                Size = UDim2.new(0, 3, 0, 0),
                Position = UDim2.new(0, 6, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = SelectedTheme.ElementAccent,
                BorderSizePixel = 0,
                ZIndex = 7,
                ThemeTag = "ElementAccent"
            })
            AddCorner(ActiveLine, 4)
            table.insert(Library.ThemeObjects.TabLabels, {Label = TabLabel, Btn = TabBtn})
        end

        local hoverTweenTab, leaveTweenTab
        TabBtn.MouseEnter:Connect(function()
            if ActiveTab and ActiveTab.Btn ~= TabBtn then
                if leaveTweenTab then leaveTweenTab:Cancel() end
                hoverTweenTab = TS:Create(TabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8})
                hoverTweenTab:Play()
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if ActiveTab and ActiveTab.Btn ~= TabBtn then
                if hoverTweenTab then hoverTweenTab:Cancel() end
                leaveTweenTab = TS:Create(TabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                leaveTweenTab:Play()
            end
        end)

        local Page = Create("ScrollingFrame", {
            Parent = PageContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = SelectedTheme.TextDark,
            BorderSizePixel = 0,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ZIndex = 6
        })
        
        local LeftCol, RightCol
        if Two_Column then
            local ColumnsHolder = Create("Frame", {
                Parent = Page,
                Size = UDim2.fromScale(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1
            })
            
            Create("UIListLayout", {
                Parent = ColumnsHolder,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            
            Create("UIPadding", {
                Parent = ColumnsHolder,
                PaddingTop = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 15)
            })
            
            LeftCol = Create("Frame", {
                Parent = ColumnsHolder,
                Size = UDim2.new(0.5, -5, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 1
            })
            
            local LeftLayout = Create("UIListLayout", {
                Parent = LeftCol,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            
            RightCol = Create("Frame", {
                Parent = ColumnsHolder,
                Size = UDim2.new(0.5, -5, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                LayoutOrder = 2
            })
            
            local RightLayout = Create("UIListLayout", {
                Parent = RightCol,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            
            local function UpdateCanvasSize()
                local maxH = math.max(LeftLayout.AbsoluteContentSize.Y, RightLayout.AbsoluteContentSize.Y)
                Page.CanvasSize = UDim2.new(0, 0, 0, maxH + 30)
            end
            
            LeftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)
            RightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)
        else
            local Layout = Create("UIListLayout", {
                Parent = Page,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 
            
            Create("UIPadding", {
                Parent = Page,
                PaddingTop = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 15)
            })
            
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 30)
            end)
        end

        local function Activate()
            if ActiveTab and ActiveTab.Btn == TabBtn then
                return
            end
            
            local OldTab = ActiveTab
            local Direction = (OldTab and MyIndex > OldTab.Index) and "Down" or "Up"
            ActiveTab = {Btn = TabBtn, Page = Page, Index = MyIndex}
            
            for _, v in pairs(TabContainer:GetChildren()) do 
                if v:IsA("TextButton") then 
                    TS:Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    local lbl = v:FindFirstChild("TabLabel")
                    local line = v:FindFirstChild("ActiveLine")
                    local icon = v:FindFirstChild("TabIcon")
                    
                    if lbl then
                        local isIconTab = icon ~= nil
                        TS:Create(lbl, TweenInfo.new(0.3), {TextColor3 = SelectedTheme.TextDark, Position = UDim2.new(0, isIconTab and 38 or 20, 0, 0)}):Play()
                    end
                    if line then
                        TS:Create(line, TweenInfo.new(0.3), {Size = UDim2.new(0, 3, 0, 0)}):Play()
                    end
                    if icon then
                        TS:Create(icon, TweenInfo.new(0.3), {ImageColor3 = SelectedTheme.TextDark}):Play()
                    end
                end 
            end

            TS:Create(TabBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
            TS:Create(TabLabel, TweenInfo.new(0.3), {TextColor3 = SelectedTheme.Text, Position = UDim2.new(0, HasIcon and 42 or 24, 0, 0)}):Play()
            
            if ActiveLine then
                TS:Create(ActiveLine, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 3, 0, 18)}):Play()
            end
            if TabIcon then
                TS:Create(TabIcon, TweenInfo.new(0.3), {ImageColor3 = SelectedTheme.ElementAccent}):Play()
            end

            if OldTab then
                local OldPage = OldTab.Page
                local OutPos = (Direction == "Down") and UDim2.new(0, 0, -1, 0) or UDim2.new(0, 0, 1, 0)
                TS:Create(OldPage, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = OutPos}):Play()
                task.delay(0.4, function()
                    if ActiveTab.Page ~= OldPage then
                        OldPage.Visible = false
                    end
                end)
            end
            
            Page.Visible = true
            Page.Position = (Direction == "Down") and UDim2.new(0, 0, 1, 0) or (Direction == "Up" and UDim2.new(0, 0, -1, 0) or UDim2.new(0, 0, 0, 0))
            if Direction ~= "None" then
                TS:Create(Page, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            end
        end
        
        TabBtn.MouseButton1Click:Connect(Activate)
        
        if MyIndex == 1 then
            Activate()
        end

        local function GetElements(TargetParent)
            local Elements = {}
            local ElementOrder = 0

            local function DefaultHover(btn)
                local hoverTween, leaveTween
                btn.MouseEnter:Connect(function()
                    if leaveTween then leaveTween:Cancel() end
                    hoverTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3})
                    hoverTween:Play()
                end)
                btn.MouseLeave:Connect(function()
                    if hoverTween then hoverTween:Cancel() end
                    leaveTween = TS:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5})
                    leaveTween:Play()
                end)
            end

            function Elements:CreateSection(Text)
                ElementOrder = ElementOrder + 1
                local Lab = Create("TextLabel", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = Text,
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = ElementOrder,
                    ZIndex = 8,
                    ThemeTag = "Text"
                })
                Create("UIPadding", { Parent = Lab, PaddingLeft = UDim.new(0, 6) })
            end

            function Elements:CreateButton(Cfg)
                ElementOrder = ElementOrder + 1
                local Btn = Create("TextButton", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Btn, 8)
                AddStroke(Btn, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Btn,
                    Size = UDim2.new(1, -20, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name or "Button",
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                CreateRipple(Btn, SelectedTheme.Accent)
                DefaultHover(Btn)
                
                Btn.MouseButton1Click:Connect(function()
                    TS:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -4, 0, 30), Position = UDim2.new(0, 2, 0, 2)}):Play()
                    task.wait(0.1)
                    TS:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 34), Position = UDim2.new(0, 0, 0, 0)}):Play()
                    if Cfg.Callback then
                        Cfg.Callback()
                    end
                end)
            end

            function Elements:CreateToggle(Cfg)
                ElementOrder = ElementOrder + 1
                local State = false
                local Flag = Cfg.Flag or Cfg.Name
                local Btn = Create("TextButton", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Btn, 8)
                AddStroke(Btn, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Btn,
                    Size = UDim2.new(1, -60, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name or "Toggle",
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                DefaultHover(Btn)
                
                local Box = Create("Frame", {
                    Parent = Btn,
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(1, -32, 0.5, -10),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 1,
                    ZIndex = 8
                })
                AddCorner(Box, 4)
                
                local BoxStroke = Create("UIStroke", {
                    Parent = Box, 
                    Color = SelectedTheme.TextDark, 
                    Transparency = 0.8, 
                    Thickness = 1
                })
                
                local InnerSquare = Create("Frame", {
                    Parent = Box,
                    Size = UDim2.fromScale(0, 0),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = SelectedTheme.TextDark,
                    BackgroundTransparency = 1,
                    ZIndex = 9
                })
                AddCorner(InnerSquare, 2)

                table.insert(Library.ThemeObjects.Toggles, {Box = Box, Stroke = BoxStroke, Square = InnerSquare, State = function() return State end})
                
                local function UpdateState(val)
                    State = val
                    Library.Flags[Flag] = val
                    
                    TS:Create(BoxStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Color = State and SelectedTheme.ElementAccent or SelectedTheme.TextDark,
                        Transparency = State and 0 or 0.8
                    }):Play()
                    
                    TS:Create(InnerSquare, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        BackgroundColor3 = State and SelectedTheme.ElementAccent or SelectedTheme.TextDark,
                        Size = State and UDim2.fromScale(0.6, 0.6) or UDim2.fromScale(0, 0),
                        BackgroundTransparency = State and 0 or 1
                    }):Play()
                    
                    if Cfg.Callback then
                        Cfg.Callback(State)
                    end
                end
                
                if Cfg.Default then
                    UpdateState(Cfg.Default)
                else
                    Library.Flags[Flag] = false
                end

                Btn.MouseButton1Click:Connect(function()
                    UpdateState(not State)
                end)
                
                Library.Items[Flag] = {
                    Set = function(val)
                        if val == nil then return end
                        if State == val then return end
                        UpdateState(val)
                    end
                }
            end

            function Elements:CreateSlider(Cfg)
                ElementOrder = ElementOrder + 1
                local Min = Cfg.Min or 0
                local Max = Cfg.Max or 100
                local Val = Cfg.Default or Cfg.Min
                local Flag = Cfg.Flag or Cfg.Name
                Library.Flags[Flag] = Val
                
                local Frame = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Frame, 8)
                AddStroke(Frame, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Frame,
                    Size = UDim2.new(1, -70, 0, 24),
                    Position = UDim2.new(0, 12, 0, 2),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name,
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local ValBg = Create("ScrollingFrame", {
                    Parent = Frame,
                    Size = UDim2.new(0, 36, 0, 20),
                    Position = UDim2.new(1, -48, 0, 4),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    ZIndex = 8,
                    ClipsDescendants = true,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 0,
                    ScrollingDirection = Enum.ScrollingDirection.X,
                    AutomaticCanvasSize = Enum.AutomaticSize.X
                })
                AddCorner(ValBg, 4)
                Create("UIPadding", { Parent = ValBg, PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) })

                local ValLbl = Create("TextBox", {
                    Parent = ValBg,
                    Size = UDim2.new(1, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Text = tostring(Val),
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 9,
                    ThemeTag = "Text",
                    TextWrapped = false,
                    ClearTextOnFocus = false
                })
                AttachHorizontalScroll(ValLbl, ValBg, Enum.TextXAlignment.Center)

                local SlideBar = Create("TextButton", {
                    Parent = Frame,
                    Size = UDim2.new(1, -24, 0, 6),
                    Position = UDim2.new(0, 12, 0, 28),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 45),
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 8
                })
                AddCorner(SlideBar, 10)
                
                local Fill = Create("Frame", {
                    Parent = SlideBar,
                    Size = UDim2.new((Val - Min) / (Max - Min), 0, 1, 0),
                    BackgroundColor3 = SelectedTheme.ElementAccent,
                    BorderSizePixel = 0,
                    ZIndex = 9,
                    ThemeTag = "ElementAccent"
                })
                AddCorner(Fill, 10)
                
                local Thumb = Create("Frame", {
                    Parent = Fill,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(1, -7, 0.5, -7),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    ZIndex = 10
                })
                AddCorner(Thumb, 10)
                
                local function Update(val)
                    val = math.clamp(val, Min, Max)
                    Val = val
                    Library.Flags[Flag] = val
                    ValLbl.Text = tostring(Val)
                    TS:Create(Fill, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new((Val - Min) / (Max - Min), 0, 1, 0)}):Play()
                    if Cfg.Callback then
                        Cfg.Callback(Val)
                    end
                end
                
                if Cfg.Default then
                    Update(Cfg.Default)
                elseif Cfg.Callback then
                    task.spawn(Cfg.Callback, Val)
                end
                
                local Dragging = false
                
                local function DragUpdate(input)
                    local p = math.clamp((input.Position.X - SlideBar.AbsolutePosition.X) / SlideBar.AbsoluteSize.X, 0, 1)
                    Update(math.floor(Min + ((Max - Min) * p)))
                end
                
                SlideBar.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        DragUpdate(i)
                        TS:Create(Thumb, TweenInfo.new(0.2), {Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(1, -9, 0.5, -9)}):Play()
                    end
                end)
                
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        Dragging = false
                        TS:Create(Thumb, TweenInfo.new(0.2), {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7)}):Play()
                    end
                end)
                
                UIS.InputChanged:Connect(function(i)
                    if Dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                        DragUpdate(i)
                    end
                end)
                
                ValLbl.FocusLost:Connect(function()
                    local number = tonumber(ValLbl.Text)
                    if number then
                        Update(number)
                    else
                        ValLbl.Text = tostring(Val)
                    end
                end)

                Library.Items[Flag] = {Set = Update}
            end

            function Elements:CreateInput(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local Frame = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Frame, 8)
                AddStroke(Frame, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Frame,
                    Size = UDim2.new(1, -130, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name,
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local BoxContainer = Create("ScrollingFrame", { 
                    Parent = Frame,
                    Size = UDim2.new(0, 120, 0, 26),
                    Position = UDim2.new(1, -128, 0.5, -13), 
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    ZIndex = 8, 
                    ClipsDescendants = true,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    ScrollBarThickness = 0, 
                    ScrollingDirection = Enum.ScrollingDirection.X,
                    AutomaticCanvasSize = Enum.AutomaticSize.X 
                })
                AddCorner(BoxContainer, 6)
                Create("UIPadding", { Parent = BoxContainer, PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })

                local BoxStroke = Create("UIStroke", {
                    Parent = BoxContainer, 
                    Color = SelectedTheme.TextDark, 
                    Transparency = 0.8, 
                    Thickness = 1, 
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                table.insert(Library.ThemeObjects.TextDark, BoxStroke)

                local Box = Create("TextBox", {
                    Parent = BoxContainer,
                    Size = UDim2.new(1, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Text = Cfg.Default or "",
                    PlaceholderText = Cfg.Placeholder or "Type...",
                    TextColor3 = SelectedTheme.Text,
                    Font = Library.GlobalFont,
                    TextSize = 13,
                    ZIndex = 9,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ThemeTag = "Text",
                    TextWrapped = false,
                    ClearTextOnFocus = false
                })
                AttachHorizontalScroll(Box, BoxContainer, Enum.TextXAlignment.Left)

                Box.Focused:Connect(function()
                    TS:Create(BoxStroke, TweenInfo.new(0.3), {Color = SelectedTheme.ElementAccent, Transparency = 0}):Play()
                end)
                
                Box.FocusLost:Connect(function()
                    TS:Create(BoxStroke, TweenInfo.new(0.3), {Color = SelectedTheme.TextDark, Transparency = 0.8}):Play()
                end)

                local function Update(val)
                    Box.Text = val
                    if Cfg.Callback then
                        Cfg.Callback(val)
                    end
                end
                
                if Cfg.Default then
                    Library.Flags[Flag] = Cfg.Default
                    if Cfg.Callback then
                        task.spawn(Cfg.Callback, Cfg.Default)
                    end
                end
                
                Box.FocusLost:Connect(function()
                    Update(Box.Text)
                end)
                
                Library.Items[Flag] = {Set = Update}
            end

            function Elements:CreateDropdown(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local Expanded = false
                local Selected = Cfg.Default
                local Options = Cfg.Items or {}
                
                local Drop = Create("TextButton", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    Text = "",
                    AutoButtonColor = false,
                    ClipsDescendants = true,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Drop, 8)
                AddStroke(Drop, SelectedTheme).Transparency = 0.8

                DefaultHover(Drop)
                
                local Title = Create("TextLabel", {
                    Parent = Drop,
                    Size = UDim2.new(1, -40, 0, 34),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = (Cfg.Name or "Dropdown") .. (Selected and " - " .. tostring(Selected) or ""),
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local Arrow = Create("ImageLabel", {
                    Parent = Drop,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(1, -28, 0, 9),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://6031091004",
                    ImageColor3 = SelectedTheme.TextDark,
                    ZIndex = 8
                })
                table.insert(Library.ThemeObjects.TextDark, Arrow)

                local Container = Create("ScrollingFrame", {
                    Parent = Drop,
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 34),
                    BackgroundTransparency = 1,
                    ZIndex = 8,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = SelectedTheme.TextDark,
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                
                Create("UIPadding", {
                    Parent = Container,
                    PaddingTop = UDim.new(0, 5),
                    PaddingBottom = UDim.new(0, 5),
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10)
                })
                
                local ListLayout = Create("UIListLayout", { Parent = Container, Padding = UDim.new(0, 4) })
                
                local function Update(val) 
                    Selected = val 
                    Title.Text = (Cfg.Name or "Dropdown") .. " - " .. tostring(Selected) 
                    if Cfg.Callback then
                        Cfg.Callback(val)
                    end
                    Library.Flags[Flag] = val
                end

                local function RefreshList(newOptions)
                    Options = newOptions or Options
                    for _, v in pairs(Container:GetChildren()) do
                        if v:IsA("TextButton") then
                            v:Destroy()
                        end
                    end
                    
                    local found = false
                    for _, v in pairs(Options) do
                        if v == Selected then
                            found = true
                            break
                        end
                    end
                    
                    if found then
                        Title.Text = (Cfg.Name or "Dropdown") .. " - " .. tostring(Selected)
                    else
                        Selected = nil
                        Title.Text = Cfg.Name or "Dropdown"
                    end

                    for _, item in pairs(Options) do
                        local Btn = Create("TextButton", {
                            Parent = Container,
                            Size = UDim2.new(1, 0, 0, 28),
                            Position = UDim2.new(0, 0, 0, 0),
                            BackgroundColor3 = SelectedTheme.Main,
                            BackgroundTransparency = 0.8,
                            Text = tostring(item),
                            Font = Library.GlobalFont,
                            TextColor3 = SelectedTheme.TextDark,
                            TextSize = 13,
                            ZIndex = 9,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            AutoButtonColor = false,
                            ThemeTag = "Main"
                        })
                        AddCorner(Btn, 6)
                        table.insert(Library.ThemeObjects.TextDark, Btn)

                        local hoverTweenBtn, leaveTweenBtn
                        Btn.MouseEnter:Connect(function()
                            if leaveTweenBtn then leaveTweenBtn:Cancel() end
                            hoverTweenBtn = TS:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextColor3 = SelectedTheme.Text})
                            hoverTweenBtn:Play()
                        end)
                        Btn.MouseLeave:Connect(function()
                            if hoverTweenBtn then hoverTweenBtn:Cancel() end
                            leaveTweenBtn = TS:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, TextColor3 = SelectedTheme.TextDark})
                            leaveTweenBtn:Play()
                        end)
                        Btn.MouseButton1Click:Connect(function()
                            Update(item)
                            Expanded = false
                            TS:Create(Drop, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 34)}):Play()
                            TS:Create(Arrow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        end)
                    end
                    Container.CanvasSize = UDim2.new(0, 0, 0, #Options * 32 + 10)
                end
                
                RefreshList(Options)
                
                if Cfg.Default and Cfg.Callback then
                    task.spawn(Cfg.Callback, Selected)
                end

                Drop.MouseButton1Click:Connect(function()
                    if Cfg.UpdateList then
                        RefreshList(Cfg.UpdateList())
                    end
                    Expanded = not Expanded
                    local H = Expanded and math.min(#Options * 32 + 44, 180) or 34
                    TS:Create(Drop, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, H)}):Play()
                    TS:Create(Arrow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = Expanded and 180 or 0}):Play()
                    TS:Create(Container, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, -34)}):Play()
                end)
                
                Library.Items[Flag] = {
                    Set = Update,
                    Refresh = function(self, list) RefreshList(list) end,
                    Get = function() return Selected end
                }
                
                return Library.Items[Flag]
            end

            function Elements:CreateColorPicker(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local Color = Cfg.Default or Color3.fromRGB(255, 255, 255)
                Library.Flags[Flag] = {R = Color.R, G = Color.G, B = Color.B}
                local IsExpanded = false
                
                local Wrapper = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ClipsDescendants = true,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Wrapper, 8)
                AddStroke(Wrapper, SelectedTheme).Transparency = 0.8

                local TriggerBtn = Create("TextButton", { Parent = Wrapper, Size = UDim2.new(1, 0, 0, 34), BackgroundTransparency = 1, Text = "", ZIndex = 8 })
                
                Create("TextLabel", { 
                    Parent = TriggerBtn, 
                    Size = UDim2.new(1, -50, 1, 0), 
                    Position = UDim2.new(0, 12, 0, 0), 
                    BackgroundTransparency = 1, 
                    Text = Cfg.Name or "Color Picker", 
                    Font = Library.GlobalFont, 
                    TextColor3 = SelectedTheme.Text, 
                    TextSize = 14, 
                    TextXAlignment = Enum.TextXAlignment.Left, 
                    ZIndex = 9, 
                    TextTruncate = Enum.TextTruncate.AtEnd, 
                    ThemeTag = "Text" 
                })
                
                local PreviewContainer = Create("Frame", {
                    Parent = TriggerBtn,
                    Size = UDim2.new(0, 30, 0, 20),
                    Position = UDim2.new(1, -42, 0.5, -10),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    ZIndex = 9
                })
                AddCorner(PreviewContainer, 6)
                Create("UIStroke", {Parent = PreviewContainer, Color = SelectedTheme.TextDark, Transparency = 0.8, Thickness = 1})

                local Preview = Create("Frame", { Parent = PreviewContainer, Size = UDim2.new(1, -4, 1, -4), Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = Color, ZIndex = 10 })
                AddCorner(Preview, 4)
                
                local Container = Create("Frame", { Parent = Wrapper, Size = UDim2.new(1, 0, 0, 160), Position = UDim2.new(0, 0, 0, 34), BackgroundTransparency = 1, ZIndex = 8 })
                
                local BoxContainer = Create("Frame", { Parent = Container, Size = UDim2.new(0, 140, 1, 0), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, ZIndex = 9 })
                
                Create("TextLabel", { 
                    Parent = BoxContainer, 
                    Size = UDim2.new(1, 0, 0, 20), 
                    Position = UDim2.new(0, 12, 0, 5), 
                    BackgroundTransparency = 1, 
                    Text = "RGB / Hex", 
                    TextColor3 = SelectedTheme.TextDark, 
                    Font = Library.GlobalFontBold, 
                    TextSize = 12, 
                    TextXAlignment = Enum.TextXAlignment.Left, 
                    ZIndex = 10, 
                    ThemeTag = "TextDark" 
                })
                
                local function CreateCBox(parent, size, pos, txt)
                    local box = Create("TextBox", {
                        Parent = parent,
                        Size = size,
                        Position = pos,
                        Text = txt,
                        BackgroundColor3 = Color3.new(0, 0, 0),
                        BackgroundTransparency = 0.85,
                        TextColor3 = SelectedTheme.Text,
                        Font = Library.GlobalFont,
                        TextSize = 12,
                        ZIndex = 10,
                        ThemeTag = "Text"
                    })
                    AddCorner(box, 4)
                    local boxStroke = Create("UIStroke", {Parent = box, Color = SelectedTheme.TextDark, Transparency = 0.8, Thickness = 1})
                    table.insert(Library.ThemeObjects.TextDark, boxStroke)
                    return box
                end

                local RInput = CreateCBox(BoxContainer, UDim2.new(0, 36, 0, 28), UDim2.new(0, 12, 0, 30), math.floor(Color.R * 255))
                local GInput = CreateCBox(BoxContainer, UDim2.new(0, 36, 0, 28), UDim2.new(0, 54, 0, 30), math.floor(Color.G * 255))
                local BInput = CreateCBox(BoxContainer, UDim2.new(0, 36, 0, 28), UDim2.new(0, 96, 0, 30), math.floor(Color.B * 255))
                local HexInput = CreateCBox(BoxContainer, UDim2.new(0, 120, 0, 28), UDim2.new(0, 12, 0, 66), "#" .. Color:ToHex())
                
                local PalContainer = Create("Frame", { Parent = Container, Size = UDim2.new(1, -150, 1, -20), Position = UDim2.new(0, 140, 0, 10), BackgroundTransparency = 1, ZIndex = 9 })
                local h, s, v = Color:ToHSV()
                
                local SVMap = Create("ImageButton", {
                    Parent = PalContainer,
                    Size = UDim2.new(1, -15, 0, 115),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Color3.fromHSV(h, 1, 1),
                    Image = "rbxassetid://4155801252",
                    ZIndex = 10,
                    AutoButtonColor = false
                })
                AddCorner(SVMap, 6)
                
                local SVTrigger = Create("TextButton", { Parent = SVMap, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 100 })
                
                local SVCursor = Create("Frame", {
                    Parent = SVMap,
                    Size = UDim2.new(0, 8, 0, 8),
                    Position = UDim2.fromScale(s, 1 - v),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    ZIndex = 12,
                    AnchorPoint = Vector2.new(0.5, 0.5)
                })
                AddCorner(SVCursor, 100)
                Create("UIStroke", {Parent = SVCursor, Color = Color3.new(0, 0, 0), Thickness = 1})
                
                local HueBar = Create("ImageButton", {
                    Parent = PalContainer,
                    Size = UDim2.new(1, -15, 0, 12),
                    Position = UDim2.new(0, 0, 0, 125),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    ZIndex = 10,
                    AutoButtonColor = false
                })
                AddCorner(HueBar, 6)
                Create("UIGradient", { 
                    Parent = HueBar, 
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), 
                        ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)), 
                        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)), 
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), 
                        ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)), 
                        ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)), 
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    } 
                })
                
                local HueTrigger = Create("TextButton", { Parent = HueBar, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 100 })
                
                local HueCursor = Create("Frame", { 
                    Parent = HueBar, 
                    Size = UDim2.new(0, 4, 1, 4), 
                    Position = UDim2.fromScale(h, 0.5), 
                    AnchorPoint = Vector2.new(0.5, 0.5), 
                    BackgroundColor3 = Color3.new(1, 1, 1), 
                    ZIndex = 11 
                })
                AddCorner(HueCursor, 2)
                Create("UIStroke", {Parent = HueCursor, Color = Color3.new(0, 0, 0), Thickness = 1})
                
                TriggerBtn.MouseButton1Click:Connect(function()
                    IsExpanded = not IsExpanded
                    TS:Create(Wrapper, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = IsExpanded and UDim2.new(1, 0, 0, 194) or UDim2.new(1, 0, 0, 34)}):Play()
                end)

                local function Update(col)
                    Color = col
                    h, s, v = Color:ToHSV()
                    Preview.BackgroundColor3 = Color
                    SVMap.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    SVCursor.Position = UDim2.fromScale(s, 1 - v)
                    HueCursor.Position = UDim2.fromScale(h, 0.5)
                    RInput.Text = math.floor(Color.R * 255)
                    GInput.Text = math.floor(Color.G * 255)
                    BInput.Text = math.floor(Color.B * 255)
                    HexInput.Text = "#" .. Color:ToHex()
                    Library.Flags[Flag] = {R = Color.R, G = Color.G, B = Color.B}
                    if Cfg.Callback then
                        Cfg.Callback(Color)
                    end
                end
                
                if Cfg.Default and Cfg.Callback then
                    task.spawn(Cfg.Callback, Color)
                end
                
                local function VisualUpdate(newH, newS, newV)
                    h = newH or h
                    s = newS or s
                    v = newV or v
                    Update(Color3.fromHSV(h, s, v))
                end
                
                RInput.FocusLost:Connect(function()
                    local r = tonumber(RInput.Text)
                    if r then
                        local c = Color3.fromRGB(math.clamp(r, 0, 255), Color.G * 255, Color.B * 255)
                        VisualUpdate(c:ToHSV())
                    end
                end)
                
                GInput.FocusLost:Connect(function()
                    local g = tonumber(GInput.Text)
                    if g then
                        local c = Color3.fromRGB(Color.R * 255, math.clamp(g, 0, 255), Color.B * 255)
                        VisualUpdate(c:ToHSV())
                    end
                end)
                
                BInput.FocusLost:Connect(function()
                    local b = tonumber(BInput.Text)
                    if b then
                        local c = Color3.fromRGB(Color.R * 255, Color.G * 255, math.clamp(b, 0, 255))
                        VisualUpdate(c:ToHSV())
                    end
                end)
                
                HexInput.FocusLost:Connect(function()
                    local success, c = pcall(function() return Color3.fromHex(HexInput.Text) end)
                    if success then
                        VisualUpdate(c:ToHSV())
                    end
                end)

                local draggingSV = false
                local draggingHue = false
                local dragConnection
                
                local function StartDragging()
                    if not dragConnection then
                        dragConnection = RS.RenderStepped:Connect(function()
                            if draggingSV then
                                VisualUpdate(nil, math.clamp((Mouse.X - SVMap.AbsolutePosition.X) / SVMap.AbsoluteSize.X, 0, 1), 1 - math.clamp((Mouse.Y - SVMap.AbsolutePosition.Y) / SVMap.AbsoluteSize.Y, 0, 1))
                            elseif draggingHue then
                                VisualUpdate(math.clamp((Mouse.X - HueBar.AbsolutePosition.X) / HueBar.AbsoluteSize.X, 0, 1), nil, nil)
                            end
                        end)
                    end
                end

                local function StopDragging()
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                end

                SVTrigger.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingSV = true
                        StartDragging()
                    end
                end)
                
                HueTrigger.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingHue = true
                        StartDragging()
                    end
                end)
                
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        draggingSV = false
                        draggingHue = false
                        StopDragging()
                    end
                end)
                
                Library.Items[Flag] = {
                    Set = function(t)
                        if type(t) == "table" then
                            Update(Color3.new(t.R, t.G, t.B))
                        else
                            Update(t)
                        end
                    end
                }
            end

            function Elements:CreateKeybind(Cfg)
                ElementOrder = ElementOrder + 1
                local Flag = Cfg.Flag or Cfg.Name
                local CurrentKey = Cfg.Default or Enum.KeyCode.RightControl
                Library.Flags[Flag] = CurrentKey.Name
                local Binding = false
                
                local Frame = Create("Frame", {
                    Parent = TargetParent,
                    Size = UDim2.new(1, 0, 0, 34),
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 7,
                    LayoutOrder = ElementOrder,
                    ThemeTag = "Second"
                })
                AddCorner(Frame, 8)
                AddStroke(Frame, SelectedTheme).Transparency = 0.8

                Create("TextLabel", {
                    Parent = Frame,
                    Size = UDim2.new(1, -110, 1, 0),
                    Position = UDim2.new(0, 12, 0, 0),
                    BackgroundTransparency = 1,
                    Text = Cfg.Name,
                    Font = Library.GlobalFont,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 8,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = "Text"
                })
                
                local BindBtn = Create("TextButton", {
                    Parent = Frame,
                    Size = UDim2.new(0, 70, 0, 24),
                    Position = UDim2.new(1, -82, 0.5, -12),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 0.85,
                    Text = KeyMap[CurrentKey.Name] or CurrentKey.Name,
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.TextDark,
                    TextSize = 12,
                    ZIndex = 9,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                AddCorner(BindBtn, 6)
                local BindStroke = Create("UIStroke", {Parent = BindBtn, Color = SelectedTheme.TextDark, Transparency = 0.8, Thickness = 1})
                
                table.insert(Library.ThemeObjects.Keybinds, BindBtn)
                table.insert(Library.ThemeObjects.TextDark, BindStroke)

                local hoverTweenBind, leaveTweenBind
                BindBtn.MouseEnter:Connect(function()
                    if leaveTweenBind then leaveTweenBind:Cancel() end
                    hoverTweenBind = TS:Create(BindBtn, TweenInfo.new(0.2), {TextColor3 = SelectedTheme.Text})
                    hoverTweenBind:Play()
                end)
                
                BindBtn.MouseLeave:Connect(function()
                    if not Binding then
                        if hoverTweenBind then hoverTweenBind:Cancel() end
                        leaveTweenBind = TS:Create(BindBtn, TweenInfo.new(0.2), {TextColor3 = SelectedTheme.TextDark})
                        leaveTweenBind:Play()
                    end
                end)
                
                local function Update(key)
                    CurrentKey = key
                    BindBtn.Text = KeyMap[key.Name] or key.Name
                    BindBtn.TextColor3 = SelectedTheme.TextDark
                    Library.Flags[Flag] = key.Name
                    Binding = false
                end
                
                BindBtn.MouseButton1Click:Connect(function()
                    Binding = true
                    BindBtn.Text = "..."
                    BindBtn.TextColor3 = SelectedTheme.Accent
                end)
                
                local Connection
                Connection = UIS.InputBegan:Connect(function(input, gpe) 
                    if not Frame.Parent then
                        Connection:Disconnect()
                        return
                    end 
                    if not Binding then 
                        if input.KeyCode == CurrentKey and not gpe and not UIS:GetFocusedTextBox() then 
                            if Cfg.Callback then
                                Cfg.Callback(input.KeyCode)
                            end 
                        end 
                    elseif input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.Unknown then 
                        Update(input.KeyCode) 
                    end 
                end)
                
                Library.Items[Flag] = {
                    Set = function(keyName)
                        if Enum.KeyCode[keyName] then
                            Update(Enum.KeyCode[keyName])
                        end
                    end
                }
            end

            return Elements
        end

        local TabElements = GetElements(Page)

        if Two_Column then
            function TabElements:CreateBlock(BlockCfg)
                local BlockName = BlockCfg.Name or "Block"
                local Side = BlockCfg.Side or "Left"
                local TargetColumn = (Side == "Right" and RightCol) or LeftCol
                
                local BlockFrame = Create("Frame", {
                    Parent = TargetColumn,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = SelectedTheme.Second,
                    BackgroundTransparency = 0.5,
                    ZIndex = 5,
                    ThemeTag = "Second"
                })
                AddCorner(BlockFrame, 8)

                local BlockStroke = Create("UIStroke", { Parent = BlockFrame, Color = Color3.new(1, 1, 1), Transparency = 0.7, Thickness = 1 })
                local BlockGrad = Create("UIGradient", { Parent = BlockStroke, Color = SelectedTheme.Gradient })
                table.insert(Library.GradientObjects, BlockGrad)
                
                Create("Frame", {
                    Parent = BlockFrame,
                    Size = UDim2.new(1, -24, 0, 1),
                    Position = UDim2.new(0, 12, 0, 36),
                    BackgroundColor3 = SelectedTheme.TextDark,
                    BackgroundTransparency = 0.8,
                    BorderSizePixel = 0,
                    ZIndex = 6,
                    ThemeTag = "TextDark"
                })
                
                local HasIcon = (BlockCfg.ImageID ~= nil and BlockCfg.ImageID ~= "")
                local TitleOffsetX = 12
                
                if HasIcon then
                    local BlockIcon = Create("ImageLabel", {
                        Parent = BlockFrame,
                        Size = UDim2.new(0, 18, 0, 18),
                        Position = UDim2.new(0, 12, 0, 9),
                        BackgroundTransparency = 1,
                        ImageColor3 = SelectedTheme.TextDark,
                        ZIndex = 6
                    })
                    SetImageAsync(BlockIcon, "Image", BlockCfg.ImageID)
                    TitleOffsetX = 36
                    table.insert(Library.ThemeObjects.TextDark, BlockIcon)
                end
                
                Create("TextLabel", {
                    Parent = BlockFrame,
                    Size = UDim2.new(1, -TitleOffsetX - 12, 0, 36),
                    Position = UDim2.new(0, TitleOffsetX, 0, 0),
                    BackgroundTransparency = 1,
                    Text = BlockName,
                    Font = Library.GlobalFontBold,
                    TextColor3 = SelectedTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 6,
                    ThemeTag = "Text"
                })
                
                local BlockContent = Create("Frame", {
                    Parent = BlockFrame,
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 42),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    ZIndex = 5
                })
                
                Create("UIListLayout", { Parent = BlockContent, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
                Create("UIPadding", { Parent = BlockContent, PaddingTop = UDim.new(0, 2), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })
                
                return GetElements(BlockContent)
            end
        end
        
        return TabElements, Activate
    end

    local SettingsTab, OpenSettingsFunc = Funcs:CreateTab("Settings", true) 
    
    for _, v in pairs(TabContainer:GetChildren()) do 
        if v:IsA("TextButton") then
            local lbl = v:FindFirstChild("TabLabel")
            if lbl and lbl.Text == "Settings" then
                v.Visible = false
                break 
            end
        end 
    end

    OpenSettingsBtn.MouseButton1Click:Connect(function()
        if OpenSettingsFunc then
            OpenSettingsFunc()
        end
    end)

    local AppBlock = SettingsTab:CreateBlock({Name = "Appearance", Side = "Left"})
    
    AppBlock:CreateDropdown({
        Name = "Font",
        Flag = "Settings_Font",
        Items = AvailableFonts,
        Default = Library.GlobalFont.Name,
        Callback = function(val)
            UpdateFonts(val)
        end
    })
    
    AppBlock:CreateSlider({
        Name = "Image Transparency",
        Flag = "Settings_ImageTrans",
        Min = 0,
        Max = 100,
        Default = math.floor(ImageTrans * 100),
        Callback = function(val)
            MainBgImage.ImageTransparency = val / 100
        end
    })
    
    AppBlock:CreateSlider({
        Name = "Background Transparency",
        Flag = "Settings_BgTrans",
        Min = 0,
        Max = 100,
        Default = math.floor(WindowTrans * 100),
        Callback = function(val)
            local t = val / 100
            MainBgColor.BackgroundTransparency = t
        end
    })
    
    AppBlock:CreateSlider({
        Name = "Orbs Transparency",
        Flag = "Settings_OrbTrans",
        Min = 0,
        Max = 100,
        Default = math.floor(OrbsTrans * 100),
        Callback = function(val)
            local t = val / 100
            OrbsTrans = t
            for _, child in pairs(OrbContainer:GetChildren()) do
                if child:IsA("Frame") then
                    child.BackgroundTransparency = t
                end
            end
        end
    })
    
    AppBlock:CreateInput({
        Name = "Background ID",
        Flag = "Settings_BgImage",
        Placeholder = "ID...",
        Callback = function(val)
            val = GetAssetId(val)
            SetImageAsync(MainBgImage, "Image", val)
            SelectedTheme.Background = val
        end
    })

    AppBlock:CreateSlider({
        Name = "Corner Radius",
        Flag = "Settings_CornerRadius",
        Min = 0,
        Max = 10,
        Default = Library.GlobalCornerValue,
        Callback = function(val)
            UpdateCorners(val)
        end
    })

    local KeyBlock = SettingsTab:CreateBlock({Name = "Keybinds", Side = "Left"})
    
    KeyBlock:CreateKeybind({
        Name = "Toggle UI",
        Flag = "Settings_ToggleKey",
        Default = Library.ToggleKey,
        Callback = function() end
    })

    local ConfigBlock = SettingsTab:CreateBlock({Name = "Config Manager", Side = "Left"})

    local ConfigNameInput = "MyConfig"
    ConfigBlock:CreateInput({
        Name = "Config Name",
        Flag = "Settings_CfgName",
        Default = "MyConfig",
        Callback = function(v)
            ConfigNameInput = v
        end
    })
    
    ConfigBlock:CreateButton({
        Name = "Save Config",
        Callback = function()
            Library:SaveConfig(ConfigNameInput)
        end
    })

    local LoadDropCfg = ConfigBlock:CreateDropdown({
        Name = "Load Config",
        Flag = "Settings_CfgLoad",
        Items = Library:GetConfigs(),
        UpdateList = function()
            return Library:GetConfigs()
        end,
        Callback = function(val)
            Library:LoadConfig(val)
            if Library.Flags["Settings_AutoLoadToggle"] then
                writefile(AutoloadPath, val)
            end
        end
    })

    ConfigBlock:CreateButton({
        Name = "Delete Selected Config",
        Callback = function()
            local sel = LoadDropCfg:Get()
            if sel and isfile(Library.ConfigFolder .. "/" .. sel .. ".json") then
                Library:DeleteConfig(sel)
            end
        end
    })

    local currentAutoLoad = ""
    if isfile(AutoloadPath) then
        currentAutoLoad = readfile(AutoloadPath)
    end

    ConfigBlock:CreateToggle({
        Name = "Auto Load Selected Config",
        Flag = "Settings_AutoLoadToggle",
        Default = true,
        Callback = function(val)
            if val then
                local sel = LoadDropCfg:Get()
                if sel then
                    writefile(AutoloadPath, sel)
                end
            else
                if isfile(AutoloadPath) then
                    delfile(AutoloadPath)
                end
            end
        end
    })

    local ColorBlock = SettingsTab:CreateBlock({Name = "Theme Colors", Side = "Right"})
    
    ColorBlock:CreateColorPicker({
        Name = "MainColor",
        Flag = "Settings_MainColor",
        Default = SelectedTheme.Main,
        Callback = function(c)
            SelectedTheme.Main = c
            Themes.Default.Main = c
            UpdateThemeObjects()
        end
    }) 
    
    ColorBlock:CreateColorPicker({
        Name = "Second Color",
        Flag = "Settings_SecondColor",
        Default = SelectedTheme.Second,
        Callback = function(c)
            SelectedTheme.Second = c
            Themes.Default.Second = c
            UpdateThemeObjects()
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Element Color",
        Flag = "Settings_ElementColor",
        Default = SelectedTheme.ElementAccent,
        Callback = function(c)
            SelectedTheme.ElementAccent = c
            Themes.Default.ElementAccent = c
            UpdateThemeObjects()
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Text Color",
        Flag = "Settings_TextColor",
        Default = SelectedTheme.Text,
        Callback = function(c) 
            SelectedTheme.Text = c
            Themes.Default.Text = c
            UpdateThemeObjects()
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Gradient Start",
        Flag = "Settings_GradStart",
        Default = SelectedTheme.GradientStart or SelectedTheme.Accent,
        Callback = function(c)
            SelectedTheme.GradientStart = c
            SelectedTheme.Gradient = GetGradientSeq(SelectedTheme)
            UpdateGradients(SelectedTheme.Gradient)
        end
    })
    
    ColorBlock:CreateColorPicker({
        Name = "Gradient End",
        Flag = "Settings_GradEnd",
        Default = SelectedTheme.GradientEnd or SelectedTheme.Accent,
        Callback = function(c)
            SelectedTheme.GradientEnd = c
            SelectedTheme.Gradient = GetGradientSeq(SelectedTheme)
            UpdateGradients(SelectedTheme.Gradient)
        end
    })

    local ThemeBlock = SettingsTab:CreateBlock({Name = "Theme Manager", Side = "Right"})
    
    local ThemeNameInput = "MyTheme"
    ThemeBlock:CreateInput({
        Name = "Theme Name",
        Flag = "Settings_ThemeName",
        Default = "MyTheme",
        Callback = function(v)
            ThemeNameInput = v
        end
    })
    
    ThemeBlock:CreateButton({
        Name = "Save Theme",
        Callback = function()
            local ThemeConfig = {
                Main = {R = SelectedTheme.Main.R, G = SelectedTheme.Main.G, B = SelectedTheme.Main.B},
                Second = {R = SelectedTheme.Second.R, G = SelectedTheme.Second.G, B = SelectedTheme.Second.B},
                Accent = {R = SelectedTheme.Accent.R, G = SelectedTheme.Accent.G, B = SelectedTheme.Accent.B},
                ElementAccent = {R = SelectedTheme.ElementAccent.R, G = SelectedTheme.ElementAccent.G, B = SelectedTheme.ElementAccent.B},
                Text = {R = SelectedTheme.Text.R, G = SelectedTheme.Text.G, B = SelectedTheme.Text.B},
                TextDark = {R = SelectedTheme.TextDark.R, G = SelectedTheme.TextDark.G, B = SelectedTheme.TextDark.B},
                Error = {R = SelectedTheme.Error.R, G = SelectedTheme.Error.G, B = SelectedTheme.Error.B},
                GradientStart = {R = SelectedTheme.GradientStart.R, G = SelectedTheme.GradientStart.G, B = SelectedTheme.GradientStart.B},
                GradientEnd = {R = SelectedTheme.GradientEnd.R, G = SelectedTheme.GradientEnd.G, B = SelectedTheme.GradientEnd.B},
                Background = SelectedTheme.Background,
                Transparency = MainBgColor.BackgroundTransparency,
                ImageTransparency = MainBgImage.ImageTransparency,
                OrbsTransparency = OrbsTrans,
                Font = Library.GlobalFont.Name,
                CornerRadius = Library.GlobalCornerValue
            }
            writefile(Library.ThemeFolder .. "/" .. ThemeNameInput .. ".json", HS:JSONEncode(ThemeConfig))
            Library:Notify({Title = "Theme Saved", Content = "Saved as " .. ThemeNameInput})
        end
    })

    local LoadDrop = ThemeBlock:CreateDropdown({
        Name = "Load Theme",
        Flag = "Settings_ThemeLoad",
        Items = Library:GetThemes(),
        UpdateList = function()
            return Library:GetThemes()
        end,
        Callback = function(val)
            local NewTheme = GetTheme(val)
            MainBgColor.BackgroundColor3 = NewTheme.Main
            SetImageAsync(MainBgImage, "Image", NewTheme.Background or "")
            MainBgColor.BackgroundTransparency = NewTheme.Transparency or 0.25
            MainBgImage.ImageTransparency = NewTheme.ImageTransparency or 0
            OrbsTrans = NewTheme.OrbsTransparency or 0.5
            
            for _, child in pairs(OrbContainer:GetChildren()) do
                if child:IsA("Frame") then
                    child.BackgroundTransparency = OrbsTrans
                end
            end
            
            SelectedTheme = NewTheme
            Themes.Default.Main = NewTheme.Main
            Themes.Default.Second = NewTheme.Second
            Themes.Default.Accent = NewTheme.Accent
            Themes.Default.ElementAccent = NewTheme.ElementAccent
            Themes.Default.Text = NewTheme.Text
            
            if NewTheme.Font then
                UpdateFonts(NewTheme.Font)
            end
            
            UpdateThemeObjects()
            UpdateGradients(SelectedTheme.Gradient)

            if Library.Items["Settings_MainColor"] then Library.Items["Settings_MainColor"].Set(NewTheme.Main) end
            if Library.Items["Settings_SecondColor"] then Library.Items["Settings_SecondColor"].Set(NewTheme.Second) end
            if Library.Items["Settings_ElementColor"] then Library.Items["Settings_ElementColor"].Set(NewTheme.ElementAccent) end
            if Library.Items["Settings_TextColor"] then Library.Items["Settings_TextColor"].Set(NewTheme.Text) end
            if Library.Items["Settings_GradStart"] then Library.Items["Settings_GradStart"].Set(NewTheme.GradientStart or NewTheme.Accent) end
            if Library.Items["Settings_GradEnd"] then Library.Items["Settings_GradEnd"].Set(NewTheme.GradientEnd or NewTheme.Accent) end
            if Library.Items["Settings_BgTrans"] then Library.Items["Settings_BgTrans"].Set(math.floor((NewTheme.Transparency or 0.25) * 100)) end
            if Library.Items["Settings_ImageTrans"] then Library.Items["Settings_ImageTrans"].Set(math.floor((NewTheme.ImageTransparency or 0) * 100)) end
            if Library.Items["Settings_OrbTrans"] then Library.Items["Settings_OrbTrans"].Set(math.floor((NewTheme.OrbsTransparency or 0.5) * 100)) end
            if Library.Items["Settings_BgImage"] then Library.Items["Settings_BgImage"].Set(NewTheme.Background or "") end
            if Library.Items["Settings_Font"] and NewTheme.Font then Library.Items["Settings_Font"].Set(NewTheme.Font) end
            if Library.Items["Settings_CornerRadius"] then Library.Items["Settings_CornerRadius"].Set(NewTheme.CornerRadius or 10) end

            Library:Notify({Title = "Theme Loaded", Content = "Loaded " .. val})
        end
    })

    ThemeBlock:CreateButton({
        Name = "Delete Selected Theme",
        Callback = function()
            local selected = LoadDrop:Get()
            if selected and isfile(Library.ThemeFolder .. "/" .. selected .. ".json") then
                delfile(Library.ThemeFolder .. "/" .. selected .. ".json")
                Library:Notify({Title = "Theme Deleted", Content = "Deleted " .. selected})
            else
                Library:Notify({Title = "Error", Content = "Select a valid theme first"})
            end
        end
    })

    return Funcs
end

return Library

хочу изменить нотифи на такое же как в гуи ниже

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local TxS = game:GetService("TextService")
local HS = game:GetService("HttpService")
local RS = game:GetService("RunService")
local CG = game:GetService("CoreGui")

local make_folder = makefolder or function()
end
local write_file = writefile or function()
end
local read_file = readfile or function()
    return nil
end
local is_file = isfile or function()
    return false
end
local list_files = listfiles or function()
    return {}
end
local del_file = delfile or function()
end

local isMobile = UIS.TouchEnabled

local function Create(className, properties, children)
    local inst = Instance.new(className)
    for k, v in pairs(properties or {}) do
        inst[k] = v
    end
    for _, child in pairs(children or {}) do
        child.Parent = inst
    end
    return inst
end

local function Tween(instance, properties, durationOrTweenInfo)
    local info
    if typeof(durationOrTweenInfo) == "number" then
        info = TweenInfo.new(durationOrTweenInfo, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    else
        info = durationOrTweenInfo or TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    end
    local tween = TS:Create(instance, info, properties)
    tween:Play()
    return tween
end

local function ParseAsset(id)
    if not id or id == "" then
        return ""
    end
    local str = tostring(id):match("^%s*(.-)%s*$")
    if not str or str == "" then
        return ""
    end

    local lowerStr = str:lower()
    if lowerStr:find("://") then
        return str
    end

    if str:match("^%d+$") then
        return "rbxthumb://type=Asset&id=" .. str .. "&w=420&h=420"
    end
    
    if lowerStr:find("roblox%.com") then
        local num = str:match("%d+")
        if num then
            return "rbxthumb://type=Asset&id=" .. num .. "&w=420&h=420"
        end
    end

    return str
end

local function GetKeyName(key)
    if not key then
        return ""
    end
    local name = key.Name
    local numMap = {
        Zero="0", One="1", Two="2", Three="3", Four="4", 
        Five="5", Six="6", Seven="7", Eight="8", Nine="9",
        KeypadZero="0", KeypadOne="1", KeypadTwo="2", KeypadThree="3", KeypadFour="4",
        KeypadFive="5", KeypadSix="6", KeypadSeven="7", KeypadEight="8", KeypadNine="9"
    }
    return numMap[name] or name
end

local FontList = {"Arial", "ArialBold", "SourceSans", "SourceSansBold", "SourceSansSemibold", "SourceSansLight", "SourceSansItalic", "Bodoni", "Garamond", "Cartoon", "Code", "Highway", "SciFi", "Arcade", "Fantasy", "Antique", "Gotham", "GothamMedium", "GothamBold", "Oswald"}

local VelourUI = {
    Settings = {
        Theme = {
            Background = Color3.fromRGB(14, 14, 14),
            SidebarBg = Color3.fromRGB(14, 14, 14),
            SectionBg = Color3.fromRGB(18, 18, 18),
            Stroke = Color3.fromRGB(35, 35, 35),
            Text = Color3.fromRGB(230, 230, 230),
            TextDark = Color3.fromRGB(120, 120, 120),
            Accent = Color3.fromRGB(255, 140, 40), 
            CornerRadius = UDim.new(0, 10),        
            TitleFont = Enum.Font.GothamMedium,
            TextFont = Enum.Font.Gotham,
            BgTransparency = 0,
            SectionTransparency = 0,
            ElementsTransparency = 0,
            BackgroundImage = "",
            BgImageTransparency = 0,
            CurrentScale = 1
        }
    }
}

function VelourUI:CreateWindow(options)
    local titleText = options.Name or "Velour Ultimate"
    local topbarIcon = ParseAsset(options.Icon)
    local configFolder = options.ConfigFolder or "VelourConfigs"

    make_folder(configFolder)
    make_folder("VelourThemes")

    if options.Theme then
        for k, v in pairs(options.Theme) do
            if k == "CornerRadius" and type(v) == "number" then
                VelourUI.Settings.Theme[k] = UDim.new(0, math.clamp(v, 0, 20))
            elseif (k == "BgTransparency" or k == "SectionTransparency" or k == "ElementsTransparency" or k == "BgImageTransparency") and type(v) == "number" then
                if v > 1 then
                    VelourUI.Settings.Theme[k] = v / 100
                else
                    VelourUI.Settings.Theme[k] = v
                end
            elseif k == "BackgroundImage" then
                VelourUI.Settings.Theme[k] = ParseAsset(v)
            elseif k == "TitleFont" or k == "TextFont" then
                if typeof(v) == "EnumItem" then
                    VelourUI.Settings.Theme[k] = v
                else
                    VelourUI.Settings.Theme[k] = Enum.Font[v]
                end
            else
                VelourUI.Settings.Theme[k] = v
            end
        end
    end

    local ScreenGui = Create("ScreenGui", {
        Name = "VelourUI",
        ResetOnSpawn = false
    })
    
    local ok = pcall(function()
        ScreenGui.Parent = CG
    end)
    
    if not ok then
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end

    local NotifyContainer = Create("Frame", {
        Size = UDim2.new(0, 320, 1, -40),
        Position = UDim2.new(1, -340, 0, 20),
        BackgroundTransparency = 1,
        ZIndex = 100
    })
    NotifyContainer.Parent = ScreenGui
    
    local NotifyLayout = Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
        VerticalAlignment = Enum.VerticalAlignment.Top
    })
    NotifyLayout.Parent = NotifyContainer

    local WindowObj = {
        Tabs = {},
        ThemeInstances = {},
        ActiveToggleTracks = {},
        Connections = {},
        Flags = {},
        ThemeUpdaters = {},
        ActiveKeybinds = {}
    }

    function WindowObj:ConnectSignal(signal, callback)
        local conn = signal:Connect(callback)
        table.insert(self.Connections, conn)
        return conn
    end

    function WindowObj:Destroy()
        for _, conn in ipairs(self.Connections) do
            if conn.Connected then
                conn:Disconnect()
            end
        end
        table.clear(self.Connections)
        ScreenGui:Destroy()
    end

    local function Reg(inst, prop, tag)
        table.insert(WindowObj.ThemeInstances, {
            Instance = inst,
            Prop = prop,
            Tag = tag
        })
        inst[prop] = VelourUI.Settings.Theme[tag]
    end

    function WindowObj:UpdateTheme(tag, value, noCb)
        if tag == "BgTransparency" then
            VelourUI.Settings.Theme.BgTransparency = value
            if self.ThemeUpdaters[tag] and not noCb then
                self.ThemeUpdaters[tag](value, true)
            end
            for _, obj in pairs(self.ThemeInstances) do
                if obj.Tag == "BgTransparency" then
                    Tween(obj.Instance, {[obj.Prop] = value}, 0.2)
                end
            end
            return
        elseif tag == "SectionTransparency" then
            VelourUI.Settings.Theme.SectionTransparency = value
            if self.ThemeUpdaters[tag] and not noCb then
                self.ThemeUpdaters[tag](value, true)
            end
            for _, obj in pairs(self.ThemeInstances) do
                if obj.Tag == "SectionTransparency" then
                    Tween(obj.Instance, {[obj.Prop] = value}, 0.2)
                end
            end
            return
        elseif tag == "ElementsTransparency" then
            VelourUI.Settings.Theme.ElementsTransparency = value
            if self.ThemeUpdaters[tag] and not noCb then
                self.ThemeUpdaters[tag](value, true)
            end
            for _, obj in pairs(self.ThemeInstances) do
                if obj.Tag == "ElementsTransparency" then
                    Tween(obj.Instance, {[obj.Prop] = value}, 0.2)
                end
            end
            return
        elseif tag == "BackgroundImage" then
            value = ParseAsset(value)
            VelourUI.Settings.Theme.BackgroundImage = value
            if self.ThemeUpdaters[tag] and not noCb then
                self.ThemeUpdaters[tag](value, true)
            end
            for _, obj in pairs(self.ThemeInstances) do
                if obj.Tag == "BackgroundImage" then
                    obj.Instance.Image = value
                end
            end
            return
        elseif tag == "BgImageTransparency" then
            VelourUI.Settings.Theme.BgImageTransparency = value
            if self.ThemeUpdaters[tag] and not noCb then
                self.ThemeUpdaters[tag](value, true)
            end
            for _, obj in pairs(self.ThemeInstances) do
                if obj.Tag == "BgImageTransparency" then
                    Tween(obj.Instance, {ImageTransparency = value}, 0.2)
                end
            end
            return
        elseif tag == "CornerRadius" and type(value) == "number" then
            value = UDim.new(0, math.clamp(value, 0, 20))
        elseif tag == "TextFont" or tag == "TitleFont" then
            VelourUI.Settings.Theme[tag] = value
            if self.ThemeUpdaters[tag] and not noCb then
                self.ThemeUpdaters[tag](value, true)
            end
            for _, obj in pairs(self.ThemeInstances) do
                if obj.Tag == tag then
                    obj.Instance[obj.Prop] = value
                end
            end
            return
        elseif tag == "CurrentScale" then
            VelourUI.Settings.Theme.CurrentScale = value
            if self.ThemeUpdaters[tag] then
                self.ThemeUpdaters[tag](value, false)
            end
            return
        end

        VelourUI.Settings.Theme[tag] = value
        if self.ThemeUpdaters[tag] and not noCb then
            self.ThemeUpdaters[tag](value, true)
        end 

        for _, obj in pairs(self.ThemeInstances) do
            if obj.Tag == tag then
                Tween(obj.Instance, {[obj.Prop] = value}, 0.2)
            end
        end

        if tag == "Background" then
            VelourUI.Settings.Theme.SidebarBg = value
            for _, obj in pairs(self.ThemeInstances) do
                if obj.Tag == "SidebarBg" then
                    Tween(obj.Instance, {[obj.Prop] = value}, 0.2)
                end
            end
        end

        if tag == "Accent" then
            for _, track in pairs(self.ActiveToggleTracks) do
                Tween(track, {BackgroundColor3 = value}, 0.2)
            end
            for _, t in pairs(self.Tabs) do
                if t.Icon and t.IsActive then
                    Tween(t.Icon, {ImageColor3 = value}, 0.2)
                end
            end
        end

        if tag == "Text" or tag == "TextDark" then
            for _, t in pairs(self.Tabs) do
                if t.IsActive then
                    t.TextLabel.TextColor3 = VelourUI.Settings.Theme.Text
                else
                    t.TextLabel.TextColor3 = VelourUI.Settings.Theme.TextDark
                    if t.Icon then
                        t.Icon.ImageColor3 = VelourUI.Settings.Theme.TextDark
                    end
                end
            end
        end
    end

    local function ThemeCorner()
        local c = Create("UICorner", {
            CornerRadius = VelourUI.Settings.Theme.CornerRadius
        })
        Reg(c, "CornerRadius", "CornerRadius")
        return c
    end

    local function ThemeStroke()
        local s = Create("UIStroke", {
            Color = VelourUI.Settings.Theme.Stroke,
            Thickness = 1
        })
        Reg(s, "Color", "Stroke")
        return s
    end

    local MobileToggleBtn = Create("TextButton", {
        Size = UDim2.new(0, 45, 0, 45),
        Position = UDim2.new(0.5, -22, 0, 10),
        BackgroundColor3 = VelourUI.Settings.Theme.Background,
        BackgroundTransparency = VelourUI.Settings.Theme.ElementsTransparency,
        Text = "",
        Visible = isMobile,
        ZIndex = 100
    }, {
        ThemeCorner(),
        ThemeStroke()
    })
    
    Reg(MobileToggleBtn, "BackgroundColor3", "Background")
    Reg(MobileToggleBtn, "BackgroundTransparency", "ElementsTransparency")
    
    if topbarIcon ~= "" then
        local iconImg = Create("ImageLabel", {
            Size = UDim2.new(0, 25, 0, 25),
            Position = UDim2.new(0.5, -12.5, 0.5, -12.5),
            BackgroundTransparency = 1,
            Image = topbarIcon,
            ImageColor3 = VelourUI.Settings.Theme.Accent
        })
        Reg(iconImg, "ImageColor3", "Accent")
        iconImg.Parent = MobileToggleBtn
    end
    
    MobileToggleBtn.Parent = ScreenGui

    local mtDragging = false
    local mtInput = nil
    local mtPos = nil
    local mtFramePos = nil
    local mtDragDist = 0
    
    MobileToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            mtDragging = true
            mtPos = input.Position
            mtFramePos = MobileToggleBtn.Position
            mtDragDist = 0
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    mtDragging = false
                end
            end)
        end
    end)
    
    MobileToggleBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            mtInput = input
        end
    end)
    
    WindowObj:ConnectSignal(UIS.InputChanged, function(input)
        if input == mtInput and mtDragging then
            local delta = input.Position - mtPos
            mtDragDist = mtDragDist + delta.Magnitude
            MobileToggleBtn.Position = UDim2.new(mtFramePos.X.Scale, mtFramePos.X.Offset + delta.X, mtFramePos.Y.Scale, mtFramePos.Y.Offset + delta.Y)
        end
    end)
    
    MobileToggleBtn.MouseButton1Click:Connect(function()
        if mtDragDist < 10 then
            WindowObj:Toggle()
        end
    end)

    local KeybindsPanel = Create("Frame", {
        Size = UDim2.new(0, 220, 0, 300),
        Position = UDim2.new(1, 210, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = VelourUI.Settings.Theme.Background,
        BackgroundTransparency = VelourUI.Settings.Theme.ElementsTransparency,
        ClipsDescendants = true,
        ZIndex = 90
    }, {
        ThemeCorner(),
        ThemeStroke()
    })
    Reg(KeybindsPanel, "BackgroundColor3", "Background")
    Reg(KeybindsPanel, "BackgroundTransparency", "ElementsTransparency")
    KeybindsPanel.Parent = ScreenGui

    local kbStripVisual = Create("Frame", {
        Size = UDim2.new(0, 4, 0, 20),
        Position = UDim2.new(0, 3, 0.5, -10),
        BackgroundColor3 = VelourUI.Settings.Theme.TextDark,
        BorderSizePixel = 0,
        ZIndex = 95
    }, {
        Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    Reg(kbStripVisual, "BackgroundColor3", "TextDark")
    kbStripVisual.Parent = KeybindsPanel

    local kbPanelOpen = false
    local kbStripBtn = Create("TextButton", {
        Size = UDim2.new(0, 10, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 95
    })
    kbStripBtn.Parent = KeybindsPanel

    local kbTitle = Create("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "Keybinds",
        TextColor3 = VelourUI.Settings.Theme.Accent,
        Font = VelourUI.Settings.Theme.TitleFont,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 96
    })
    Reg(kbTitle, "TextColor3", "Accent")
    Reg(kbTitle, "Font", "TitleFont")
    kbTitle.Parent = KeybindsPanel

    local kbLine = Create("Frame", {
        Size = UDim2.new(1, -20, 0, 1),
        Position = UDim2.new(0, 10, 0, 30),
        BackgroundColor3 = VelourUI.Settings.Theme.Stroke,
        BorderSizePixel = 0,
        ZIndex = 96
    })
    Reg(kbLine, "BackgroundColor3", "Stroke")
    kbLine.Parent = KeybindsPanel

    local kbListLayout = Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    
    local kbListContainer = Create("Frame", {
        Size = UDim2.new(1, -20, 1, -35),
        Position = UDim2.new(0, 10, 0, 35),
        BackgroundTransparency = 1,
        ZIndex = 95
    }, {
        kbListLayout
    })
    kbListContainer.Parent = KeybindsPanel

    function WindowObj:UpdateKeybindsPanel()
        local count = 0
        for _, child in ipairs(kbListContainer:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end

        for name, key in pairs(self.ActiveKeybinds) do
            count = count + 1
            local kbRow = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                ZIndex = 95
            })
            
            local kbNameLbl = Create("TextLabel", {
                Size = UDim2.new(0.7, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = VelourUI.Settings.Theme.Text,
                Font = VelourUI.Settings.Theme.TextFont,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 96
            })
            Reg(kbNameLbl, "TextColor3", "Text")
            Reg(kbNameLbl, "Font", "TextFont")
            kbNameLbl.Parent = kbRow

            local kbValLbl = Create("TextLabel", {
                Size = UDim2.new(0.3, 0, 1, 0),
                Position = UDim2.new(0.7, 0, 0, 0),
                BackgroundTransparency = 1,
                Text = "[" .. GetKeyName(key) .. "]",
                TextColor3 = VelourUI.Settings.Theme.TextDark,
                Font = VelourUI.Settings.Theme.TextFont,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 96
            })
            Reg(kbValLbl, "TextColor3", "TextDark")
            Reg(kbValLbl, "Font", "TextFont")
            kbValLbl.Parent = kbRow

            kbRow.Parent = kbListContainer
        end

        local targetHeight = math.max(30, 35 + (count * 25))
        if kbPanelOpen then
            Tween(KeybindsPanel, {
                Size = UDim2.new(0, 220, 0, targetHeight)
            }, 0.3)
        else
            KeybindsPanel.Size = UDim2.new(0, 220, 0, targetHeight)
        end
    end

    kbStripBtn.MouseButton1Click:Connect(function()
        kbPanelOpen = not kbPanelOpen
        if kbPanelOpen then
            Tween(KeybindsPanel, {
                Position = UDim2.new(1, -10, 0.5, 0)
            }, 0.3)
        else
            Tween(KeybindsPanel, {
                Position = UDim2.new(1, 210, 0.5, 0)
            }, 0.3)
        end
    end)

    local WatermarkContainer = Create("Frame", {
        Size = UDim2.new(0, 0, 0, 30),
        Position = UDim2.new(0.5, 0, 0, 20),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Visible = options.WatermarkEnabled or false,
        ZIndex = 50
    })
    WatermarkContainer.Parent = ScreenGui
    WindowObj.WatermarkContainer = WatermarkContainer

    local WatermarkItems = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = 50
    })
    WatermarkItems.Parent = WatermarkContainer

    local WatermarkLayout = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    })
    WatermarkLayout.Parent = WatermarkItems

    WatermarkLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        WatermarkContainer.Size = UDim2.new(0, WatermarkLayout.AbsoluteContentSize.X, 0, 30)
    end)

    local WmDragBtn = Create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        ZIndex = 55
    })
    WmDragBtn.Parent = WatermarkContainer

    local wmDragging = false
    local wmDragInput = nil
    local wmMousePos = nil
    local wmFramePos = nil
    
    WmDragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            wmDragging = true
            wmMousePos = input.Position
            wmFramePos = WatermarkContainer.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    wmDragging = false
                end
            end)
        end
    end)
    
    WmDragBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
            wmDragInput = input 
        end
    end)
    
    WindowObj:ConnectSignal(UIS.InputChanged, function(input)
        if input == wmDragInput and wmDragging then
            local delta = input.Position - wmMousePos
            WatermarkContainer.Position = UDim2.new(wmFramePos.X.Scale, wmFramePos.X.Offset + delta.X, wmFramePos.Y.Scale, wmFramePos.Y.Offset + delta.Y)
        end
    end)

    local function CreateWatermarkPiece(textStr, order)
        local Frame = Create("Frame", {
            Size = UDim2.new(0, 100, 1, 0),
            BackgroundColor3 = VelourUI.Settings.Theme.Background,
            BackgroundTransparency = VelourUI.Settings.Theme.ElementsTransparency,
            LayoutOrder = order,
            ZIndex = 51
        }, {
            ThemeCorner(),
            ThemeStroke()
        })
        Reg(Frame, "BackgroundColor3", "Background")
        Reg(Frame, "BackgroundTransparency", "ElementsTransparency")

        local Label = Create("TextLabel", {
            Size = UDim2.new(1, -16, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            BackgroundTransparency = 1,
            Text = textStr,
            TextColor3 = VelourUI.Settings.Theme.Text,
            Font = VelourUI.Settings.Theme.TitleFont,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 52
        })
        Reg(Label, "TextColor3", "Text")
        Reg(Label, "Font", "TitleFont")
        Label.Parent = Frame

        local function UpdateSize()
            local bounds = TxS:GetTextSize(Label.Text, 13, Label.Font, Vector2.new(9999, 30))
            Frame.Size = UDim2.new(0, bounds.X + 24, 1, 0)
        end

        Label:GetPropertyChangedSignal("Text"):Connect(UpdateSize)
        Label:GetPropertyChangedSignal("Font"):Connect(UpdateSize)
        UpdateSize()

        Frame.Parent = WatermarkItems
        return Label
    end

    local localPlayer = game:GetService("Players").LocalPlayer
    local wmNameLabel = CreateWatermarkPiece(localPlayer and localPlayer.Name or "Player", 1)
    local wmPingLabel = CreateWatermarkPiece("Ping: 0ms", 2)
    local wmFpsLabel = CreateWatermarkPiece("FPS: 0", 3)

    local lastUpdate = tick()
    local frames = 0
    
    WindowObj:ConnectSignal(RS.RenderStepped, function()
        frames = frames + 1
        local now = tick()
        if now - lastUpdate >= 1 then
            wmFpsLabel.Text = "FPS: " .. frames
            frames = 0
            lastUpdate = now

            local ping = 0
            pcall(function()
                local Stats = game:GetService("Stats")
                if Stats:FindFirstChild("Network") and Stats.Network:FindFirstChild("ServerStatsItem") and Stats.Network.ServerStatsItem:FindFirstChild("Data Ping") then
                    ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
                elseif Stats:FindFirstChild("PerformanceStats") and Stats.PerformanceStats:FindFirstChild("Ping") then
                    ping = math.floor(Stats.PerformanceStats.Ping:GetValue() + 0.5)
                end
            end)
            wmPingLabel.Text = "Ping: " .. tostring(ping) .. "ms"
        end
    end)

    function WindowObj:SetWatermarkVisible(state)
        if self.WatermarkContainer then
            self.WatermarkContainer.Visible = state
        end
    end

    local MainFrame = Create("Frame", {
        Size = UDim2.new(0, 850, 0, 550),
        Position = UDim2.new(0.5, -425, 0.5, -275),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        Draggable = false,
        ClipsDescendants = false
    }, {
        ThemeCorner(),
        ThemeStroke()
    })
    MainFrame.Parent = ScreenGui

    if isMobile then
        MainFrame.Size = UDim2.new(0, 450, 0, 300)
        MainFrame.Position = UDim2.new(0, 10, 0.5, -150)
        WindowObj.CurrentScale = 0.75
        VelourUI.Settings.Theme.CurrentScale = 0.75
    else
        WindowObj.CurrentScale = 1
        VelourUI.Settings.Theme.CurrentScale = 1
    end

    local BgImage = Create("ImageLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = VelourUI.Settings.Theme.BackgroundImage,
        ImageTransparency = VelourUI.Settings.Theme.BgImageTransparency,
        ScaleType = Enum.ScaleType.Crop,
        ZIndex = -2
    }, {
        ThemeCorner()
    })
    BgImage.Parent = MainFrame
    Reg(BgImage, "Image", "BackgroundImage")
    Reg(BgImage, "ImageTransparency", "BgImageTransparency")

    local BgOverlay = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = VelourUI.Settings.Theme.Background,
        BackgroundTransparency = VelourUI.Settings.Theme.BgTransparency,
        BorderSizePixel = 0,
        ZIndex = -1,
        ClipsDescendants = true 
    }, {
        ThemeCorner()
    })
    BgOverlay.Parent = MainFrame
    Reg(BgOverlay, "BackgroundColor3", "Background")
    Reg(BgOverlay, "BackgroundTransparency", "BgTransparency")

    WindowObj.ScaleObj = Create("UIScale", {
        Scale = 0
    })
    WindowObj.ScaleObj.Parent = MainFrame
    WindowObj.IsOpen = true
    WindowObj.ToggleKey = options.ToggleKey or Enum.KeyCode.RightShift

    Tween(WindowObj.ScaleObj, {
        Scale = WindowObj.CurrentScale
    }, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out))

    function WindowObj:Toggle()
        self.IsOpen = not self.IsOpen
        if self.IsOpen then
            MainFrame.Visible = true 
            Tween(self.ScaleObj, {
                Scale = self.CurrentScale
            }, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
        else
            local t = Tween(self.ScaleObj, {
                Scale = 0
            }, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In))
            t.Completed:Connect(function()
                if not self.IsOpen then
                    MainFrame.Visible = false
                end
            end) 
        end
    end

    WindowObj:ConnectSignal(UIS.InputBegan, function(input, gp)
        if not gp and input.KeyCode == WindowObj.ToggleKey then
            WindowObj:Toggle()
        end
    end)

    local topbarElements = {
        Create("Frame", {
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = VelourUI.Settings.Theme.Stroke,
            BorderSizePixel = 0
        })
    }
    
    local titleXPos = 20
    if topbarIcon ~= "" then
        local tbIconL = Create("ImageLabel", {
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(0, 20, 0.5, -12),
            BackgroundTransparency = 1,
            Image = topbarIcon,
            ImageColor3 = VelourUI.Settings.Theme.Accent
        })
        table.insert(topbarElements, tbIconL)
        Reg(tbIconL, "ImageColor3", "Accent") 
        titleXPos = 52 
    end

    local titleLabel = Create("TextLabel", {
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(0, titleXPos, 0, 0),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = VelourUI.Settings.Theme.Text,
        Font = VelourUI.Settings.Theme.TitleFont,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd
    })
    table.insert(topbarElements, titleLabel)
    Reg(titleLabel, "Font", "TitleFont")

    local TopBar = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundTransparency = 1
    }, topbarElements)
    TopBar.Parent = BgOverlay
    Reg(TopBar:FindFirstChildOfClass("Frame"), "BackgroundColor3", "Stroke")
    Reg(titleLabel, "TextColor3", "Text")

    local CloseBtn = Create("TextButton", {
        Size = UDim2.new(0, 45, 1, 0),
        Position = UDim2.new(1, -45, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false
    })
    
    local Line1 = Create("Frame", {
        Size = UDim2.new(0, 14, 0, 2),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = VelourUI.Settings.Theme.TextDark,
        BorderSizePixel = 0,
        Rotation = 45
    }, {
        Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    
    local Line2 = Create("Frame", {
        Size = UDim2.new(0, 14, 0, 2),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = VelourUI.Settings.Theme.TextDark,
        BorderSizePixel = 0,
        Rotation = -45
    }, {
        Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    
    Line1.Parent = CloseBtn
    Line2.Parent = CloseBtn
    CloseBtn.Parent = TopBar
    Reg(Line1, "BackgroundColor3", "TextDark")
    Reg(Line2, "BackgroundColor3", "TextDark")

    CloseBtn.MouseEnter:Connect(function()
        Tween(Line1, {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}, 0.2)
        Tween(Line2, {BackgroundColor3 = Color3.fromRGB(255, 60, 60)}, 0.2)
    end)
    
    CloseBtn.MouseLeave:Connect(function()
        Tween(Line1, {BackgroundColor3 = VelourUI.Settings.Theme.TextDark}, 0.2)
        Tween(Line2, {BackgroundColor3 = VelourUI.Settings.Theme.TextDark}, 0.2)
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        WindowObj:Destroy()
    end)

    local draggingWindow = false
    local dragInput = nil
    local mousePos = nil
    local framePos = nil
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if input.Position.X >= CloseBtn.AbsolutePosition.X then
                return
            end
            draggingWindow = true
            mousePos = input.Position
            framePos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingWindow = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    WindowObj:ConnectSignal(UIS.InputChanged, function(input)
        if input == dragInput and draggingWindow then
            local delta = (input.Position - mousePos) / WindowObj.CurrentScale
            MainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

    local sidebarWidth = isMobile and 120 or 160
    local Sidebar = Create("Frame", {
        Size = UDim2.new(0, sidebarWidth, 1, -46),
        Position = UDim2.new(0, 0, 0, 46),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    Sidebar.Parent = BgOverlay

    local HighlightLayer = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    HighlightLayer.Parent = Sidebar

    local HighlightBox = Create("Frame", {
        Size = UDim2.new(1, -12, 0, 36),
        Position = UDim2.new(0, 6, 0, 10),
        BackgroundTransparency = 1,
        ZIndex = 1
    }, {
        ThemeCorner(),
        Create("UIStroke", {
            Color = VelourUI.Settings.Theme.Stroke,
            Thickness = 1
        })
    })
    HighlightBox.Parent = HighlightLayer
    Reg(HighlightBox:FindFirstChildOfClass("UIStroke"), "Color", "Stroke")

    local TabsContainer = Create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        ZIndex = 2
    }, {
        Create("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 6),
            PaddingBottom = UDim.new(0, 20)
        })
    })
    TabsContainer.Parent = Sidebar

    local TabsLayout = TabsContainer:FindFirstChildOfClass("UIListLayout")
    TabsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabsContainer.CanvasSize = UDim2.new(0, 0, 0, TabsLayout.AbsoluteContentSize.Y + 30)
    end)

    local SidebarLine = Create("Frame", {
        Size = UDim2.new(0, 1, 1, -46),
        Position = UDim2.new(0, sidebarWidth, 0, 46),
        BackgroundColor3 = VelourUI.Settings.Theme.Stroke,
        BorderSizePixel = 0
    })
    SidebarLine.Parent = BgOverlay
    Reg(SidebarLine, "BackgroundColor3", "Stroke")

    local ContentContainer = Create("Frame", {
        Size = UDim2.new(1, -(sidebarWidth + 1), 1, -66),
        Position = UDim2.new(0, sidebarWidth + 1, 0, 46),
        BackgroundTransparency = 1
    })
    ContentContainer.Parent = BgOverlay

    local BottomDivider = Create("Frame", {
        Size = UDim2.new(1, -(sidebarWidth + 1), 0, 1),
        Position = UDim2.new(0, sidebarWidth + 1, 1, -20),
        BackgroundColor3 = VelourUI.Settings.Theme.Stroke,
        BorderSizePixel = 0,
        ZIndex = 10
    })
    BottomDivider.Parent = BgOverlay
    Reg(BottomDivider, "BackgroundColor3", "Stroke")

    local ResizeHandle = Create("TextButton", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -24, 1, -24),
        BackgroundTransparency = 1,
        Text = "↘",
        TextColor3 = VelourUI.Settings.Theme.TextDark,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        AutoButtonColor = false,
        ZIndex = 10
    }, {
        ThemeCorner(),
        Create("UIStroke", {
            Color = VelourUI.Settings.Theme.Stroke,
            Thickness = 1
        })
    })
    ResizeHandle.Parent = MainFrame
    Reg(ResizeHandle, "TextColor3", "TextDark")
    Reg(ResizeHandle:FindFirstChildOfClass("UIStroke"), "Color", "Stroke")

    local resizing = false
    local firstMove = true
    local startMousePos = nil
    local startSize = nil
    local minWidth = isMobile and 300 or 500
    local minHeight = isMobile and 200 or 320 

    ResizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            firstMove = true
            startMousePos = input.Position
            startSize = MainFrame.AbsoluteSize / WindowObj.CurrentScale
            input.UserInputState = Enum.UserInputState.Cancel
        end
    end)
    
    WindowObj:ConnectSignal(UIS.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)
    
    WindowObj:ConnectSignal(UIS.InputChanged, function(input)
        if not resizing or (input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch) then
            return
        end
        if firstMove then
            firstMove = false
            return
        end
        local delta = (input.Position - startMousePos) / WindowObj.CurrentScale
        local scale = WindowObj.CurrentScale
        MainFrame.Size = UDim2.new(0, math.max(minWidth, startSize.X + delta.X), 0, math.max(minHeight, startSize.Y + delta.Y))
    end)

    function WindowObj:Notify(options)
        local title = options.Title or "Notification"
        local text = options.Text or ""
        local duration = options.Duration or 5
        local icon = ParseAsset(options.Icon)

        if icon == "" and topbarIcon ~= "" then
            icon = topbarIcon
        end
        local hasIcon = (icon ~= "")
        local textX = hasIcon and 50 or 15
        local textWidth = 320 - textX - 15
        
        local textSize = TxS:GetTextSize(text, 14, VelourUI.Settings.Theme.TextFont, Vector2.new(textWidth, 9999))
        local frameHeight = math.max(hasIcon and 50 or 40, textSize.Y + 44)

        local OuterWrapper = Create("Frame", {
            Size = UDim2.new(1, 0, 0, frameHeight),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            LayoutOrder = -math.floor(tick() * 1000)
        }, {
            ThemeCorner()
        }) 

        local NotifFrame = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(1, 400, 0, 0),
            BackgroundColor3 = VelourUI.Settings.Theme.Background,
            BackgroundTransparency = VelourUI.Settings.Theme.ElementsTransparency,
            BorderSizePixel = 0
        }, {
            ThemeCorner(),
            Create("UIStroke", {
                Color = VelourUI.Settings.Theme.Stroke,
                Thickness = 1
            })
        })
        Reg(NotifFrame, "BackgroundColor3", "Background")
        Reg(NotifFrame, "BackgroundTransparency", "ElementsTransparency")
        Reg(NotifFrame:FindFirstChildOfClass("UIStroke"), "Color", "Stroke")

        local TitleL = Create("TextLabel", {
            Size = UDim2.new(1, -textX - 15, 0, 16),
            Position = UDim2.new(0, textX, 0, 10),
            BackgroundTransparency = 1,
            Text = title,
            TextColor3 = VelourUI.Settings.Theme.Text,
            Font = VelourUI.Settings.Theme.TitleFont,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
        Reg(TitleL, "TextColor3", "Text")
        Reg(TitleL, "Font", "TitleFont")
        TitleL.Parent = NotifFrame

        local DescL = Create("TextLabel", {
            Size = UDim2.new(1, -textX - 15, 1, -30),
            Position = UDim2.new(0, textX, 0, 28),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = VelourUI.Settings.Theme.TextDark,
            Font = VelourUI.Settings.Theme.TextFont,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true
        })
        Reg(DescL, "TextColor3", "TextDark")
        Reg(DescL, "Font", "TextFont")
        DescL.Parent = NotifFrame

        if hasIcon then
            Create("ImageLabel", {
                Size = UDim2.new(0, 26, 0, 26),
                Position = UDim2.new(0, 12, 0, 12),
                BackgroundTransparency = 1,
                Image = icon
            }).Parent = NotifFrame
        end

        local TimeBarBg = Create("Frame", {
            Size = UDim2.new(1, -20, 0, 2),
            Position = UDim2.new(0, 10, 1, -8),
            BackgroundColor3 = VelourUI.Settings.Theme.Stroke,
            BorderSizePixel = 0
        })
        Reg(TimeBarBg, "BackgroundColor3", "Stroke")
        
        local TimeBar = Create("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = VelourUI.Settings.Theme.Accent,
            BorderSizePixel = 0
        })
        Reg(TimeBar, "BackgroundColor3", "Accent")
        
        TimeBar.Parent = TimeBarBg
        TimeBarBg.Parent = NotifFrame
        NotifFrame.Parent = OuterWrapper
        OuterWrapper.Parent = NotifyContainer
        
        Tween(NotifFrame, {
            Position = UDim2.new(0, 0, 0, 0)
        }, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
        
        local twn = TS:Create(TimeBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 1, 0)
        })
        twn:Play()

        task.delay(duration, function()
            local outTwn = Tween(NotifFrame, {
                Position = UDim2.new(1, 400, 0, 0)
            }, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In))
            outTwn.Completed:Connect(function()
                OuterWrapper:Destroy()
            end)
        end)
    end

    local activeTabRecord = nil
    TabsContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if activeTabRecord then
            local targetY = (activeTabRecord.Button.AbsolutePosition.Y - Sidebar.AbsolutePosition.Y) / WindowObj.CurrentScale
            HighlightBox.Position = UDim2.new(0, 6, 0, targetY)
        end
    end)

    function WindowObj:CreateTab(options)
        local tabName = type(options) == "table" and options.Name or options
        local tabIconId = type(options) == "table" and ParseAsset(options.Icon) or ""
        local hasTabIcon = (tabIconId ~= "")
        local isSettings = type(options) == "table" and options.IsSettings or false
        
        local TabObj = {}

        local TabButton = Create("TextButton", { 
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = 2,
            LayoutOrder = isSettings and 9999 or #WindowObj.Tabs 
        })
        TabButton.Parent = TabsContainer

        local textXOffset = hasTabIcon and 38 or 16 
        
        local TabText = Create("TextLabel", {
            Size = UDim2.new(1, -textXOffset, 1, 0),
            Position = UDim2.new(0, textXOffset, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = VelourUI.Settings.Theme.TextDark,
            Font = VelourUI.Settings.Theme.TextFont,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 2,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
        TabText.Parent = TabButton
        Reg(TabText, "Font", "TextFont")

        local TabIcon = nil
        if hasTabIcon then
            TabIcon = Create("ImageLabel", {
                Size = UDim2.new(0, 24, 0, 24),
                Position = UDim2.new(0, 6, 0.5, -12),
                BackgroundTransparency = 1,
                Image = tabIconId,
                ImageColor3 = VelourUI.Settings.Theme.TextDark,
                ZIndex = 2
            })
            TabIcon.Parent = TabButton
        end

        local TabGroup = Create("CanvasGroup", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            GroupTransparency = 1,
            Visible = false,
            BorderSizePixel = 0
        })
        TabGroup.Parent = ContentContainer

        local TabContent = Create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 0,
            ClipsDescendants = false
        })
        TabContent.Parent = TabGroup

        local LeftColumn = Create("Frame", {
            Size = UDim2.new(0.5, -15, 1, 0),
            Position = UDim2.new(0, 10, 0, 10),
            BackgroundTransparency = 1
        }, {
            Create("UIListLayout", {
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Create("UIPadding", {
                PaddingBottom = UDim.new(0, 25)
            })
        })
        
        local RightColumn = Create("Frame", {
            Size = UDim2.new(0.5, -15, 1, 0),
            Position = UDim2.new(0.5, 5, 0, 10),
            BackgroundTransparency = 1
        }, {
            Create("UIListLayout", {
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            Create("UIPadding", {
                PaddingBottom = UDim.new(0, 25)
            })
        })
        
        LeftColumn.Parent = TabContent
        RightColumn.Parent = TabContent

        local function UpdateScroll()
            local contentHeight = math.max(LeftColumn.UIListLayout.AbsoluteContentSize.Y, RightColumn.UIListLayout.AbsoluteContentSize.Y)
            TabContent.CanvasSize = UDim2.new(0, 0, 0, math.ceil(contentHeight / WindowObj.CurrentScale) + 30)
        end

        LeftColumn.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateScroll)
        RightColumn.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateScroll)

        local TabRecord = {
            Button = TabButton,
            TextLabel = TabText,
            Group = TabGroup,
            Content = TabContent,
            Icon = TabIcon,
            IsActive = false,
            IsSettings = isSettings
        }

        TabRecord.Select = function()
            if activeTabRecord == TabRecord then
                return
            end
            
            if TabRecord.Group.Parent then
                TabRecord.Group.Parent.ClipsDescendants = true
            end

            local swipeDir = 1
            if activeTabRecord then
                if TabButton.AbsolutePosition.Y > activeTabRecord.Button.AbsolutePosition.Y then
                    swipeDir = 1 
                else
                    swipeDir = -1 
                end
            end

            for _, t in pairs(WindowObj.Tabs) do
                t.IsActive = false
                Tween(t.TextLabel, {
                    TextColor3 = VelourUI.Settings.Theme.TextDark
                })
                if t.Icon then
                    Tween(t.Icon, {
                        ImageColor3 = VelourUI.Settings.Theme.TextDark
                    })
                end
                
                if t.Group.Visible then
                    local exitY = -1 * swipeDir
                    local tw = Tween(t.Group, {
                        GroupTransparency = 1, 
                        Position = UDim2.new(0, 0, exitY, 0)
                    }, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
                    
                    tw.Completed:Connect(function() 
                        if not t.IsActive then 
                            t.Group.Visible = false 
                        end 
                    end)
                end
            end
            
            TabRecord.IsActive = true
            
            local startY = 1 * swipeDir
            TabRecord.Group.Position = UDim2.new(0, 0, startY, 0)
            TabRecord.Group.Visible = true
            
            Tween(TabRecord.Group, {
                GroupTransparency = 0, 
                Position = UDim2.new(0, 0, 0, 0)
            }, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
            
            Tween(TabRecord.TextLabel, {
                TextColor3 = VelourUI.Settings.Theme.Text
            })
            if TabRecord.Icon then
                Tween(TabRecord.Icon, {
                    ImageColor3 = VelourUI.Settings.Theme.Accent
                })
            end
            
            activeTabRecord = TabRecord
            local targetY = (TabButton.AbsolutePosition.Y - Sidebar.AbsolutePosition.Y) / WindowObj.CurrentScale
            
            Tween(HighlightBox, {
                Position = UDim2.new(0, 6, 0, targetY)
            }, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
            UpdateScroll()
        end

        TabButton.MouseButton1Click:Connect(TabRecord.Select)

        table.insert(WindowObj.Tabs, TabRecord)

        function TabObj:CreateSection(options)
            local name = type(options) == "table" and options.Name or options
            local side = type(options) == "table" and options.Side or "Left"
            local secIcon = type(options) == "table" and ParseAsset(options.Icon) or ""
            local SectionObj = {}
            local targetColumn = side:lower() == "right" and RightColumn or LeftColumn

            local SectionFrame = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = VelourUI.Settings.Theme.SectionBg,
                BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency,
                BorderSizePixel = 0,
                ClipsDescendants = false
            }, {
                ThemeCorner(),
                ThemeStroke()
            })
            SectionFrame.Parent = targetColumn
            Reg(SectionFrame, "BackgroundColor3", "SectionBg")
            Reg(SectionFrame, "BackgroundTransparency", "SectionTransparency")

            local Header = Create("Frame", {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1
            })
            Header.Parent = SectionFrame
            
            local HeaderBtn = Create("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = 2
            })
            HeaderBtn.Parent = Header

            local titleOffset = 10
            if secIcon ~= "" then
                local sIco = Create("ImageLabel", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 10, 0.5, -8),
                    BackgroundTransparency = 1,
                    Image = secIcon,
                    ImageColor3 = VelourUI.Settings.Theme.Text
                })
                sIco.Parent = Header
                Reg(sIco, "ImageColor3", "Text")
                titleOffset = 32
            end

            local TitleLabel = Create("TextLabel", {
                Size = UDim2.new(1, -60, 1, 0),
                Position = UDim2.new(0, titleOffset, 0, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = VelourUI.Settings.Theme.Text,
                Font = VelourUI.Settings.Theme.TitleFont,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd
            })
            TitleLabel.Parent = Header
            Reg(TitleLabel, "TextColor3", "Text")
            Reg(TitleLabel, "Font", "TitleFont")

            local CollapseIcon = Create("TextLabel", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -15, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Text = "-",
                TextColor3 = VelourUI.Settings.Theme.TextDark,
                Font = VelourUI.Settings.Theme.TitleFont,
                TextSize = 16
            })
            CollapseIcon.Parent = Header
            Reg(CollapseIcon, "TextColor3", "TextDark")
            Reg(CollapseIcon, "Font", "TitleFont")

            local Line = Create("Frame", {
                Size = UDim2.new(1, -20, 0, 1),
                Position = UDim2.new(0, 10, 1, 0),
                BackgroundColor3 = VelourUI.Settings.Theme.Stroke,
                BorderSizePixel = 0
            })
            Line.Parent = Header
            Reg(Line, "BackgroundColor3", "Stroke")

            local InnerContainer = Create("Frame", {
                Size = UDim2.new(1, 0, 1, -31),
                Position = UDim2.new(0, 0, 0, 31),
                BackgroundTransparency = 1
            })
            InnerContainer.Parent = SectionFrame

            local InnerLayout = Create("UIListLayout", {
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            local InnerPadding = Create("UIPadding", {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10)
            })
            InnerLayout.Parent = InnerContainer
            InnerPadding.Parent = InnerContainer

            local sectionOpen = true
            local targetHeight = 47

            local function UpdateSectionSize()
                targetHeight = math.ceil(InnerLayout.AbsoluteContentSize.Y / WindowObj.CurrentScale) + 47
                if sectionOpen then
                    SectionFrame.Size = UDim2.new(1, 0, 0, targetHeight)
                end
            end
            InnerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)

            HeaderBtn.MouseButton1Click:Connect(function()
                sectionOpen = not sectionOpen
                if sectionOpen then
                    InnerContainer.Visible = true
                    Tween(CollapseIcon, {
                        Rotation = 0
                    }, 0.3)
                    CollapseIcon.Text = "-"
                    local tw = Tween(SectionFrame, {
                        Size = UDim2.new(1, 0, 0, targetHeight)
                    }, 0.3)
                    tw.Completed:Connect(function()
                        if sectionOpen then
                            SectionFrame.ClipsDescendants = false
                        end
                    end)
                else
                    SectionFrame.ClipsDescendants = true
                    Tween(CollapseIcon, {
                        Rotation = 180
                    }, 0.3)
                    CollapseIcon.Text = "+"
                    local tw = Tween(SectionFrame, {
                        Size = UDim2.new(1, 0, 0, 40)
                    }, 0.3)
                    tw.Completed:Connect(function()
                        if not sectionOpen then
                            InnerContainer.Visible = false
                        end
                    end)
                end
            end)

            local function RegisterFlag(flag, getFunc, setFunc)
                if flag then
                    WindowObj.Flags[flag] = {
                        Get = getFunc,
                        Set = setFunc
                    }
                end
            end

            function SectionObj:CreateLabel(options)
                local text = options.Name or "Label"
                local LabelFrame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1
                })
                LabelFrame.Parent = InnerContainer
                
                local Lbl = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = VelourUI.Settings.Theme.TextDark,
                    Font = VelourUI.Settings.Theme.TitleFont,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                Lbl.Parent = LabelFrame
                Reg(Lbl, "TextColor3", "TextDark")
                Reg(Lbl, "Font", "TitleFont")
            end

            function SectionObj:CreateToggle(options)
                local tName = options.Name or "Toggle"
                local default = options.Default or false
                local callback = options.Callback or function()
                end
                
                local state = default
                local ToggleBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1,
                    Text = tName,
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                ToggleBtn.Parent = InnerContainer
                Reg(ToggleBtn, "TextColor3", "Text")
                Reg(ToggleBtn, "Font", "TextFont")

                local CheckBox = Create("Frame", {
                    Size = UDim2.new(0, 18, 0, 18),
                    Position = UDim2.new(1, -18, 0.5, -9),
                    BackgroundColor3 = VelourUI.Settings.Theme.Background,
                    BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency
                }, {
                    ThemeCorner(),
                    ThemeStroke()
                })
                CheckBox.Parent = ToggleBtn
                Reg(CheckBox, "BackgroundColor3", "Background")
                Reg(CheckBox, "BackgroundTransparency", "SectionTransparency")

                local InnerBox = Create("Frame", {
                    Size = UDim2.new(0, state and 10 or 0, 0, state and 10 or 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = VelourUI.Settings.Theme.Accent,
                    BackgroundTransparency = state and 0 or 1
                }, {
                    ThemeCorner()
                })
                InnerBox.Parent = CheckBox
                Reg(InnerBox, "BackgroundColor3", "Accent")

                if state then
                    table.insert(WindowObj.ActiveToggleTracks, InnerBox)
                end

                local function SetState(v, noCb)
                    state = v
                    if state then
                        Tween(InnerBox, {
                            Size = UDim2.new(0, 10, 0, 10),
                            BackgroundTransparency = 0
                        }, 0.2)
                        local found = false
                        for _, t in ipairs(WindowObj.ActiveToggleTracks) do
                            if t == InnerBox then
                                found = true
                                break
                            end
                        end
                        if not found then
                            table.insert(WindowObj.ActiveToggleTracks, InnerBox)
                        end
                    else
                        Tween(InnerBox, {
                            Size = UDim2.new(0, 0, 0, 0),
                            BackgroundTransparency = 1
                        }, 0.2)
                        for i, t in ipairs(WindowObj.ActiveToggleTracks) do
                            if t == InnerBox then
                                table.remove(WindowObj.ActiveToggleTracks, i)
                                break
                            end
                        end
                    end
                    if not noCb then
                        pcall(callback, state)
                    end
                end

                ToggleBtn.MouseButton1Click:Connect(function()
                    SetState(not state)
                end)
                
                RegisterFlag(options.Flag, function()
                    return state
                end, SetState)
                
                pcall(callback, state)
                
                return {
                    Set = SetState,
                    Get = function()
                        return state
                    end
                }
            end

            function SectionObj:CreateButton(options)
                local bName = options.Name or "Button"
                local callback = options.Callback or function()
                end

                local BtnPlate = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundColor3 = VelourUI.Settings.Theme.SectionBg,
                    BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency,
                    BorderSizePixel = 0
                }, {
                    ThemeCorner(),
                    ThemeStroke()
                })
                BtnPlate.Parent = InnerContainer
                Reg(BtnPlate, "BackgroundColor3", "SectionBg")
                Reg(BtnPlate, "BackgroundTransparency", "SectionTransparency")

                local Btn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = bName,
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TitleFont,
                    TextSize = 13,
                    AutoButtonColor = false,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                Btn.Parent = BtnPlate
                Reg(Btn, "TextColor3", "Text")
                Reg(Btn, "Font", "TitleFont")

                Btn.MouseButton1Down:Connect(function()
                    local bg = VelourUI.Settings.Theme.SectionBg
                    local flashColor = Color3.fromRGB(math.clamp(bg.R*255 + 25, 0, 255), math.clamp(bg.G*255 + 25, 0, 255), math.clamp(bg.B*255 + 25, 0, 255))
                    Tween(BtnPlate, {
                        BackgroundColor3 = flashColor
                    }, 0.1)
                end)
                
                Btn.MouseButton1Up:Connect(function()
                    Tween(BtnPlate, {
                        BackgroundColor3 = VelourUI.Settings.Theme.SectionBg
                    }, 0.2)
                end)
                
                Btn.MouseLeave:Connect(function()
                    Tween(BtnPlate, {
                        BackgroundColor3 = VelourUI.Settings.Theme.SectionBg
                    }, 0.2)
                end)
                
                Btn.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
            end

            function SectionObj:CreateSlider(options)
                local sName = options.Name or "Slider"
                local min = options.Min or 0
                local max = options.Max or 100
                local default = options.Default or options.Min or 0
                local callback = options.Callback or function()
                end

                local SliderFrame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 36),
                    BackgroundTransparency = 1
                })
                SliderFrame.Parent = InnerContainer

                local Title = Create("TextLabel", {
                    Size = UDim2.new(1, -50, 0, 16),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = sName,
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                Title.Parent = SliderFrame
                Reg(Title, "TextColor3", "Text")
                Reg(Title, "Font", "TextFont")

                local ValueText = Create("TextLabel", {
                    Size = UDim2.new(0, 50, 0, 16),
                    Position = UDim2.new(1, -50, 0, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(default),
                    TextColor3 = VelourUI.Settings.Theme.TextDark,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right
                })
                ValueText.Parent = SliderFrame
                Reg(ValueText, "TextColor3", "TextDark")
                Reg(ValueText, "Font", "TextFont")

                local TrackBg = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 8),
                    Position = UDim2.new(0, 0, 0, 22),
                    BackgroundColor3 = VelourUI.Settings.Theme.Background,
                    BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency,
                    BorderSizePixel = 0
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    }),
                    ThemeStroke()
                })
                TrackBg.Parent = SliderFrame
                Reg(TrackBg, "BackgroundColor3", "Background")
                Reg(TrackBg, "BackgroundTransparency", "SectionTransparency")

                local Fill = Create("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = VelourUI.Settings.Theme.Accent,
                    BorderSizePixel = 0
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                Fill.Parent = TrackBg
                Reg(Fill, "BackgroundColor3", "Accent")

                local TouchZone = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 10),
                    Position = UDim2.new(0, 0, 0, -5),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 3
                })
                TouchZone.Parent = TrackBg

                local dragging = false
                local startX = 0
                local startRel = (default - min) / (max - min)
                local currentRel = startRel
                local startTrackWidth = 0

                local function setSlider(rel, noCb)
                    rel = math.clamp(rel, 0, 1)
                    currentRel = rel
                    local val = math.floor(min + (max - min) * rel)
                    ValueText.Text = tostring(val)
                    Tween(Fill, {
                        Size = UDim2.new(rel, 0, 1, 0)
                    }, 0.05)
                    if not noCb then
                        pcall(callback, val)
                    end
                end

                TouchZone.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        startX = input.Position.X
                        currentRel = (input.Position.X - TrackBg.AbsolutePosition.X) / TrackBg.AbsoluteSize.X
                        startRel = currentRel
                        startTrackWidth = TrackBg.AbsoluteSize.X
                        setSlider(currentRel)
                    end
                end)

                WindowObj:ConnectSignal(UIS.InputEnded, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                WindowObj:ConnectSignal(UIS.InputChanged, function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        setSlider(startRel + ((input.Position.X - startX) / startTrackWidth))
                    end
                end)

                RegisterFlag(options.Flag, function()
                    return math.floor(min + (max - min) * currentRel)
                end, function(v, noCb)
                    setSlider((v - min) / (max - min), noCb)
                end)
                
                pcall(callback, default)
                
                return {
                    Set = function(v, noCb)
                        setSlider((v - min) / (max - min), noCb)
                    end,
                    Get = function()
                        return math.floor(min + (max - min) * currentRel)
                    end
                }
            end

            function SectionObj:CreateKeybind(options)
                local kName = options.Name or "Keybind"
                local defaultKey = options.Default or Enum.KeyCode.E
                local callback = options.Callback or function()
                end

                local key = defaultKey
                local binding = false
                local BindFrame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1
                })
                BindFrame.Parent = InnerContainer

                local kbCheckbox = Create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 0, 0.5, -8),
                    BackgroundColor3 = VelourUI.Settings.Theme.Background,
                    BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency,
                    Visible = isMobile
                }, {
                    ThemeCorner(),
                    ThemeStroke()
                })
                Reg(kbCheckbox, "BackgroundColor3", "Background")
                Reg(kbCheckbox, "BackgroundTransparency", "SectionTransparency")
                kbCheckbox.Parent = BindFrame

                local kbCheckInner = Create("Frame", {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = VelourUI.Settings.Theme.Accent,
                    BackgroundTransparency = 1
                }, {
                    ThemeCorner()
                })
                Reg(kbCheckInner, "BackgroundColor3", "Accent")
                kbCheckInner.Parent = kbCheckbox

                local kbCheckBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    Visible = isMobile
                })
                kbCheckBtn.Parent = kbCheckbox

                local labelSize
                if isMobile then
                    labelSize = UDim2.new(0.45, -20, 1, 0)
                else
                    labelSize = UDim2.new(0.45, 0, 1, 0)
                end
                
                local labelPos
                if isMobile then
                    labelPos = UDim2.new(0, 22, 0, 0)
                else
                    labelPos = UDim2.new(0, 0, 0, 0)
                end

                local Label = Create("TextLabel", {
                    Size = labelSize,
                    Position = labelPos,
                    BackgroundTransparency = 1,
                    Text = kName,
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                Label.Parent = BindFrame
                Reg(Label, "TextColor3", "Text")
                Reg(Label, "Font", "TextFont")

                local BindPlate = Create("Frame", {
                    Size = UDim2.new(0.55, 0, 0, 26),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = VelourUI.Settings.Theme.SectionBg,
                    BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency,
                    BorderSizePixel = 0
                }, {
                    ThemeCorner(),
                    ThemeStroke()
                })
                BindPlate.Parent = BindFrame
                Reg(BindPlate, "BackgroundColor3", "SectionBg")
                Reg(BindPlate, "BackgroundTransparency", "SectionTransparency")

                local BindBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = GetKeyName(key),
                    TextColor3 = VelourUI.Settings.Theme.Accent,
                    Font = VelourUI.Settings.Theme.TitleFont,
                    TextSize = 12,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                BindBtn.Parent = BindPlate
                Reg(BindBtn, "TextColor3", "Accent")
                Reg(BindBtn, "Font", "TitleFont")

                local onScreenBtn = nil
                local isKbChecked = false

                local function ToggleOnScreenBtn()
                    isKbChecked = not isKbChecked
                    if isKbChecked then
                        Tween(kbCheckInner, {
                            Size = UDim2.new(0, 8, 0, 8),
                            BackgroundTransparency = 0
                        }, 0.2)
                        
                        if not onScreenBtn then
                            onScreenBtn = Create("TextButton", {
                                Size = UDim2.new(0, 45, 0, 45),
                                Position = UDim2.new(0.8, 0, 0.8, 0),
                                BackgroundColor3 = VelourUI.Settings.Theme.Background,
                                BackgroundTransparency = VelourUI.Settings.Theme.ElementsTransparency,
                                Text = GetKeyName(key),
                                TextColor3 = VelourUI.Settings.Theme.Text,
                                Font = VelourUI.Settings.Theme.TitleFont,
                                TextSize = 18,
                                ZIndex = 100
                            }, {
                                ThemeCorner(),
                                ThemeStroke()
                            })
                            Reg(onScreenBtn, "BackgroundColor3", "Background")
                            Reg(onScreenBtn, "BackgroundTransparency", "ElementsTransparency")
                            Reg(onScreenBtn, "TextColor3", "Text")
                            Reg(onScreenBtn, "Font", "TitleFont")
                            onScreenBtn.Parent = ScreenGui

                            local osDragging = false
                            local osInput = nil
                            local osPos = nil
                            local osFramePos = nil
                            local dragDist = 0
                            
                            onScreenBtn.InputBegan:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                    osDragging = true
                                    osPos = input.Position
                                    osFramePos = onScreenBtn.Position
                                    dragDist = 0
                                    input.Changed:Connect(function()
                                        if input.UserInputState == Enum.UserInputState.End then
                                            osDragging = false
                                        end
                                    end)
                                end
                            end)
                            
                            onScreenBtn.InputChanged:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                                    osInput = input
                                end
                            end)
                            
                            WindowObj:ConnectSignal(UIS.InputChanged, function(input)
                                if input == osInput and osDragging then
                                    local delta = input.Position - osPos
                                    dragDist = dragDist + delta.Magnitude
                                    onScreenBtn.Position = UDim2.new(osFramePos.X.Scale, osFramePos.X.Offset + delta.X, osFramePos.Y.Scale, osFramePos.Y.Offset + delta.Y)
                                end
                            end)
                            
                            onScreenBtn.MouseButton1Click:Connect(function()
                                if dragDist < 10 then
                                    pcall(callback, key, false)
                                end
                            end)
                        end
                        onScreenBtn.Visible = true
                    else
                        Tween(kbCheckInner, {
                            Size = UDim2.new(0, 0, 0, 0),
                            BackgroundTransparency = 1
                        }, 0.2)
                        
                        if onScreenBtn then
                            onScreenBtn.Visible = false
                        end
                    end
                end

                kbCheckBtn.MouseButton1Click:Connect(ToggleOnScreenBtn)

                local function SetKey(v, noCb)
                    key = v
                    BindBtn.Text = GetKeyName(key)
                    if onScreenBtn then
                        onScreenBtn.Text = GetKeyName(key)
                    end
                    WindowObj.ActiveKeybinds[kName] = key
                    WindowObj:UpdateKeybindsPanel()
                    if not noCb then
                        pcall(callback, key, true)
                    end
                end

                BindBtn.MouseButton1Click:Connect(function()
                    binding = true
                    BindBtn.Text = "..."
                end)
                
                WindowObj:ConnectSignal(UIS.InputBegan, function(input, gp)
                    if binding and input.UserInputType == Enum.UserInputType.Keyboard then
                        SetKey(input.KeyCode)
                        binding = false
                        pcall(callback, key, true)
                    elseif input.KeyCode == key and not binding and not gp then
                        pcall(callback, key, false)
                    end
                end)

                WindowObj.ActiveKeybinds[kName] = key
                WindowObj:UpdateKeybindsPanel()

                RegisterFlag(options.Flag, function()
                    return key.Name
                end, function(v, noCb)
                    local k = Enum.KeyCode[v]
                    if k then
                        SetKey(k, noCb)
                    end
                end)
                
                return {
                    Set = function(v, noCb)
                        local k = Enum.KeyCode[v]
                        if k then
                            SetKey(k, noCb)
                        end
                    end,
                    Get = function()
                        return key
                    end
                }
            end

            function SectionObj:CreateInput(options)
                local iName = options.Name or "Input"
                local placeholder = options.Placeholder or ""
                local callback = options.Callback or function()
                end

                local InputFrame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1
                })
                InputFrame.Parent = InnerContainer

                local Label = Create("TextLabel", {
                    Size = UDim2.new(0.45, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = iName,
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                Label.Parent = InputFrame
                Reg(Label, "TextColor3", "Text")
                Reg(Label, "Font", "TextFont")

                local InputPlate = Create("Frame", {
                    Size = UDim2.new(0.55, 0, 0, 26),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundColor3 = VelourUI.Settings.Theme.SectionBg,
                    BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency, 
                    BorderSizePixel = 0,
                    ClipsDescendants = true 
                }, {
                    ThemeCorner(),
                    ThemeStroke()
                })
                InputPlate.Parent = InputFrame
                Reg(InputPlate, "BackgroundColor3", "SectionBg")
                Reg(InputPlate, "BackgroundTransparency", "SectionTransparency")

                local TextBox = Create("TextBox", {
                    Size = UDim2.new(1, -12, 1, 0),
                    Position = UDim2.new(0, 6, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    PlaceholderText = placeholder or "",
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    PlaceholderColor3 = VelourUI.Settings.Theme.TextDark,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 13,
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                TextBox.Parent = InputPlate
                Reg(TextBox, "TextColor3", "Text")
                Reg(TextBox, "Font", "TextFont")

                local textTween = nil
                
                local function UpdateTextScroll()
                    if textTween then
                        textTween:Cancel()
                        textTween = nil
                    end
                    local maxW = InputPlate.AbsoluteSize.X - 12
                    local textSize = TxS:GetTextSize(TextBox.Text, 13, VelourUI.Settings.Theme.TextFont, Vector2.new(9999, 26))
                    
                    if textSize.X > maxW then
                        TextBox.Size = UDim2.new(0, textSize.X + 6, 1, 0)
                    else
                        TextBox.Size = UDim2.new(1, -12, 1, 0)
                    end
                    
                    TextBox.Position = UDim2.new(0, 6, 0, 0)
                    
                    if textSize.X > maxW and not TextBox:IsFocused() then
                        local overflow = textSize.X - maxW
                        textTween = TS:Create(TextBox, TweenInfo.new(overflow / 30, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                            Position = UDim2.new(0, 6 - overflow, 0, 0)
                        })
                        textTween:Play()
                    end
                end

                TextBox.Focused:Connect(function()
                    if textTween then
                        textTween:Cancel()
                        textTween = nil
                    end
                    TextBox.Position = UDim2.new(0, 6, 0, 0)
                end)

                TextBox.FocusLost:Connect(function()
                    UpdateTextScroll()
                    pcall(callback, TextBox.Text)
                end)
                
                local function SetVal(v, noCb)
                    TextBox.Text = tostring(v)
                    UpdateTextScroll()
                    if not noCb then
                        pcall(callback, TextBox.Text)
                    end
                end

                RegisterFlag(options.Flag, function()
                    return TextBox.Text
                end, function(v, noCb)
                    SetVal(v, noCb)
                end)
                
                pcall(callback, TextBox.Text)
                
                return {
                    Set = SetVal,
                    Get = function()
                        return TextBox.Text
                    end
                }
            end

            function SectionObj:CreateDropdown(options)
                local dName = options.Name or "Dropdown"
                local list = options.Options or {}
                local default = options.Default
                local callback = options.Callback or function()
                end

                local dropped = false
                local selected = default or (list[1] or "")

                local DropWrapper = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1,
                    ClipsDescendants = false
                })
                DropWrapper.Parent = InnerContainer

                local Label = Create("TextLabel", {
                    Size = UDim2.new(0.45, 0, 0, 26),
                    BackgroundTransparency = 1,
                    Text = dName,
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                Label.Parent = DropWrapper
                Reg(Label, "TextColor3", "Text")
                Reg(Label, "Font", "TextFont")

                local DropPlate = Create("Frame", {
                    Size = UDim2.new(0.55, 0, 0, 26),
                    Position = UDim2.new(1, 0, 0, 0),
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundColor3 = VelourUI.Settings.Theme.SectionBg,
                    BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency, 
                    ClipsDescendants = true,
                    ZIndex = 10
                }, {
                    ThemeCorner(),
                    ThemeStroke()
                })
                DropPlate.Parent = DropWrapper
                Reg(DropPlate, "BackgroundColor3", "SectionBg")
                Reg(DropPlate, "BackgroundTransparency", "SectionTransparency")

                local DropBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1,
                    Text = "  " .. tostring(selected),
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 11,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                DropBtn.Parent = DropPlate
                Reg(DropBtn, "TextColor3", "Text")
                Reg(DropBtn, "Font", "TextFont")

                local Arrow = Create("TextLabel", {
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(1, -15, 0, 3),
                    AnchorPoint = Vector2.new(0.5, 0),
                    BackgroundTransparency = 1,
                    Text = "+",
                    TextColor3 = VelourUI.Settings.Theme.TextDark,
                    Font = VelourUI.Settings.Theme.TitleFont,
                    TextSize = 14,
                    ZIndex = 12
                })
                Arrow.Parent = DropPlate
                Reg(Arrow, "TextColor3", "TextDark")
                Reg(Arrow, "Font", "TitleFont")

                local Divider = Create("Frame", {
                    Size = UDim2.new(1, -12, 0, 1),
                    Position = UDim2.new(0, 6, 0, 25),
                    BackgroundColor3 = VelourUI.Settings.Theme.Stroke,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    ZIndex = 12
                })
                Divider.Parent = DropPlate
                Reg(Divider, "BackgroundColor3", "Stroke")

                local ListContainer = Create("ScrollingFrame", {
                    Size = UDim2.new(1, 0, 1, -26),
                    Position = UDim2.new(0, 0, 0, 26),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ScrollBarThickness = 0,
                    CanvasSize = UDim2.new(0,0,0,0),
                    ZIndex = 11
                }, {
                    Create("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    Create("UIPadding", {
                        PaddingBottom = UDim.new(0, 4)
                    })
                })
                ListContainer.Parent = DropPlate

                local function SetValue(v, noCb)
                    selected = v
                    DropBtn.Text = "  " .. tostring(v)
                    if not noCb then
                        pcall(callback, v)
                    end
                end

                local function RefreshList(newList, keepSelected)
                    list = newList
                    for _, child in ipairs(ListContainer:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    local found = false
                    for _, i in ipairs(list) do
                        if i == selected then
                            found = true
                            break
                        end
                    end
                    
                    if not found and not keepSelected then
                        SetValue(list[1] or "", true)
                    end

                    local h = 0
                    for _, item in ipairs(list) do
                        local btn = Create("TextButton", {
                            Size = UDim2.new(1, -6, 0, 22),
                            BackgroundTransparency = 1,
                            Text = "  "..tostring(item),
                            TextColor3 = VelourUI.Settings.Theme.Text,
                            Font = VelourUI.Settings.Theme.TextFont,
                            TextSize = 12,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 11,
                            TextTruncate = Enum.TextTruncate.AtEnd
                        })
                        Reg(btn, "TextColor3", "Text")
                        Reg(btn, "Font", "TextFont")
                        btn.Parent = ListContainer
                        
                        btn.MouseButton1Click:Connect(function()
                            SetValue(item)
                            dropped = false
                            Tween(DropPlate, {
                                Size = UDim2.new(0.55, 0, 0, 26)
                            }, 0.3)
                            Tween(DropWrapper, {
                                Size = UDim2.new(1, 0, 0, 26)
                            }, 0.3)
                            Tween(Arrow, {
                                Rotation = 0
                            }, 0.3)
                            Arrow.Text = "+"
                            Tween(Divider, {
                                BackgroundTransparency = 1
                            }, 0.1)
                        end)
                        h = h + 22
                    end
                    ListContainer.CanvasSize = UDim2.new(0, 0, 0, h + 4)
                    
                    if dropped then
                        local newH = math.clamp(h, 0, 110)
                        Tween(DropPlate, {
                            Size = UDim2.new(0.55, 0, 0, 26 + newH + 6)
                        }, 0.3)
                        Tween(DropWrapper, {
                            Size = UDim2.new(1, 0, 0, 26 + newH + 6)
                        }, 0.3)
                    end
                end
                RefreshList(list)

                DropBtn.MouseButton1Click:Connect(function()
                    dropped = not dropped
                    local h = math.clamp(#list * 22, 0, 110)
                    local targetHeight
                    if dropped then
                        targetHeight = 26 + h + 6
                    else
                        targetHeight = 26
                    end
                    
                    Tween(DropPlate, {
                        Size = UDim2.new(0.55, 0, 0, targetHeight)
                    }, 0.3)
                    Tween(DropWrapper, {
                        Size = UDim2.new(1, 0, 0, targetHeight)
                    }, 0.3)
                    
                    if dropped then
                        Tween(Arrow, {Rotation = 180}, 0.3)
                        Arrow.Text = "-"
                        Tween(Divider, {BackgroundTransparency = 0}, 0.1)
                    else
                        Tween(Arrow, {Rotation = 0}, 0.3)
                        Arrow.Text = "+"
                        Tween(Divider, {BackgroundTransparency = 1}, 0.1)
                    end
                end)

                RegisterFlag(options.Flag, function()
                    return selected
                end, function(v, noCb)
                    SetValue(v, noCb)
                end)
                
                pcall(callback, selected)
                
                return {
                    Refresh = RefreshList,
                    Set = SetValue,
                    Get = function()
                        return selected
                    end,
                    GetOptions = function()
                        return list
                    end
                }
            end

            function SectionObj:CreateColorPicker(options)
                local cName = options.Name or "Color Picker"
                local default = options.Default or Color3.fromRGB(255, 255, 255)
                local callback = options.Callback or function()
                end

                local h, s, v = default:ToHSV()
                local dropped = false

                local CPFrame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true
                })
                CPFrame.Parent = InnerContainer

                local CPBtn = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 24),
                    BackgroundTransparency = 1,
                    Text = cName,
                    TextColor3 = VelourUI.Settings.Theme.Text,
                    Font = VelourUI.Settings.Theme.TextFont,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
                CPBtn.Parent = CPFrame
                Reg(CPBtn, "TextColor3", "Text")
                Reg(CPBtn, "Font", "TextFont")

                local ColorIndicator = Create("Frame", {
                    Size = UDim2.new(0, 28, 0, 14),
                    Position = UDim2.new(1, -30, 0.5, -7),
                    BackgroundColor3 = default
                }, {
                    ThemeCorner(),
                    ThemeStroke()
                })
                ColorIndicator.Parent = CPBtn

                local PaletteMap = Create("ImageButton", {
                    Size = UDim2.new(1, 0, 0, 100),
                    Position = UDim2.new(0, 0, 0, 30),
                    Image = "rbxassetid://4155801252",
                    BackgroundColor3 = Color3.fromHSV(h, 1, 1),
                    AutoButtonColor = false
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(0, 4)
                    })
                })
                PaletteMap.Parent = CPFrame

                local PickerCircle = Create("Frame", {
                    Size = UDim2.new(0, 8, 0, 8),
                    Position = UDim2.new(s, 0, 1 - v, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0)
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                PickerCircle.Parent = PaletteMap

                local HueSlider = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 10),
                    Position = UDim2.new(0, 0, 0, 136),
                    Text = "",
                    AutoButtonColor = false
                }, {
                    Create("UICorner", {
                        CornerRadius = UDim.new(0, 4)
                    }),
                    Create("UIGradient", {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                            ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 255, 0)),
                            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
                            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                        })
                    })
                })
                HueSlider.Parent = CPFrame

                local HueMarker = Create("Frame", {
                    Size = UDim2.new(0, 2, 1, 4),
                    Position = UDim2.new(h, -1, 0, -2),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                HueMarker.Parent = HueSlider

                local RGBContainer = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 22),
                    Position = UDim2.new(0, 0, 0, 154),
                    BackgroundTransparency = 1
                })
                RGBContainer.Parent = CPFrame

                local function CreateColorInput(textLabel, posX, defVal)
                    local cFrame = Create("Frame", {
                        Size = UDim2.new(0.31, 0, 1, 0),
                        Position = posX,
                        BackgroundColor3 = VelourUI.Settings.Theme.Background,
                        BackgroundTransparency = VelourUI.Settings.Theme.SectionTransparency,
                        BorderSizePixel = 0
                    }, {
                        ThemeCorner(),
                        ThemeStroke()
                    })
                    Reg(cFrame, "BackgroundColor3", "Background")
                    Reg(cFrame, "BackgroundTransparency", "SectionTransparency")
                    
                    local cLabel = Create("TextLabel", {
                        Size = UDim2.new(0, 16, 1, 0),
                        Position = UDim2.new(0, 4, 0, 0),
                        BackgroundTransparency = 1,
                        Text = textLabel,
                        TextColor3 = VelourUI.Settings.Theme.TextDark,
                        Font = VelourUI.Settings.Theme.TextFont,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                    cLabel.Parent = cFrame
                    Reg(cLabel, "TextColor3", "TextDark")
                    Reg(cLabel, "Font", "TextFont")
                    
                    local cBox = Create("TextBox", {
                        Size = UDim2.new(1, -18, 1, 0),
                        Position = UDim2.new(0, 16, 0, 0),
                        BackgroundTransparency = 1,
                        Text = tostring(math.floor(defVal * 255)),
                        TextColor3 = VelourUI.Settings.Theme.Text,
                        Font = VelourUI.Settings.Theme.TextFont,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        ClearTextOnFocus = false
                    })
                    cBox.Parent = cFrame
                    Reg(cBox, "TextColor3", "Text")
                    Reg(cBox, "Font", "TextFont")
                    
                    cFrame.Parent = RGBContainer
                    return cBox
                end

                local rBox = CreateColorInput("R:", UDim2.new(0.02, 0, 0, 0), default.R)
                local gBox = CreateColorInput("G:", UDim2.new(0.345, 0, 0, 0), default.G)
                local bBox = CreateColorInput("B:", UDim2.new(0.67, 0, 0, 0), default.B)

                CPBtn.MouseButton1Click:Connect(function()
                    dropped = not dropped
                    local currentSize
                    if dropped then
                        currentSize = 182
                    else
                        currentSize = 24
                    end
                    Tween(CPFrame, {
                        Size = UDim2.new(1, 0, 0, currentSize)
                    })
                end)

                local function UpdateColor()
                    local finalColor = Color3.fromHSV(h, s, v)
                    ColorIndicator.BackgroundColor3 = finalColor
                    PaletteMap.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    rBox.Text = tostring(math.floor(finalColor.R * 255))
                    gBox.Text = tostring(math.floor(finalColor.G * 255))
                    bBox.Text = tostring(math.floor(finalColor.B * 255))
                    pcall(callback, finalColor)
                end

                local function UpdateFromRGB()
                    local r = math.clamp(tonumber(rBox.Text) or 0, 0, 255) / 255
                    local g = math.clamp(tonumber(gBox.Text) or 0, 0, 255) / 255
                    local b = math.clamp(tonumber(bBox.Text) or 0, 0, 255) / 255
                    local c = Color3.new(r, g, b)
                    local nH, nS, nV = c:ToHSV()
                    if nV > 0.001 then
                        s = nS
                    end
                    if nS > 0.001 and nV > 0.001 then
                        h = nH
                    end
                    v = nV
                    PickerCircle.Position = UDim2.new(math.clamp(s, 0.04, 0.96), 0, math.clamp(1 - v, 0.04, 0.96), 0)
                    HueMarker.Position = UDim2.new(h, -1, 0, -2)
                    UpdateColor()
                end

                local function SetColor(val, noCallback)
                    if type(val) == "table" and #val == 3 then
                        local c = Color3.new(val[1], val[2], val[3])
                        local nH, nS, nV = c:ToHSV()
                        if nV > 0.001 then
                            s = nS
                        end
                        if nS > 0.001 and nV > 0.001 then
                            h = nH
                        end
                        v = nV
                    elseif typeof(val) == "Color3" then
                        local nH, nS, nV = val:ToHSV()
                        if nV > 0.001 then
                            s = nS
                        end
                        if nS > 0.001 and nV > 0.001 then
                            h = nH
                        end
                        v = nV
                    end
                    PickerCircle.Position = UDim2.new(math.clamp(s, 0.04, 0.96), 0, math.clamp(1 - v, 0.04, 0.96), 0)
                    HueMarker.Position = UDim2.new(h, -1, 0, -2)
                    
                    local finalColor = Color3.fromHSV(h, s, v)
                    ColorIndicator.BackgroundColor3 = finalColor
                    PaletteMap.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    rBox.Text = tostring(math.floor(finalColor.R * 255))
                    gBox.Text = tostring(math.floor(finalColor.G * 255))
                    bBox.Text = tostring(math.floor(finalColor.B * 255))
                    if not noCallback then
                        pcall(callback, finalColor)
                    end
                end

                rBox.FocusLost:Connect(UpdateFromRGB)
                gBox.FocusLost:Connect(UpdateFromRGB)
                bBox.FocusLost:Connect(UpdateFromRGB)

                local dragSV = false
                local dragHue = false
                
                PaletteMap.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragSV = true
                    end
                end)
                
                HueSlider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragHue = true
                    end
                end)
                
                WindowObj:ConnectSignal(UIS.InputEnded, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragSV = false
                        dragHue = false
                    end
                end)
                
                WindowObj:ConnectSignal(UIS.InputChanged, function(input)
                    if dragSV and input.UserInputType == Enum.UserInputType.MouseMovement then
                        s = math.clamp((input.Position.X - PaletteMap.AbsolutePosition.X) / PaletteMap.AbsoluteSize.X, 0, 1)
                        v = 1 - math.clamp((input.Position.Y - PaletteMap.AbsolutePosition.Y) / PaletteMap.AbsoluteSize.Y, 0, 1)
                        PickerCircle.Position = UDim2.new(math.clamp(s, 0.04, 0.96), 0, math.clamp(1 - v, 0.04, 0.96), 0)
                        UpdateColor()
                    elseif dragHue and input.UserInputType == Enum.UserInputType.MouseMovement then
                        h = math.clamp((input.Position.X - HueSlider.AbsolutePosition.X) / HueSlider.AbsoluteSize.X, 0, 1)
                        HueMarker.Position = UDim2.new(h, -1, 0, -2)
                        UpdateColor()
                    end
                end)

                RegisterFlag(options.Flag, function()
                    return {Color3.fromHSV(h, s, v).R, Color3.fromHSV(h, s, v).G, Color3.fromHSV(h, s, v).B}
                end, SetColor)
                
                pcall(callback, default)
                
                return {
                    Set = SetColor
                }
            end

            return SectionObj
        end
        return TabObj
    end

    local SettingsTab = WindowObj:CreateTab({
        Name = "UI Settings",
        Icon = "7059346373",
        IsSettings = true
    })
    
    local ThemeSec = SettingsTab:CreateSection({
        Name = "Colors",
        Side = "Left"
    })
    
    local MiscSec = SettingsTab:CreateSection({
        Name = "Customization",
        Side = "Right"
    })

    local pickerAccent = ThemeSec:CreateColorPicker({
        Name = "Accent Color",
        Default = VelourUI.Settings.Theme.Accent,
        Callback = function(c)
            WindowObj:UpdateTheme("Accent", c)
        end
    })
    
    local pickerBg = ThemeSec:CreateColorPicker({
        Name = "Background Color",
        Default = VelourUI.Settings.Theme.Background,
        Callback = function(c)
            WindowObj:UpdateTheme("Background", c)
        end
    })
    
    local pickerSecBg = ThemeSec:CreateColorPicker({
        Name = "Section Overlay",
        Default = VelourUI.Settings.Theme.SectionBg,
        Callback = function(c)
            WindowObj:UpdateTheme("SectionBg", c)
        end
    })
    
    local pickerStroke = ThemeSec:CreateColorPicker({
        Name = "Stroke (Outlines)",
        Default = VelourUI.Settings.Theme.Stroke,
        Callback = function(c)
            WindowObj:UpdateTheme("Stroke", c)
        end
    })
    
    local pickerText = ThemeSec:CreateColorPicker({
        Name = "Text Color",
        Default = VelourUI.Settings.Theme.Text,
        Callback = function(c)
            WindowObj:UpdateTheme("Text", c)
        end
    })
    
    local pickerTextDark = ThemeSec:CreateColorPicker({
        Name = "Subtext Color",
        Default = VelourUI.Settings.Theme.TextDark,
        Callback = function(c)
            WindowObj:UpdateTheme("TextDark", c)
        end
    })

    WindowObj.ThemeUpdaters["Accent"] = pickerAccent.Set
    WindowObj.ThemeUpdaters["Background"] = pickerBg.Set
    WindowObj.ThemeUpdaters["SectionBg"] = pickerSecBg.Set
    WindowObj.ThemeUpdaters["Stroke"] = pickerStroke.Set
    WindowObj.ThemeUpdaters["Text"] = pickerText.Set
    WindowObj.ThemeUpdaters["TextDark"] = pickerTextDark.Set

    local scaleSlider = MiscSec:CreateSlider({
        Name = "UI Scale",
        Min = 70,
        Max = 120,
        Default = VelourUI.Settings.Theme.CurrentScale and VelourUI.Settings.Theme.CurrentScale * 100 or 100,
        Callback = function(val)
            VelourUI.Settings.Theme.CurrentScale = val / 100
            WindowObj.CurrentScale = val / 100
            if WindowObj.IsOpen then
                WindowObj.ScaleObj.Scale = WindowObj.CurrentScale
            end
            for _, tab in ipairs(WindowObj.Tabs) do
                if tab.Content.Visible then
                    local lc = tab.Content:FindFirstChild("LeftColumn")
                    local rc = tab.Content:FindFirstChild("RightColumn")
                    if lc and rc then
                        local contentHeight = math.max(lc.UIListLayout.AbsoluteContentSize.Y, rc.UIListLayout.AbsoluteContentSize.Y)
                        tab.Content.CanvasSize = UDim2.new(0, 0, 0, math.ceil(contentHeight / WindowObj.CurrentScale) + 30)
                    end
                end
            end
            
            task.defer(function()
                if activeTabRecord then
                    local targetY = (activeTabRecord.Button.AbsolutePosition.Y - Sidebar.AbsolutePosition.Y) / WindowObj.CurrentScale
                    HighlightBox.Position = UDim2.new(0, 6, 0, targetY)
                end
            end)
        end
    })
    
    local radSlider = MiscSec:CreateSlider({
        Name = "Global Corner Radius",
        Min = 0,
        Max = 20,
        Default = VelourUI.Settings.Theme.CornerRadius.Offset,
        Callback = function(val)
            WindowObj:UpdateTheme("CornerRadius", val)
        end
    })
    
    local bgTrSlider = MiscSec:CreateSlider({
        Name = "Background Transparency",
        Min = 0,
        Max = 100,
        Default = VelourUI.Settings.Theme.BgTransparency * 100,
        Callback = function(val)
            WindowObj:UpdateTheme("BgTransparency", val / 100)
        end
    })
    
    local secTrSlider = MiscSec:CreateSlider({
        Name = "Section Transparency",
        Min = 0,
        Max = 100,
        Default = VelourUI.Settings.Theme.SectionTransparency * 100,
        Callback = function(val)
            WindowObj:UpdateTheme("SectionTransparency", val / 100)
        end
    })
    
    local elemTrSlider = MiscSec:CreateSlider({
        Name = "Elements Transparency",
        Min = 0,
        Max = 100,
        Default = VelourUI.Settings.Theme.ElementsTransparency * 100,
        Callback = function(val)
            WindowObj:UpdateTheme("ElementsTransparency", val / 100)
        end
    })
    
    MiscSec:CreateLabel({
        Name = "-- Fonts & Images --"
    })
    
    local titleFntDrop = MiscSec:CreateDropdown({
        Name = "Title Font",
        Options = FontList,
        Default = VelourUI.Settings.Theme.TitleFont.Name,
        Callback = function(val)
            WindowObj:UpdateTheme("TitleFont", Enum.Font[val])
        end
    })
    
    local textFntDrop = MiscSec:CreateDropdown({
        Name = "Text Font",
        Options = FontList,
        Default = VelourUI.Settings.Theme.TextFont.Name,
        Callback = function(val)
            WindowObj:UpdateTheme("TextFont", Enum.Font[val])
        end
    })
    
    local bgImgInput = MiscSec:CreateInput({
        Name = "Background Image ID",
        Placeholder = "Enter Asset ID...",
        Callback = function(val)
            WindowObj:UpdateTheme("BackgroundImage", val)
        end
    })
    
    local bgImgTrSlider = MiscSec:CreateSlider({
        Name = "Image Transparency",
        Min = 0,
        Max = 100,
        Default = VelourUI.Settings.Theme.BgImageTransparency * 100,
        Callback = function(val)
            WindowObj:UpdateTheme("BgImageTransparency", val / 100)
        end
    })
    
    MiscSec:CreateKeybind({
        Name = "Toggle UI Key",
        Default = WindowObj.ToggleKey,
        Callback = function(key, isRebind)
            if isRebind then
                WindowObj.ToggleKey = key
            end
        end
    })

    WindowObj.ThemeUpdaters["CurrentScale"] = function(v, noCb)
        scaleSlider.Set(v * 100, noCb)
    end
    WindowObj.ThemeUpdaters["CornerRadius"] = function(v, noCb)
        local value
        if type(v) == "number" then
            value = v
        else
            value = v.Offset
        end
        radSlider.Set(value, noCb)
    end
    WindowObj.ThemeUpdaters["BgTransparency"] = function(v, noCb)
        bgTrSlider.Set(v * 100, noCb)
    end
    WindowObj.ThemeUpdaters["SectionTransparency"] = function(v, noCb)
        secTrSlider.Set(v * 100, noCb)
    end
    WindowObj.ThemeUpdaters["ElementsTransparency"] = function(v, noCb)
        elemTrSlider.Set(v * 100, noCb)
    end
    WindowObj.ThemeUpdaters["TitleFont"] = function(v, noCb)
        titleFntDrop.Set(v.Name, noCb)
    end
    WindowObj.ThemeUpdaters["TextFont"] = function(v, noCb)
        textFntDrop.Set(v.Name, noCb)
    end
    WindowObj.ThemeUpdaters["BackgroundImage"] = function(v, noCb)
        bgImgInput.Set(v, noCb)
    end
    WindowObj.ThemeUpdaters["BgImageTransparency"] = function(v, noCb)
        bgImgTrSlider.Set(v * 100, noCb)
    end

    local ConfigSec = SettingsTab:CreateSection({
        Name = "Configurations",
        Side = "Left"
    })
    
    local cfgInput = ConfigSec:CreateInput({
        Name = "Config Name",
        Placeholder = "Type to Save..."
    })
    
    local function GetFiles(folder)
        local list = {}
        for _, f in ipairs(list_files(folder)) do
            local name = f:match("([^/\\]+)%.json$")
            if name then
                table.insert(list, name)
            end
        end
        return list
    end

    local function ArrayEquals(a, b)
        if #a ~= #b then
            return false
        end
        for i=1, #a do
            if a[i] ~= b[i] then
                return false
            end
        end
        return true
    end

    local cfgDropdown = ConfigSec:CreateDropdown({
        Name = "Select Config",
        Options = GetFiles(configFolder)
    })

    local autoLoadEnabled = false
    local autoLoadFile = configFolder .. "/autoload.txt"

    local function RealCfgLoad(name)
        local raw = read_file(configFolder .. "/" .. name .. ".json")
        if raw then
            local data = HS:JSONDecode(raw)
            for flag, val in pairs(data) do
                if WindowObj.Flags[flag] then
                    WindowObj.Flags[flag].Set(val, false)
                end
            end
            WindowObj:Notify({
                Title = "System",
                Text = "Config Loaded: " .. name,
                Duration = 3
            })
            if autoLoadEnabled then
                write_file(autoLoadFile, name)
            end
        end
    end

    ConfigSec:CreateButton({
        Name = "Load Config",
        Callback = function()
            local name = cfgDropdown.Get()
            if name and name ~= "" then
                RealCfgLoad(name)
            end
        end
    })

    ConfigSec:CreateButton({
        Name = "Save Config",
        Callback = function()
            local name = cfgInput.Get()
            if name and name ~= "" then
                name = name:gsub("%.json$", "") 
                local data = {}
                for flag, obj in pairs(WindowObj.Flags) do
                    data[flag] = obj.Get()
                end
                write_file(configFolder .. "/" .. name .. ".json", HS:JSONEncode(data))
                cfgDropdown.Refresh(GetFiles(configFolder), true)
                WindowObj:Notify({
                    Title = "System",
                    Text = "Config Saved: " .. name,
                    Duration = 3
                })
            end
        end
    })

    ConfigSec:CreateButton({
        Name = "Delete Config",
        Callback = function()
            local name = cfgDropdown.Get()
            if name and name ~= "" then
                del_file(configFolder .. "/" .. name .. ".json")
                local upList = GetFiles(configFolder)
                cfgDropdown.Refresh(upList)
                WindowObj:Notify({
                    Title = "System",
                    Text = "Config Deleted: " .. name,
                    Duration = 3
                })
            end
        end
    })

    if is_file(autoLoadFile) then
        autoLoadEnabled = true
        local nameToLoad = read_file(autoLoadFile)
        if nameToLoad and is_file(configFolder .. "/" .. nameToLoad .. ".json") then
            task.spawn(function()
                task.wait(1)
                RealCfgLoad(nameToLoad)
                cfgDropdown.Set(nameToLoad, true)
            end)
        end
    end

    ConfigSec:CreateToggle({
        Name = "Auto-Load Selected",
        Default = autoLoadEnabled,
        Callback = function(state)
            autoLoadEnabled = state
            if state then
                local name = cfgDropdown.Get()
                if name and name ~= "" then
                    write_file(autoLoadFile, name)
                end
            else
                if is_file(autoLoadFile) then
                    del_file(autoLoadFile)
                end
            end
        end
    })

    local ThemeSecOption = SettingsTab:CreateSection({
        Name = "Themes",
        Side = "Right"
    })
    
    local thmInput = ThemeSecOption:CreateInput({
        Name = "Theme Name",
        Placeholder = "Type to Save..."
    })
    
    local thmDropdown = ThemeSecOption:CreateDropdown({
        Name = "Select Theme",
        Options = GetFiles("VelourThemes")
    })

    local autoLoadThemeEnabled = false
    local autoLoadThemeFile = "VelourThemes/autoload.txt"

    local function RealThemeLoad(name)
        local raw = read_file("VelourThemes/" .. name .. ".json")
        if raw then
            local data = HS:JSONDecode(raw)
            for k, v in pairs(data) do
                if type(v) == "table" and v[4] == "Color3" then
                    WindowObj:UpdateTheme(k, Color3.new(v[1], v[2], v[3]))
                elseif type(v) == "table" and v[3] == "UDim" then
                    WindowObj:UpdateTheme(k, UDim.new(v[1], v[2]))
                elseif type(v) == "table" and v[2] == "EnumItem" then
                    WindowObj:UpdateTheme(k, Enum.Font[v[1]])
                else
                    WindowObj:UpdateTheme(k, v)
                end
            end
            WindowObj:Notify({
                Title = "System",
                Text = "Theme Loaded: " .. name,
                Duration = 3
            })
            if autoLoadThemeEnabled then
                write_file(autoLoadThemeFile, name)
            end
        end
    end

    ThemeSecOption:CreateButton({
        Name = "Load Theme",
        Callback = function()
            local name = thmDropdown.Get()
            if name and name ~= "" then
                RealThemeLoad(name)
            end
        end
    })

    ThemeSecOption:CreateButton({
        Name = "Save Theme",
        Callback = function()
            local name = thmInput.Get()
            if name and name ~= "" then
                name = name:gsub("%.json$", "")
                local data = {}
                for k, v in pairs(VelourUI.Settings.Theme) do
                    if typeof(v) == "Color3" then
                        data[k] = {v.R, v.G, v.B, "Color3"}
                    elseif typeof(v) == "UDim" then
                        data[k] = {v.Scale, v.Offset, "UDim"}
                    elseif typeof(v) == "EnumItem" then
                        data[k] = {v.Name, "EnumItem"}
                    else
                        data[k] = v
                    end
                end
                write_file("VelourThemes/" .. name .. ".json", HS:JSONEncode(data))
                thmDropdown.Refresh(GetFiles("VelourThemes"), true)
                WindowObj:Notify({
                    Title = "System",
                    Text = "Theme Saved: " .. name,
                    Duration = 3
                })
            end
        end
    })

    ThemeSecOption:CreateButton({
        Name = "Delete Theme",
        Callback = function()
            local name = thmDropdown.Get()
            if name and name ~= "" then
                del_file("VelourThemes/" .. name .. ".json")
                local upList = GetFiles("VelourThemes")
                thmDropdown.Refresh(upList)
                WindowObj:Notify({
                    Title = "System",
                    Text = "Theme Deleted: " .. name,
                    Duration = 3
                })
            end
        end
    })

    if is_file(autoLoadThemeFile) then
        autoLoadThemeEnabled = true
        local nameToLoad = read_file(autoLoadThemeFile)
        if nameToLoad and is_file("VelourThemes/" .. nameToLoad .. ".json") then
            task.spawn(function()
                task.wait(1)
                RealThemeLoad(nameToLoad)
                thmDropdown.Set(nameToLoad, true)
            end)
        end
    end

    ThemeSecOption:CreateToggle({
        Name = "Auto-Load Selected",
        Default = autoLoadThemeEnabled,
        Callback = function(state)
            autoLoadThemeEnabled = state
            if state then
                local name = thmDropdown.Get()
                if name and name ~= "" then
                    write_file(autoLoadThemeFile, name)
                end
            else
                if is_file(autoLoadThemeFile) then
                    del_file(autoLoadThemeFile)
                end
            end
        end
    })

    task.spawn(function()
        while task.wait(1) do
            if WindowObj.IsOpen then
                local newCfgs = GetFiles(configFolder)
                if not ArrayEquals(cfgDropdown.GetOptions(), newCfgs) then
                    cfgDropdown.Refresh(newCfgs, true)
                end
                
                local newThemes = GetFiles("VelourThemes")
                if not ArrayEquals(thmDropdown.GetOptions(), newThemes) then
                    thmDropdown.Refresh(newThemes, true)
                end
            end
        end
    end)

    task.spawn(function()
        task.wait(0.1)
        for _, t in ipairs(WindowObj.Tabs) do
            if not t.IsSettings then
                t.Select()
                return
            end
        end
        if WindowObj.Tabs[1] then
            WindowObj.Tabs[1].Select()
        end
    end)

    return WindowObj
end

return VelourUI
