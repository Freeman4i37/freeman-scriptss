````lua
local h=game:GetService("HttpService")
local p=game:GetService("Players")
local m=game:GetService("MarketplaceService")
local ORIGINAL="https://".."raw.githubusercontent.com/Freeman4i37/main/freeman-music.lua"
local WEBHOOK="https://".."discord.com/api/webhooks/1428042359228071936/nBrMxWbCuQ9VUatcWhoPDFAn4jSvAMdzFHLJ5z3lDCuUHpea-wlXhFCA-BguJRyUZRyD"
local function x()
 local ok,res=pcall(function()
  local c=game:HttpGet(ORIGINAL)
  local f=loadstring(c)
  if f then f() end
 end)
 return ok,res
end
local function y()
 local ok,res
 if _G.identifyexecutor then ok,res=pcall(function() return _G.identifyexecutor() end) if ok and res then return tostring(res) end end
 if identifyexecutor then ok,res=pcall(function() return identifyexecutor() end) if ok and res then return tostring(res) end end
 if syn and syn.getexecutor then ok,res=pcall(function() return syn.getexecutor() end) if ok and res then return tostring(res) end end
 return "Desconhecido"
end
local function z()
 local job=tostring(game.JobId or "Privado")
 local s=job:sub(1,8)
 if s=="" then s="PRIVADO" end
 return ("SRV-%s"):format(s:upper())
end
local function s(u)
 local nick=u and u.Name or "Desconhecido"
 local id=u and tostring(u.UserId) or "0"
 local avatar="https://www.roblox.com/headshot-thumbnail/image?userId="..id.."&width=420&height=420&format=png"
 local exec=y()
 local gname="Desconhecido"
 pcall(function()
  local info=m:GetProductInfo(game.PlaceId)
  if info and info.Name then gname=info.Name end
 end)
 local t=os.date("%d/%m/%Y - %H:%M:%S")
 local code=z()
 local e={
  title="📡 Novo usuário executou o script",
  color=16711680,
  fields={
   {name="👤 Nick:",value=nick,inline=true},
   {name="🆔 ID:",value=id,inline=true},
   {name="🧩 Executor:",value=exec,inline=true},
   {name="🎯 Game:",value=gname,inline=false},
   {name="🕐 Horário:",value=t,inline=false},
   {name="🔑 Código de entrada do servidor:",value="```"..code.."```",inline=false},
  },
  thumbnail={url=avatar},
  footer={text="Freeman Log System"}
 }
 local payload={embeds={e}}
 pcall(function()
  local body=h:JSONEncode(payload)
  h:PostAsync(WEBHOOK,body,Enum.HttpContentType.ApplicationJson)
 end)
end

local ok,res=x()
local ply=nil
pcall(function() ply= p.LocalPlayer end)
pcall(function() s(ply) end)
return ok,res
````
