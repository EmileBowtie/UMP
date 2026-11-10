-- UMP progress persistence. Place in ServerScriptService as a Script.
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local folder = ReplicatedStorage:FindFirstChild("UMP") or Instance.new("Folder")
folder.Name = "UMP"
folder.Parent = ReplicatedStorage
local remote = folder:FindFirstChild("ProgressRemote") or Instance.new("RemoteFunction")
remote.Name = "ProgressRemote"
remote.Parent = folder

local store = DataStoreService:GetDataStore("UMP_PlayerProgress_v1")
local cache = {}

local function key(player) return "user_"..player.UserId end
local function load(player)
 local ok,data=pcall(function() return store:GetAsync(key(player)) end)
 if ok and type(data)=="table" then cache[player.UserId]=data else cache[player.UserId]={attempts={},state={}} end
 cache[player.UserId].attempts=cache[player.UserId].attempts or {}
 cache[player.UserId].state=cache[player.UserId].state or {}
end
local function save(player)
 local data=cache[player.UserId]
 if not data then return end
 pcall(function() store:SetAsync(key(player),data) end)
end
Players.PlayerAdded:Connect(load)
Players.PlayerRemoving:Connect(function(player) save(player); cache[player.UserId]=nil end)

remote.OnServerInvoke=function(player,action,payload)
 if not cache[player.UserId] then load(player) end
 local data=cache[player.UserId]
 if action=="load" then return {attempts=data.attempts,state=data.state} end
 if action=="attempt" and type(payload)=="table" then
  table.insert(data.attempts,payload)
  if #data.attempts>5000 then table.remove(data.attempts,1) end
  task.spawn(save,player)
  return {ok=true}
 elseif action=="state" and type(payload)=="table" then
  data.state=payload; task.spawn(save,player); return {ok=true}
 elseif action=="reset" then
  data.attempts={}; data.state={}; task.spawn(save,player); return {ok=true}
 end
 return {ok=false}
end
