-- gui
local img
if not game:GetService("CoreGui"):FindFirstChild("davai_gui") then
    gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    gui.Name = "davai_gui"
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    img = Instance.new("ImageLabel", gui)
    img.Name = "image"
    img.BackgroundTransparency = 1
    img.AnchorPoint = Vector2.new(0.5, 0.5)
    img.Position = UDim2.new(0.5, 0, 0.5, 0)
    img.Size = UDim2.new(0.12, 0, 0.2, 0)
    img.Visible = false
    img.Image = ""
end

-- files
if not isfolder("davai") then makefolder("davai") end
if not isfolder("davai/audios") then makefolder("davai/audios") end
if not isfolder("davai/pics") then makefolder("davai/pics") end

local pics = {
    ["1"] = "https://raw.githubusercontent.com/Bac0nHck/davai/refs/heads/main/pics/1.png",
    ["2"] = "https://raw.githubusercontent.com/Bac0nHck/davai/refs/heads/main/pics/2.png",
    ["3"] = "https://raw.githubusercontent.com/Bac0nHck/davai/refs/heads/main/pics/3.png",
    ["4"] = "https://raw.githubusercontent.com/Bac0nHck/davai/refs/heads/main/pics/4.png",
    ["5"] = "https://raw.githubusercontent.com/Bac0nHck/davai/refs/heads/main/pics/5.png"
}
local audios = {
    ["1"] = "https://github.com/Bac0nHck/davai/raw/refs/heads/main/audio/1.mp3",
    ["2"] = "https://github.com/Bac0nHck/davai/raw/refs/heads/main/audio/2.mp3",
    ["3"] = "https://github.com/Bac0nHck/davai/raw/refs/heads/main/audio/3.mp3",
    ["4"] = "https://github.com/Bac0nHck/davai/raw/refs/heads/main/audio/4.mp3",
    ["5"] = "https://github.com/Bac0nHck/davai/raw/refs/heads/main/audio/5.mp3"
}

local function downloadFile(url, path)
    if not isfile(path) then
        writefile(path, game:HttpGet(url))
        print("✅ Downloaded: " .. path)
    end
end

for name, url in pairs(pics) do
    downloadFile(url, "davai/pics/" .. name .. ".png")
end
for name, url in pairs(audios) do
    downloadFile(url, "davai/audios/" .. name .. ".mp3")
end

-- main
local players = game:GetService("Players")
local plr = players.LocalPlayer
local function getRandomPic()
    local files = listfiles("davai/pics")
    local randomFile = files[math.random(1, #files)]
    return getcustomasset(randomFile)
end
local function getRandomAudio()
    local files = listfiles("davai/audios")
    local randomFile = files[math.random(1, #files)]
    return getcustomasset(randomFile)
end

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        img.Visible = true
        img.Image = getRandomPic()

        local sound = Instance.new("Sound")
        sound.SoundId = getRandomAudio()
        sound.Volume = 2
        sound.Parent = game:GetService("SoundService")
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)

        task.wait(players.RespawnTime)

        img.Visible = false
    end)
end

plr.CharacterAdded:Connect(onCharacterAdded)
if plr.Character then
    onCharacterAdded(plr.Character)
end
-- t.me/arceusxcommunity
