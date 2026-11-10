-- UMP: Ultimate Math Practice - Roblox client
-- Place in StarterPlayer/StarterPlayerScripts as a LocalScript.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local Data = require(ReplicatedStorage:WaitForChild("UMP"):WaitForChild("FormulaData"))
local remote = ReplicatedStorage:WaitForChild("UMP"):WaitForChild("ProgressRemote")

local COLORS = {
 bg=Color3.fromRGB(5,4,10), panel=Color3.fromRGB(20,17,27), panel2=Color3.fromRGB(30,26,38),
 line=Color3.fromRGB(54,45,65), text=Color3.fromRGB(240,235,245), muted=Color3.fromRGB(168,159,184),
 accent=Color3.fromRGB(232,121,249), accentDark=Color3.fromRGB(26,10,31),
 good=Color3.fromRGB(110,231,168), bad=Color3.fromRGB(240,154,166), amber=Color3.fromRGB(245,201,122)
}
local language = "en"
local scope = "all"
local screenName = "home"
local session, timerToken, savedAttempts, savedState = nil, 0, {}, {}
local activeTopic = nil

local gui = Instance.new("ScreenGui")
gui.Name = "UMP"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.fromScale(1,1)
background.BackgroundColor3 = COLORS.bg
background.BorderSizePixel = 0
background.Parent = gui
local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new({
 ColorSequenceKeypoint.new(0,Color3.fromRGB(10,5,17)),
 ColorSequenceKeypoint.new(0.5,Color3.fromRGB(22,8,29)),
 ColorSequenceKeypoint.new(1,Color3.fromRGB(5,4,10))
})
bgGrad.Rotation = 35
bgGrad.Parent = background

local glow = Instance.new("Frame")
glow.Size = UDim2.fromScale(1,0.35)
glow.Position = UDim2.fromScale(0,0.15)
glow.BackgroundColor3 = Color3.fromRGB(70,24,91)
glow.BackgroundTransparency = 0.76
glow.BorderSizePixel = 0
glow.Parent = background
local glowGrad = Instance.new("UIGradient")
glowGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.5,0.1),NumberSequenceKeypoint.new(1,1)})
glowGrad.Rotation = 0
glowGrad.Parent = glow

local root = Instance.new("Frame")
root.Name = "Game"
root.AnchorPoint = Vector2.new(0.5,0.5)
root.Position = UDim2.fromScale(0.5,0.5)
root.Size = UDim2.new(1,0,1,0)
root.BackgroundTransparency = 1
root.Parent = gui
local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MaxSize = Vector2.new(480,10000)
sizeConstraint.MinSize = Vector2.new(300,0)
sizeConstraint.Parent = root

local function corner(obj, radius)
 local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,radius or 14); c.Parent=obj; return c
end
local function stroke(obj,color,thickness,transparency)
 local s=Instance.new("UIStroke"); s.Color=color or COLORS.line; s.Thickness=thickness or 1; s.Transparency=transparency or 0; s.Parent=obj; return s
end
local function padding(obj,left,right,top,bottom)
 local p=Instance.new("UIPadding"); p.PaddingLeft=UDim.new(0,left or 16); p.PaddingRight=UDim.new(0,right or 16); p.PaddingTop=UDim.new(0,top or 14); p.PaddingBottom=UDim.new(0,bottom or 14); p.Parent=obj
end
local function make(class,parent,props)
 local o=Instance.new(class); for k,v in pairs(props or {}) do o[k]=v end; o.Parent=parent; return o
end
local function label(parent,text,size,color,bold)
 return make("TextLabel",parent,{BackgroundTransparency=1,Text=text or "",TextColor3=color or COLORS.text,Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham,TextSize=size or 16,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutomaticSize=Enum.AutomaticSize.Y,Size=UDim2.new(1,0,0,0)})
end
local function button(parent,text,primary)
 local b=make("TextButton",parent,{AutoButtonColor=true,Text=text,TextColor3=primary and COLORS.accentDark or COLORS.text,Font=Enum.Font.GothamBold,TextSize=16,TextWrapped=true,Size=UDim2.new(1,0,0,48),BackgroundColor3=primary and COLORS.accent or COLORS.panel2,BorderSizePixel=0})
 corner(b,14); if not primary then stroke(b,COLORS.line,1) end
 return b
end
local function clear(container)
 for _,child in ipairs(container:GetChildren()) do if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then child:Destroy() end end
end
local function makePage(name)
 local f=make("Frame",root,{Name=name,Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false})
 local scroll=make("ScrollingFrame",f,{Name="Content",Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=COLORS.accent,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new()})
 padding(scroll,22,22,20,20)
 local list=make("UIListLayout",scroll,{Padding=UDim.new(0,12),HorizontalAlignment=Enum.HorizontalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder})
 return f,scroll,list
end
local homePage,home,homeLayout=makePage("Home")
local learnPage,learn,learnLayout=makePage("Learn")
local sessionPage,play,playLayout=makePage("Session")
local reviewPage,review,reviewLayout=makePage("Review")

local function setPage(name)
 screenName=name
 for n,p in pairs({home=homePage,learn=learnPage,session=sessionPage,review=reviewPage}) do p.Visible=(n==name) end
end
local function title(parent,text,sz)
 local t=label(parent,text,sz or 25,COLORS.text,true); t.LayoutOrder=0; return t
end
local function subtitle(parent,text)
 local t=label(parent,text,13,COLORS.muted,false); t.LayoutOrder=1; return t
end
local function makeHeader(parent,text)
 local t=label(parent,text,20,COLORS.accent,true); t.TextXAlignment=Enum.TextXAlignment.Left; return t
end
local function localized(a,b) return language=="ru" and (b or a) or a end
local function t(en,ru) return localized(en,ru) end
local function addDivider(parent)
 local d=make("Frame",parent,{Size=UDim2.new(1,0,0,1),BackgroundColor3=COLORS.line,BorderSizePixel=0}); return d
end
local function setCanvas(scroll,layout)
 task.defer(function() scroll.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+44) end)
end
local function topicLabel(topic) return localized(topic.name,topic.ru) end

-- Home layout
local homeTitle=title(home,"UMP: Ultimate Math Practice",25)
local kicker=subtitle(home,t("FORMULA PRACTICE","ТРЕНИРОВКА ФОРМУЛ"))
local scopeButton=button(home,t("All topics","Все темы"),false)
scopeButton.Size=UDim2.new(1,0,0,44)
local topicMenu=make("Frame",home,{Visible=false,Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=COLORS.panel,BorderSizePixel=0})
corner(topicMenu,12); stroke(topicMenu,COLORS.line)
local topicList=make("UIListLayout",topicMenu,{Padding=UDim.new(0,4),SortOrder=Enum.SortOrder.LayoutOrder})
padding(topicMenu,8,8,8,8)
local learnButton=button(home,t("Learn formulas","Формулы"),false)
local mainHeading=title(home,t("Formula Memorization","Запоминание формул"),26)
local startButton=button(home,t("Start Training","Начать тренировку"),true)
startButton.Size=UDim2.new(1,0,0,56)
local meta=subtitle(home,"")
local languageButton=button(home,"English ▾",false)
languageButton.Size=UDim2.new(0.55,0,0,40)
local resetButton=button(home,t("Reset my results","Сбросить результаты"),false)
resetButton.Size=UDim2.new(1,0,0,38)

local function updateHome()
 scopeButton.Text=scope=="all" and t("All topics","Все темы") or topicLabel(Data.GetTopic(string.gsub(scope,"^topic:","")))
 languageButton.Text=(language=="ru" and "Русский ▾" or "English ▾")
 local count=0
 local topics=scope=="all" and Data.Topics or {Data.GetTopic(string.gsub(scope,"^topic:",""))}
 for _,topic in ipairs(topics) do count += #topic.formulas*2 end
 meta.Text=tostring(count)..t(" questions in this training"," вопросов в тренировке")
end
local function buildTopicMenu()
 clear(topicMenu)
 for _,topic in ipairs(Data.Topics) do
  local b=button(topicMenu,topicLabel(topic),false); b.Size=UDim2.new(1,0,0,38); b.TextSize=14
  b.Activated:Connect(function() scope="topic:"..topic.id; topicMenu.Visible=false; updateHome() end)
 end
 local all=button(topicMenu,t("All topics","Все темы"),false); all.Size=UDim2.new(1,0,0,38); all.LayoutOrder=99
 all.Activated:Connect(function() scope="all"; topicMenu.Visible=false; updateHome() end)
end
buildTopicMenu()

local function renderLearn()
 clear(learn)
 local back=button(learn,t("← Back","← Назад"),false); back.Activated:Connect(function() setPage("home") end)
 title(learn,t("Learn formulas","Формулы"),24)
 local topics=scope=="all" and Data.Topics or {Data.GetTopic(string.gsub(scope,"^topic:",""))}
 for _,topic in ipairs(topics) do
  makeHeader(learn,topicLabel(topic))
  for _,formula in ipairs(topic.overview) do
   local card=make("TextLabel",learn,{BackgroundColor3=COLORS.panel,TextColor3=COLORS.text,Text=formula,Font=Enum.Font.Gotham,TextSize=15,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,0,0,48),AutomaticSize=Enum.AutomaticSize.Y,BorderSizePixel=0})
   corner(card,10); padding(card,12,12,10,10)
  end
 end
 local start=button(learn,t("Start Training","Начать тренировку"),true)
 start.Activated:Connect(function() startSession() end)
end

local function updateProgressRemote(action,payload)
 local ok,result=pcall(function() return remote:InvokeServer(action,payload) end)
 if ok and result then
  if result.attempts then savedAttempts=result.attempts end
  if result.state then savedState=result.state end
 end
end
task.spawn(function() updateProgressRemote("load") end)

local function updateReviewSchedule(topicId,perfect)
 local current=savedState[topicId] and savedState[topicId].box or 0
 local box=perfect and math.min((current==0 and 1 or current+1),5) or 1
 local due=os.time()+Data.ReviewIntervals[box]*86400
 savedState[topicId]={box=box,due=due}
 updateProgressRemote("state",savedState)
end
local function saveAttempt(item,chosen,correct,first,timeout)
 local record={topic=item.topic,index=item.index,phase=item.phase,chosen=chosen,correct=correct,first=first,timeout=timeout or false,at=os.time(),question=item.question.q}
 table.insert(savedAttempts,record)
 updateProgressRemote("attempt",record)
end
local function unresolvedMistakes()
 local unresolved={}
 for i,record in ipairs(savedAttempts) do
  if not record.correct then
   local fixed=false
   for j=i+1,#savedAttempts do
    local later=savedAttempts[j]
    if later.correct and later.topic==record.topic and later.index==record.index then fixed=true break end
   end
   if not fixed then unresolved[record.topic.."|"..record.index]=true end
  end
 end
 return unresolved
end

local function shuffledCopy(list) return Data.Shuffle(list) end
local function addPracticeRetry(item)
 if session.kind~="retry" then table.insert(session.queue,table.clone(item)) end
end
local function endTimer()
 timerToken += 1
end
local function setSessionProgress()
 local progress=math.floor((session.index-1)/#session.queue*100)
 session.progress.Text=tostring(math.clamp(progress,0,100)).."%"
 session.progressBar.Size=UDim2.new(math.clamp(progress/100,0,1),0,1,0)
end

local function renderQuestion()
 endTimer()
 session.answered=false
 session.timeLeft=Data.TimeLimit
 local item=session.queue[session.index]
 local q=item.question
 if not q then q=Data.GetTopic(item.topic).formulas[item.index] end
 session.current=item
 session.currentQuestion=q
 session.question.Text=localized(q.q,q.qRu)
 session.phase.Text=item.phase=="formula" and t("FORMULA","ФОРМУЛА") or t("PRACTICE","ПРАКТИКА")
 session.feedback.Text=""
 session.next.Visible=false
 session.timer.Text=tostring(Data.TimeLimit)
 session.timer.TextColor3=COLORS.accent
 setSessionProgress()
 clear(session.options)
 local order={1,2,3}; order=Data.Shuffle(order)
 for _,choiceIndex in ipairs(order) do
  local choice=make("TextButton",session.options,{Text=localized(q.o[choiceIndex],q.oRu and q.oRu[choiceIndex] or q.o[choiceIndex]),TextColor3=COLORS.text,Font=Enum.Font.Gotham,TextSize=17,TextWrapped=true,Size=UDim2.new(1,0,0,58),BackgroundColor3=COLORS.panel,BorderSizePixel=0,AutoButtonColor=true})
  corner(choice,12); stroke(choice,COLORS.line,1)
  choice.Activated:Connect(function() answer(choice,choiceIndex) end)
 end
 timerToken += 1
 local thisToken=timerToken
 task.spawn(function()
  for remaining=Data.TimeLimit,0,-1 do
   if thisToken~=timerToken or session.answered then return end
   session.timer.Text=tostring(remaining)
   if remaining<=8 and remaining>3 then session.timer.TextColor3=COLORS.amber elseif remaining<=3 then session.timer.TextColor3=COLORS.bad end
   if remaining==0 then timeoutAnswer() return end
   task.wait(1)
  end
 end)
end

local function addLog(item,chosen,correct,first,timeout)
 table.insert(session.log,{topic=item.topic,index=item.index,phase=item.phase,chosen=chosen,correct=correct,first=first,timeout=timeout,question=session.currentQuestion})
end
function answer(selectedButton,choiceIndex)
 if session.answered then return end
 endTimer()
 session.answered=true
 local item=session.current
 local q=session.currentQuestion
 local correct=choiceIndex==q.a
 local first=session.tried[item.key]==nil
 if first then
  session.tried[item.key]=correct
  if not correct then addPracticeRetry(item) end
 end
 saveAttempt(item,choiceIndex,correct,first,false)
 addLog(item,choiceIndex,correct,first,false)
 for _,obj in ipairs(session.options:GetChildren()) do
  if obj:IsA("TextButton") then
   obj.AutoButtonColor=false
   local index
   -- Button order is stored on the button at creation.
   index=obj:GetAttribute("ChoiceIndex")
   if index==q.a then obj.BackgroundColor3=Color3.fromRGB(21,48,40); stroke(obj,COLORS.good,2)
   elseif obj==selectedButton then obj.BackgroundColor3=Color3.fromRGB(58,30,40); stroke(obj,COLORS.bad,2) end
  end
 end
 session.feedback.Text=correct and t("Correct","Верно") or localized(q.e,q.eRu)
 session.feedback.TextColor3=correct and COLORS.good or COLORS.muted
 session.next.Visible=true
 session.next.Text=session.index<#session.queue and t("Next","Далее") or t("Finish","Завершить")
end
function timeoutAnswer()
 if session.answered then return end
 endTimer()
 session.answered=true
 local item=session.current
 local q=session.currentQuestion
 local first=session.tried[item.key]==nil
 if first then session.tried[item.key]=false; addPracticeRetry(item) end
 saveAttempt(item,-1,false,first,true)
 addLog(item,-1,false,first,true)
 for _,obj in ipairs(session.options:GetChildren()) do
  if obj:IsA("TextButton") then
   obj.AutoButtonColor=false
   if obj:GetAttribute("ChoiceIndex")==q.a then obj.BackgroundColor3=Color3.fromRGB(21,48,40); stroke(obj,COLORS.good,2) end
  end
 end
 session.feedback.Text=t("Time’s up. ","Время вышло. ")..localized(q.e,q.eRu)
 session.feedback.TextColor3=COLORS.amber
 session.next.Visible=true
 session.next.Text=t("Next","Далее")
end

function startSession()
 local queue=Data.BuildSession(scope)
 session={queue=queue,index=1,kind="main",scope=scope,run=os.time(),tried={},log={},answered=false}
 setPage("session")
 renderSessionShell()
 renderQuestion()
end
function renderSessionShell()
 clear(play)
 local top=make("Frame",play,{BackgroundTransparency=1,Size=UDim2.new(1,0,0,44)})
 session.timer=label(top,"30",27,COLORS.accent,true); session.timer.Size=UDim2.new(0.5,0,1,0); session.timer.Position=UDim2.new(0,0,0,0); session.timer.TextXAlignment=Enum.TextXAlignment.Left
 local close=button(top,"×",false); close.Size=UDim2.new(0,44,0,42); close.AnchorPoint=Vector2.new(1,0); close.Position=UDim2.new(1,0,0,0)
 close.Activated:Connect(function() endTimer(); finishSession() end)
 session.progress=label(play,"0%",12,COLORS.muted,false)
 local progressBg=make("Frame",play,{Size=UDim2.new(1,0,0,4),BackgroundColor3=COLORS.line,BorderSizePixel=0})
 session.progressBar=make("Frame",progressBg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=COLORS.accent,BorderSizePixel=0})
 session.phase=label(play,"FORMULA",12,COLORS.muted,true)
 session.question=label(play,"",22,COLORS.text,true)
 session.options=make("Frame",play,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1})
 make("UIListLayout",session.options,{Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder})
 session.feedback=label(play,"",14,COLORS.muted,false); session.feedback.TextXAlignment=Enum.TextXAlignment.Left
 session.next=button(play,t("Next","Далее"),true); session.next.Visible=false
 session.next.Activated:Connect(function()
  if not session.answered then return end
  session.index += 1
  if session.index>#session.queue then finishSession() else renderQuestion() end
 end)
end

function finishSession()
 endTimer()
 local firsts={}
 for _,entry in ipairs(session.log) do if entry.first then table.insert(firsts,entry) end end
 if #firsts==0 then setPage("home"); return end
 local correct,missed,byTopic=0,{},{}
 for _,entry in ipairs(firsts) do
  if entry.correct then correct+=1 else table.insert(missed,entry) end
  byTopic[entry.topic]=byTopic[entry.topic] or {}
  table.insert(byTopic[entry.topic],entry)
 end
 for topicId,entries in pairs(byTopic) do
  local perfect=true
  for _,entry in ipairs(entries) do if not entry.correct then perfect=false end end
  updateReviewSchedule(topicId,perfect)
 end
 renderReview(correct,#firsts,missed,byTopic)
end

function renderReview(correct,total,missed,byTopic)
 clear(review)
 title(review,t("Session complete","Тренировка завершена"),24)
 local score=label(review,correct.."/"..total.."  "..t("correct on first try","верно с первой попытки"),23,COLORS.accent,true)
 if #missed==0 then
  local clean=label(review,t("No mistakes — solid recall.","Ошибок нет. Отличное знание материала."),15,COLORS.good,false)
  clean.BackgroundColor3=COLORS.panel; clean.Size=UDim2.new(1,0,0,48); corner(clean,12)
 else
  makeHeader(review,t("Review mistakes","Разбор ошибок"))
  for _,entry in ipairs(missed) do
   local q=entry.question
   local card=make("Frame",review,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=COLORS.panel,BorderSizePixel=0})
   corner(card,12); padding(card,12,12,10,10)
   local layout=make("UIListLayout",card,{Padding=UDim.new(0,6)})
   label(card,localized(q.q,q.qRu),15,COLORS.text,true)
   label(card,t("Correct answer: ","Правильный ответ: ")..localized(q.o[q.a],q.oRu and q.oRu[q.a] or q.o[q.a]),14,COLORS.good,false)
   label(card,t("Explanation: ","Решение: ")..localized(q.e,q.eRu),13,COLORS.muted,false)
  end
 end
 makeHeader(review,t("By topic","По темам"))
 for _,topic in ipairs(Data.Topics) do
  if byTopic[topic.id] then
   local n,ok=0,0
   for _,entry in ipairs(byTopic[topic.id]) do n+=1; if entry.correct then ok+=1 end end
   local row=label(review,topicLabel(topic).."     "..ok.."/"..n,14,COLORS.text,false); row.TextXAlignment=Enum.TextXAlignment.Left
   local state=savedState[topic.id]
   if state then label(review,t("Next review: ","Повторить: ")..os.date("%x",state.due),12,COLORS.muted,false) end
  end
 end
 if #missed>0 then
  local retry=button(review,t("Practise my mistakes","Повторить ошибки").." ("..#missed..")",true)
  retry.Activated:Connect(function()
   local queue={}
   for _,entry in ipairs(missed) do
    local topic=Data.GetTopic(entry.topic)
    table.insert(queue,{topic=entry.topic,index=entry.index,phase="formula",key=entry.topic.."-f-"..entry.index,question=topic.formulas[entry.index]})
   end
   session={queue=Data.Shuffle(queue),index=1,kind="retry",scope=scope,tried={},log={}}
   setPage("session"); renderSessionShell(); renderQuestion()
  end)
 end
 local new=button(review,t("New session","Новая тренировка"),false)
 new.Activated:Connect(function() startSession() end)
 local homeBtn=button(review,t("Home","На главную"),false)
 homeBtn.Activated:Connect(function() setPage("home"); updateHome() end)
end

-- Input and language controls
scopeButton.Activated:Connect(function() topicMenu.Visible=not topicMenu.Visible end)
learnButton.Activated:Connect(function() renderLearn(); setPage("learn") end)
startButton.Activated:Connect(startSession)
languageButton.Activated:Connect(function()
 language=language=="en" and "ru" or "en"
 updateHome()
end)
resetButton.Activated:Connect(function()
 savedAttempts={}; savedState={}
 updateProgressRemote("reset")
 updateHome()
end)

-- Correct answer identity is stored explicitly on each option.
local oldRenderQuestion=renderQuestion
renderQuestion=function()
 oldRenderQuestion()
 for i,obj in ipairs(session.options:GetChildren()) do
  if obj:IsA("TextButton") then
   -- The displayed text can repeat, so map by text against the option array.
   local displayed=obj.Text
   for choice=1,3 do
    if displayed==localized(session.currentQuestion.o[choice],session.currentQuestion.oRu and session.currentQuestion.oRu[choice] or session.currentQuestion.o[choice]) then
     obj:SetAttribute("ChoiceIndex",choice); break
    end
   end
  end
 end
end

updateHome()
setPage("home")
