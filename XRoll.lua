local ADDON_NAME = ...

XRollOption = {};
XRollOption.panel = CreateFrame( "Frame", "XRoll_Options", UIParent );
XRollOption.panel.name = "XRoll Options";
InterfaceOptions_AddCategory(XRollOption.panel);

posX = 0
posY = 0
posPoint = "CENTER"
setTimeUpdate = false
ifsoundisplaying = false
ifsoundisplayingdebuff = false
ifsoundisplayingultra = false
soundPlay = true;
lang = "EN"
textAttackIcons = true
textAttackTop = true
tooltipcd = true
fontSize = 20
lock = true
iftooltip = true
tailleicon = 48
tailleFontTextattack = 10
FrameWidth = 250
FrameHeight = 64
spell1 = 0
spell2 = 0
spell3 = 0
spell4 = 0
spell5 = 0
spell6 = 0
spell7 = 0
horizontaly = true
			
local frameWindow = CreateFrame("Frame", "DragFrame2", UIParent)
frameWindow:SetMovable(false)
frameWindow:EnableMouse(false)
frameWindow:SetScript("OnMouseDown", function(self, button)
  if button == "LeftButton" and not self.isMoving then
	self:StartMoving();
	self.isMoving = true;
  end
end)
frameWindow:SetScript("OnMouseUp", function(self, button)
  if button == "LeftButton" and self.isMoving then
	local point, relativeTo, relativePoint, xX, yY = frameWindow:GetPoint()
	self:StopMovingOrSizing();
	self.isMoving = false;
	posX = xX
	posY = yY
	posPoint = point
	XRollPosDB = {
		["Posx"] = posX,
		["PosY"] = posY,
		["CENTER"] = posPoint,
	}
  end
end)
frameWindow:SetScript("OnHide", function(self)
  if (self.isMoving) then
   self:StopMovingOrSizing();
   self.isMoving = false;
  end
end)
-- The code below makes the frame visible, and is not necessary to enable dragging.
frameWindow:SetMovable(false)
frameWindow:EnableMouse(false)
if tailleicon == 32 then
	frameWindow:SetWidth(250);
	frameWindow:SetHeight(64);
elseif tailleicon == 48 then
	frameWindow:SetWidth(350);
	frameWindow:SetHeight(72);
else
	frameWindow:SetWidth(450);
	frameWindow:SetHeight(80);
end

local tex = frameWindow:CreateTexture("ARTWORK");
tex:SetAllPoints();
tex:SetTexture(1.0, 0.5, 0, 0.5)
tex:SetAlpha(0);

SLASH_HELLOWORLD1 = '/xr';
local function handler(msg, editbox)
	if msg == 'unlock' then
		if lock == true then
			frameWindow:SetMovable(true)
			frameWindow:EnableMouse(true)
			tex:SetAlpha(0.5);
			lock = false
			btnunlock:Disable()
			btnlock:Enable()
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Bar unlock!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Bar débloqué!", 1, 1, .5);
			end
		else
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Bar is already unlocked!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Bar déjà débloqué!", 1, 1, .5);
			end
		end
	elseif msg == 'lock' then
		if lock == false then
			frameWindow:SetMovable(false)
			frameWindow:EnableMouse(false)
			tex:SetAlpha(0);
			lock = true
			btnunlock:Enable()
			btnlock:Disable()
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Bar lock!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Bar bloqué!", 1, 1, .5);
			end
		else
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Bar is already locked!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Bar déjà bloqué!", 1, 1, .5);
			end
		end
	elseif msg == 'help' then
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : /xr <option>:", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     unlock - unlock bar", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     lock - lock bar", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     toolon - Show tooltip buff", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     tooloff - Hide tooltip buff", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     icon32 - icon size 32x32", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     icon48 - icon size 48x48", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     icon64 - icon size 64x64", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     cdon - Show cooldown text", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     cdoff - Hide cooldown text", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : /xr <option>:", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     unlock - débloque la bar", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     lock - bloque la bar", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     toolon - Affiche les tooltips", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     tooloff - Cache les tooltips", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     icon32 - Taille icône 32x32", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     icon48 - Taille icône 48x48", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     icon64 - Taille icône 64x64", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     cdon - Affiche le cooldown des buffs", 1, 1, .5);
			DEFAULT_CHAT_FRAME:AddMessage("     cdoff - Cache le cooldown des buffs", 1, 1, .5);
		end
	elseif msg == 'toolon' then
		iftooltip = true
		tooltipon:SetChecked(true)
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Tooltip is ON!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Tooltip activé!", 1, 1, .5);
		end
	elseif msg == 'tooloff' then
		iftooltip = false
		tooltipon:SetChecked(false)
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Tooltip is OFF!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Tooltip désactivé!", 1, 1, .5);
		end
	elseif msg == 'icon32' then
		tailleicon = 32
		if(horizontaly)then
			frameWindow:SetWidth(250);
			frameWindow:SetHeight(64);
			FrameWidth = 250
			FrameHeight = 64
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}
		else
			frameWindow:SetWidth(64);
			frameWindow:SetHeight(250);
			FrameWidth = 64
			FrameHeight = 250
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}
		end
		f1:SetWidth(tailleicon)
		f1:SetHeight(tailleicon)
		f2:SetWidth(tailleicon)
		f2:SetHeight(tailleicon)
		f3:SetWidth(tailleicon)
		f3:SetHeight(tailleicon)
		f4:SetWidth(tailleicon)
		f4:SetHeight(tailleicon)
		f5:SetWidth(tailleicon)
		f5:SetHeight(tailleicon)
		f6:SetWidth(tailleicon)
		f6:SetHeight(tailleicon)
		f7:SetWidth(tailleicon)
		f7:SetHeight(tailleicon)
		fra:SetValue(0)
		tailleFontTextattack = 8
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Icon is 32x32!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Taille icône 32x32!", 1, 1, .5);
		end
	elseif msg == 'icon48' then
		tailleicon = 48
		if(horizontaly)then
			frameWindow:SetWidth(350);
			frameWindow:SetHeight(72);
			FrameWidth = 350
			FrameHeight = 72
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}
		else
			frameWindow:SetWidth(72);
			frameWindow:SetHeight(350);
			FrameWidth = 72
			FrameHeight = 350
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}

		end
		f1:SetWidth(tailleicon)
		f1:SetHeight(tailleicon)
		f2:SetWidth(tailleicon)
		f2:SetHeight(tailleicon)
		f3:SetWidth(tailleicon)
		f3:SetHeight(tailleicon)
		f4:SetWidth(tailleicon)
		f4:SetHeight(tailleicon)
		f5:SetWidth(tailleicon)
		f5:SetHeight(tailleicon)
		f6:SetWidth(tailleicon)
		f6:SetHeight(tailleicon)
		f7:SetWidth(tailleicon)
		f7:SetHeight(tailleicon)
		fra:SetValue(50)
		tailleFontTextattack = 10
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Icon is 48x48!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Taille icône 48x48!", 1, 1, .5);
		end
	elseif msg == 'icon64' then
		tailleicon = 64
		if(horizontaly)then
			frameWindow:SetWidth(450);
			frameWindow:SetHeight(80);
			FrameWidth = 450
			FrameHeight = 80
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}
		else
			frameWindow:SetWidth(80);
			frameWindow:SetHeight(450);
			FrameWidth = 80
			FrameHeight = 450
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}

		end
		f1:SetWidth(tailleicon)
		f1:SetHeight(tailleicon)
		f2:SetWidth(tailleicon)
		f2:SetHeight(tailleicon)
		f3:SetWidth(tailleicon)
		f3:SetHeight(tailleicon)
		f4:SetWidth(tailleicon)
		f4:SetHeight(tailleicon)
		f5:SetWidth(tailleicon)
		f5:SetHeight(tailleicon)
		f7:SetWidth(tailleicon)
		f7:SetHeight(tailleicon)
		fra:SetValue(100)
		tailleFontTextattack = 11
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Icon is 64x64!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Taille icône 64x64!", 1, 1, .5);
		end
	elseif msg == 'cdon' then
		tooltipcd = true
		tooltipoCool:SetChecked(true)
		n7:Show()
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Cooldown is On!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Cooldown activé!", 1, 1, .5);
		end
		XRollPosDB = {
			["Cooldownn"] = true,
		}
	elseif msg == 'cdoff' then
		tooltipcd = false
		tooltipoCool:SetChecked(false)
		n7:Hide()
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Cooldown is Off!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Cooldown désactivé!", 1, 1, .5);
		end
		XRollPosDB = {
			["Cooldownn"] = false,
		}
	elseif msg == 'option' then
		InterfaceOptionsFrame_OpenToCategory("XRoll Options");
	elseif msg == 'load' then
		ReloadUI();
	end
end

 
SlashCmdList["HELLOWORLD"] = handler; -- Also a valid assignment strategy

local f1 = CreateFrame("FRAME",nil, UIParent)
f1:SetFrameStrata("BACKGROUND")
f1:SetWidth(tailleicon) -- Set these to whatever height/width is needed 
f1:SetHeight(tailleicon) -- for your Texture
local t1 = f1:CreateTexture("$parentIcon","BACKGROUND")
t1:SetAllPoints(f1)
local c1 = CreateFrame("Cooldown", nil, f1, "CooldownFrameTemplate")
c1:SetReverse(true)
c1:SetAllPoints(t1)
local n1 = c1:CreateFontString(nil, "OVERLAY")
n1:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n1:SetTextColor(0.8, 0.8, 0.8)
n1:SetPoint("CENTER", -1, 1)
n1:SetJustifyH("CENTER")
f1.MaxLabel = f1:CreateFontString(nil, "Overlay")
f1.MaxLabel:SetWordWrap(true)


local f2 = CreateFrame("FRAME",nil,frameWindow:GetParent())
f2:SetFrameStrata("BACKGROUND")
f2:SetWidth(tailleicon) -- Set these to whatever height/width is needed 
f2:SetHeight(tailleicon) -- for your Texture
local t2 = f2:CreateTexture(nil,"BACKGROUND")
t2:SetAllPoints(f2)
local c2 = CreateFrame("Cooldown", nil, f2, "CooldownFrameTemplate")
c2:SetReverse(true)
c2:SetAllPoints(t2)
local n2 = c2:CreateFontString(nil, "OVERLAY")
n2:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n2:SetTextColor(0.8, 0.8, 0.8)
n2:SetPoint("CENTER", -1, 1)
n2:SetJustifyH("CENTER")
f2.MaxLabel = f2:CreateFontString(nil, "Overlay")
f2.MaxLabel:SetWordWrap(true)
f2.MaxLabel:SetPoint("TOP", 0, 50)


local f3 = CreateFrame("FRAME",nil,frameWindow:GetParent())
f3:SetFrameStrata("BACKGROUND")
f3:SetWidth(tailleicon) -- Set these to whatever height/width is needed 
f3:SetHeight(tailleicon) -- for your Texture
local t3 = f3:CreateTexture(nil,"BACKGROUND")
t3:SetAllPoints(f3)
local c3 = CreateFrame("Cooldown", nil, f3, "CooldownFrameTemplate")
c3:SetReverse(true)
c3:SetAllPoints(t3)
local n3 = c3:CreateFontString(nil, "OVERLAY")
n3:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n3:SetTextColor(0.8, 0.8, 0.8)
n3:SetPoint("CENTER", -1, 1)
n3:SetJustifyH("CENTER")
f3.MaxLabel = f3:CreateFontString(nil, "Overlay")
f3.MaxLabel:SetWordWrap(true)
f3.MaxLabel:SetPoint("TOP", 0, 50)


local f4 = CreateFrame("Frame",nil,frameWindow:GetParent())
f4:SetFrameStrata("BACKGROUND")
f4:SetWidth(tailleicon) -- Set these to whatever height/width is needed 
f4:SetHeight(tailleicon) -- for your Texture
local t4 = f4:CreateTexture(nil,"BACKGROUND")
t4:SetAllPoints(f4)
local c4 = CreateFrame("Cooldown", nil, f4, "CooldownFrameTemplate")
c4:SetReverse(true)
c4:SetAllPoints(t4)
local n4 = c4:CreateFontString(nil, "OVERLAY")
n4:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n4:SetTextColor(0.8, 0.8, 0.8)
n4:SetPoint("CENTER", -1, 1)
n4:SetJustifyH("CENTER")
f4.MaxLabel = f4:CreateFontString(nil, "Overlay")
f4.MaxLabel:SetWordWrap(true)
f4.MaxLabel:SetPoint("TOP", 0, 50)


local f5 = CreateFrame("Frame",nil,frameWindow:GetParent())
f5:SetFrameStrata("BACKGROUND")
f5:SetWidth(tailleicon) -- Set these to whatever height/width is needed 
f5:SetHeight(tailleicon) -- for your Texture
local t5 = f5:CreateTexture(nil,"BACKGROUND")
t5:SetAllPoints(f5)
local c5 = CreateFrame("Cooldown", nil, f5, "CooldownFrameTemplate")
c5:SetReverse(true)
c5:SetAllPoints(t5)
local n5 = c5:CreateFontString(nil, "OVERLAY")
n5:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n5:SetTextColor(0.8, 0.8, 0.8)
n5:SetPoint("CENTER", -1, 1)
n5:SetJustifyH("CENTER")
f5.MaxLabel = f5:CreateFontString(nil, "Overlay")
f5.MaxLabel:SetWordWrap(true)
f5.MaxLabel:SetPoint("TOP", 0, 50)


local f6 = CreateFrame("Frame",nil,frameWindow:GetParent())
f6:SetFrameStrata("BACKGROUND")
f6:SetWidth(tailleicon) -- Set these to whatever height/width is needed 
f6:SetHeight(tailleicon) -- for your Texture
local t6 = f6:CreateTexture(nil,"BACKGROUND")
t6:SetAllPoints(f6)
local c6 = CreateFrame("Cooldown", nil, f6, "CooldownFrameTemplate")
c6:SetReverse(true)
c6:SetAllPoints(t6)
local n6 = c6:CreateFontString(nil, "OVERLAY")
n6:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n6:SetTextColor(0.8, 0.8, 0.8)
n6:SetPoint("CENTER", -1, 1)
n6:SetJustifyH("CENTER")
f6.MaxLabel = f6:CreateFontString(nil, "Overlay")
f6.MaxLabel:SetWordWrap(true)
f6.MaxLabel:SetPoint("TOP", 0, 50)


local f8 = CreateFrame("Frame",nil,frameWindow:GetParent())
f8:SetFrameStrata("BACKGROUND")
f8:SetWidth(tailleicon+14) -- Set these to whatever height/width is needed 
f8:SetHeight(tailleicon+14) -- for your Texture
local t8 = f8:CreateTexture(nil,"BACKGROUND")
t8:SetAllPoints(f8)
local c8 = CreateFrame("Cooldown", nil, f8, "CooldownFrameTemplate")
c8:SetReverse(true)
c8:SetAllPoints(t8)
local n8 = c8:CreateFontString(nil, "OVERLAY")
n8:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n8:SetTextColor(0.8, 0.8, 0.8)
n8:SetPoint("CENTER", -1, 1)
n8:SetJustifyH("CENTER")
f8.MaxLabel = f8:CreateFontString(nil, "Overlay")
f8.MaxLabel:SetWordWrap(true)
f8.MaxLabel:SetPoint("TOP", 0, 50)

local Z = CreateFrame("Frame")
Z:RegisterEvent("COMBAT_LOG_EVENT")
Z:SetScript("OnEvent",function(...)
	--local s=select
	local spellId, spellName, spellSchool, _, _, _, _, _, _, _, kiki = select(4, ...)
	if kiki == 57841 then 
		if ifsoundisplayingultra == false and soundPlay == true then
			PlaySoundFile("Interface\\AddOns\\XRoll\\Sound\\ultra.mp3", "Master")
			ifsoundisplayingultra = true
			setTimeUpdate = true
		end
	end
end)

local fee = CreateFrame('Frame')
local last = 0
local throttle = 5
fee:SetScript('OnUpdate', function(self, elapsed)
	if setTimeUpdate == true then
		last = last + elapsed
		if last > throttle then
			setTimeUpdate = false
			ifsoundisplayingultra = false
			last = 0 
		end
	end
end)

--[[local d=CreateFrame("FRAME");
d:RegisterEvent("UNIT_DEBUFF","player");
local function debu()
	class = select(2, UnitClass("player"));
	if class == "ROGUE" then
		for i=1,40 do local  name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff("player", i)
			if(spellId)then
					if spellId == 202665 then
					
						if ifsoundisplayingdebuff == false and soundPlay == true then
							PlaySoundFile("Interface\\AddOns\\XRoll\\Sound\\debuff.mp3", "Master")
							ifsoundisplayingdebuff = true
						end
						
						local dudu = expirationTime - GetTime()
						local dudu2 = math.floor(dudu+0.5)
						spell7 = spellId
						t8:SetTexture(icon)
						f8.texture = t8
						f8.MaxLabel:SetFont("Fonts\\FRIZQT__.TTF", tailleFontTextattack, "OUTLINE")
								
						if tailleicon == 32 then
							f8.MaxLabel:SetSize(75, 70)
							f8:SetPoint("CENTER", frameWindow, "CENTER", 120, 120)
						elseif tailleicon == 48 then
							f8.MaxLabel:SetSize(80, 70)
							f8:SetPoint("CENTER", frameWindow, "CENTER", 130, 130)
						else
							f8.MaxLabel:SetSize(80, 70)
							f8:SetPoint("CENTER", frameWindow, "CENTER", 140, 140)
						end
							
						f8:Show()
						c8:Show()
						
						f8.MaxLabel:SetText("SPECIAL")
							
						if textAttackTop == true then
							f8.MaxLabel:ClearAllPoints();
							f8.MaxLabel:SetPoint("TOP", 0, 50)
						else
							f8.MaxLabel:ClearAllPoints();
							f8.MaxLabel:SetPoint("BOTTOM", 0, -50)
						end
							
						if tooltipcd == true then
							n8:SetText(dudu2)
							n8:Show()
						else
							n8:SetText("")
							n8:Hide()
						end
						CooldownFrame_Set(c8, expirationTime-duration, duration, 1)
					end
			end
		end
	end
end
d:SetScript("OnUpdate",debu);]]

local f=CreateFrame("FRAME");
f:RegisterEvent("UNIT_AURA","player");

local function asd()
	class = select(2, UnitClass("player"));
	e = 0;
	if class == "ROGUE" then
	--local currentHealth = UnitHealth("target")
	--local MaxcurrentHealth = UnitHealthMax("target")
	--local totalpource = currentHealth * 100 / MaxcurrentHealth
	--DEFAULT_CHAT_FRAME:AddMessage( "target health ="..totalpource )
			for i=1,40 do local name,_,_,count,_,duration,expires,_,_,_,spellID, timeMod = UnitBuff("player", i)
				if(spellID)then
					local name, rank, icone, castingTime, minRange, maxRange = GetSpellInfo(spellID)
					if (spellID == 193356 or spellID == 193357 or spellID == 193358 or spellID == 199603 or spellID == 199600 or spellID == 193359) then
						e = e + 1;
						affbuff = true
						local dudu = expires - GetTime()
						local dudu2 = math.floor(dudu+0.5)

						


						if e == 1 then
							spell1 = spellID
							f2:Hide()
							f3:Hide()
							f4:Hide()
							f5:Hide()
							f6:Hide()
							t1:SetTexture(icone)
							f1.texture = t1
							f1.MaxLabel:SetFont("Fonts\\FRIZQT__.TTF", tailleFontTextattack, "OUTLINE")
							
							if tailleicon == 32 then
								f1.MaxLabel:SetSize(70, 70)
								f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
							elseif tailleicon == 48 then
								f1.MaxLabel:SetSize(75, 70)
								f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
							else
								f1.MaxLabel:SetSize(80, 70)
								f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
							end
							
							
							if spell1 == 193356 then
								
								f1.MaxLabel:SetText("POINT COMBO X2")
							elseif spell1 == 193357 then
								if ifsoundisplaying == false and soundPlay == true then 
									PlaySoundFile("Interface\\AddOns\\XRoll\\Sound\\breaker.mp3", "Master")
									ifsoundisplaying = true;
								end
								if lang == "EN" then
									f1.MaxLabel:SetText("+25% CRITICAL")
								else
									f1.MaxLabel:SetText("+25% CRITIQUE")
								end
							elseif spell1 == 193358 then
								if lang == "EN" then
									f1.MaxLabel:SetText("+25% ATTACK SPEED")
								else
									f1.MaxLabel:SetText("+25% VITESSE ATTAQUE")
								end
							elseif spell1 == 199603 then
								if lang == "EN" then
									f1.MaxLabel:SetText("+25% SABER X2")
								else
									f1.MaxLabel:SetText("+25% SABRE X2")
								end
							elseif spell1 == 199600 then
								f1.MaxLabel:SetText("+25% REGEN")
							elseif spell1 == 193359 then
								if lang == "EN" then
									f1.MaxLabel:SetText("REDUCE COOLDOWN")
								else
									f1.MaxLabel:SetText("REDUIT COOLDOWN")
								end
							end
							
							if textAttackTop == true then
								f1.MaxLabel:ClearAllPoints();
								f1.MaxLabel:SetPoint("TOP", 0, 50)
							else
								f1.MaxLabel:ClearAllPoints();
								f1.MaxLabel:SetPoint("BOTTOM", 0, -50)
							end
							
							f1:Show()
							c1:Show()
							
							
							if textAttackIcons == true then
								f1.MaxLabel:Show()
							else
								f1.MaxLabel:Hide()
							end
							
							if tooltipcd == true then
								n1:SetText(dudu2)
								n1:Show()
							else
								n1:SetText("")
								n1:Hide()
							end
							CooldownFrame_Set(c1, expires-duration, duration, 1)
						elseif e == 2 then
							spell2 = spellID
							f3:Hide()
							f4:Hide()
							f5:Hide()
							f6:Hide()
							t2:SetTexture(icone)
							f2.texture = t2
							f2.MaxLabel:SetFont("Fonts\\FRIZQT__.TTF", tailleFontTextattack, "OUTLINE")
							
							if tailleicon == 32 then
								f2.MaxLabel:SetSize(70, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 30, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", -30, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 35)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, -35)
								end
							elseif tailleicon == 48 then
								f2.MaxLabel:SetSize(75, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 35, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", -35, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 40)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, -40)
								end
							else
								f2.MaxLabel:SetSize(80, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 45, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", -45, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 50)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, -50)
								end
							end
							
							if spell2 == 193356 then
								
								f2.MaxLabel:SetText("POINT COMBO X2")
							elseif spell2 == 193357 then
								
								if lang == "EN" then
									f2.MaxLabel:SetText("+25% CRITICAL")
								else
									f2.MaxLabel:SetText("+25% CRITIQUE")
								end
							elseif spell2 == 193358 then
								
								if lang == "EN" then
									f2.MaxLabel:SetText("+25% ATTACK SPEED")
								else
									f2.MaxLabel:SetText("+25% VITESSE ATTAQUE")
								end
							elseif spell2 == 199603 then
								
								if lang == "EN" then
									f2.MaxLabel:SetText("+25% SABER X2")
								else
									f2.MaxLabel:SetText("+25% SABRE X2")
								end
							elseif spell2 == 199600 then
								
								f2.MaxLabel:SetText("+25% REGEN")
							elseif spell2 == 193359 then
								
								if lang == "EN" then
									f2.MaxLabel:SetText("REDUCE COOLDOWN")
								else
									f2.MaxLabel:SetText("REDUIT COOLDOWN")
								end
							end
							
							if textAttackTop == true then
								f2.MaxLabel:ClearAllPoints();
								f2.MaxLabel:SetPoint("TOP", 0, 50)
							else
								f2.MaxLabel:ClearAllPoints();
								f2.MaxLabel:SetPoint("BOTTOM", 0, -50)
							end
							
							f2:Show()
							c2:Show()
							
							if textAttackIcons == true then
								f2.MaxLabel:Show()
							else
								f2.MaxLabel:Hide()
							end
							
							if tooltipcd == true then
								n2:SetText(dudu2)
								n2:Show()
							else
								n2:SetText("")
								n2:Hide()
							end
							CooldownFrame_Set(c2, expires-duration, duration, 1)
						elseif e == 3 then
							spell3 = spellID
							f4:Hide()
							f5:Hide()
							f6:Hide()
							t3:SetTexture(icone)
							f3.texture = t3
							f3.MaxLabel:SetFont("Fonts\\FRIZQT__.TTF", tailleFontTextattack, "OUTLINE")
							
							if tailleicon == 32 then
								f3.MaxLabel:SetSize(70, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 60, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", -60, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 65)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, -65)

								end
							elseif tailleicon == 48 then
								f3.MaxLabel:SetSize(75, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 70, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", -70, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 75)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, -75)

								end
							else
								f3.MaxLabel:SetSize(80, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 90, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", -90, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 95)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, -95)

								end
							end
							
							if spell3 == 193356 then
								
								f3.MaxLabel:SetText("POINT COMBO X2")
							elseif spell3 == 193357 then
								
								if lang == "EN" then
									f3.MaxLabel:SetText("+25% CRITICAL")
								else
									f3.MaxLabel:SetText("+25% CRITIQUE")
								end
							elseif spell3 == 193358 then
								
								if lang == "EN" then
									f3.MaxLabel:SetText("+25% ATTACK SPEED")
								else
									f3.MaxLabel:SetText("+25% VITESSE ATTAQUE")
								end
							elseif spell3 == 199603 then
								
								if lang == "EN" then
									f3.MaxLabel:SetText("+25% SABER X2")
								else
									f3.MaxLabel:SetText("+25% SABRE X2")
								end
							elseif spell3 == 199600 then
								
								f3.MaxLabel:SetText("+25% REGEN")
							elseif spell3 == 193359 then
								
								if lang == "EN" then
									f3.MaxLabel:SetText("REDUCE COOLDOWN")
								else
									f3.MaxLabel:SetText("REDUIT COOLDOWN")
								end
							end
							
							if textAttackTop == true then
								f3.MaxLabel:ClearAllPoints();
								f3.MaxLabel:SetPoint("TOP", 0, 50)
							else
								f3.MaxLabel:ClearAllPoints();
								f3.MaxLabel:SetPoint("BOTTOM", 0, -50)
							end
							
							f3:Show()
							c3:Show()
							
							if textAttackIcons == true then
								f3.MaxLabel:Show()
							else
								f3.MaxLabel:Hide()
							end
							
							if tooltipcd == true then
								n3:SetText(dudu2)
								n3:Show()
							else
								n3:SetText("")
								n3:Hide()
							end
							CooldownFrame_Set(c3, expires-duration, duration, 1)
						elseif e == 4 then
							spell4 = spellID
							f5:Hide()
							f6:Hide()
							t4:SetTexture(icone)
							f4.texture = t4
							f4.MaxLabel:SetFont("Fonts\\FRIZQT__.TTF", tailleFontTextattack, "OUTLINE")
							
							if tailleicon == 32 then
								f4.MaxLabel:SetSize(70, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 90, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 30, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", -30, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -90, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 95)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 35)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, -35)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -95)
								end
							elseif tailleicon == 48 then
								f4.MaxLabel:SetSize(75, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 105, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 35, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", -35, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -105, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 110)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 40)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, -40)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -110)
								end
							else
								f4.MaxLabel:SetSize(80, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 135, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 45, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", -45, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -135, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 140)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 50)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, -50)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -140)
								end
							end
							
							if spell4 == 193356 then
								f4.MaxLabel:SetText("POINT COMBO X2")
							elseif spell4 == 193357 then
							
								if lang == "EN" then
									f4.MaxLabel:SetText("+25% CRITICAL")
								else
									f4.MaxLabel:SetText("+25% CRITIQUE")
								end
							elseif spell4 == 193358 then
								if lang == "EN" then
									f4.MaxLabel:SetText("+25% ATTACK SPEED")
								else
									f4.MaxLabel:SetText("+25% VITESSE ATTAQUE")
								end
							elseif spell4 == 199603 then
								if lang == "EN" then
									f4.MaxLabel:SetText("+25% SABER X2")
								else
									f4.MaxLabel:SetText("+25% SABRE X2")
								end
							elseif spell4 == 199600 then
								f4.MaxLabel:SetText("+25% REGEN")
							elseif spell4 == 193359 then
								if lang == "EN" then
									f4.MaxLabel:SetText("REDUCE COOLDOWN")
								else
									f4.MaxLabel:SetText("REDUIT COOLDOWN")
								end
							end
							
							if textAttackTop == true then
								f4.MaxLabel:ClearAllPoints();
								f4.MaxLabel:SetPoint("TOP", 0, 50)
							else
								f4.MaxLabel:ClearAllPoints();
								f4.MaxLabel:SetPoint("BOTTOM", 0, -50)
							end
							
							f4:Show()
							c4:Show()
							
							if textAttackIcons == true then
								f4.MaxLabel:Show()
							else
								f4.MaxLabel:Hide()
							end
							
							if tooltipcd == true then
								n4:SetText(dudu2)
								n4:Show()
							else
								n4:SetText("")
								n4:Hide()
							end
							CooldownFrame_Set(c4, expires-duration, duration, 1)
						elseif e == 5 then
							spell5 = spellID
							f6:Hide()
							t5:SetTexture(icone)
							f5.texture = t5
							f5.MaxLabel:SetFont("Fonts\\FRIZQT__.TTF", tailleFontTextattack, "OUTLINE")
							
							if tailleicon == 32 then
								f5.MaxLabel:SetSize(70, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 120, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 60, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -60, 0)
									f5:SetPoint("CENTER", frameWindow, "CENTER", -120, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 125)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 65)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -65)
									f5:SetPoint("CENTER", frameWindow, "CENTER", 0, -125)
								end
							elseif tailleicon == 48 then
								f5.MaxLabel:SetSize(75, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 140, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 70, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -70, 0)
									f5:SetPoint("CENTER", frameWindow, "CENTER", -140, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 145)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 75)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, 75)
									f5:SetPoint("CENTER", frameWindow, "CENTER", 0, -145)
								end
							else
								f5.MaxLabel:SetSize(80, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 180, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 90, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -90, 0)
									f5:SetPoint("CENTER", frameWindow, "CENTER", -180, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 185)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 95)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -95)
									f5:SetPoint("CENTER", frameWindow, "CENTER", 0, -185)
								end
							end
							
							if spell5 == 193356 then
								f5.MaxLabel:SetText("POINT COMBO X2")
							elseif spell5 == 193357 then
								
								if lang == "EN" then
									f5.MaxLabel:SetText("+25% CRITICAL")
								else
									f5.MaxLabel:SetText("+25% CRITIQUE")
								end
							elseif spell5 == 193358 then
								if lang == "EN" then
									f5.MaxLabel:SetText("+25% ATTACK SPEED")
								else
									f5.MaxLabel:SetText("+25% VITESSE ATTAQUE")
								end
							elseif spell5 == 199603 then
								if lang == "EN" then
									f5.MaxLabel:SetText("+25% SABER X2")
								else
									f5.MaxLabel:SetText("+25% SABRE X2")
								end
							elseif spell5 == 199600 then
								f5.MaxLabel:SetText("+25% REGEN")
							elseif spell5 == 193359 then
								if lang == "EN" then
									f5.MaxLabel:SetText("REDUCE COOLDOWN")
								else
									f5.MaxLabel:SetText("REDUIT COOLDOWN")
								end
							end
							
							if textAttackTop == true then
								f5.MaxLabel:ClearAllPoints();
								f5.MaxLabel:SetPoint("TOP", 0, 50)
							else
								f5.MaxLabel:ClearAllPoints();
								f5.MaxLabel:SetPoint("BOTTOM", 0, -50)
							end
							
							f5:Show()
							c5:Show()
							
							if textAttackIcons == true then
								f5.MaxLabel:Show()
							else
								f5.MaxLabel:Hide()
							end
							
							if tooltipcd == true then
								n5:SetText(dudu2)
								n5:Show()
							else
								n5:SetText("")
								n5:Hide()
							end
							CooldownFrame_Set(c5, expires-duration, duration, 1)
						elseif e == 6 then
							spell6 = spellID
							t6:SetTexture(icone)
							f6.texture = t6
							f6.MaxLabel:SetFont("Fonts\\FRIZQT__.TTF", tailleFontTextattack, "OUTLINE")
							
							if tailleicon == 32 then
								f6.MaxLabel:SetSize(70, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 150, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 90, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 30, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -30, 0)
									f5:SetPoint("CENTER", frameWindow, "CENTER", -90, 0)
									f6:SetPoint("CENTER", frameWindow, "CENTER", -150, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 155)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 95)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 35)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -35)
									f5:SetPoint("CENTER", frameWindow, "CENTER", 0, -95)
									f6:SetPoint("CENTER", frameWindow, "CENTER", 0, -155)

								end
							elseif tailleicon == 48 then
								f6.MaxLabel:SetSize(75, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 175, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 105, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 35, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -35, 0)
									f5:SetPoint("CENTER", frameWindow, "CENTER", -105, 0)
									f6:SetPoint("CENTER", frameWindow, "CENTER", -175, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 180)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 110)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 40)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -40)
									f5:SetPoint("CENTER", frameWindow, "CENTER", 0, -110)
									f6:SetPoint("CENTER", frameWindow, "CENTER", 0, -180)
								end
							else
								f6.MaxLabel:SetSize(80, 70)
								if(horizontaly) then
									f1:SetPoint("CENTER", frameWindow, "CENTER", 225, 0)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 135, 0)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 45, 0)
									f4:SetPoint("CENTER", frameWindow, "CENTER", -45, 0)
									f5:SetPoint("CENTER", frameWindow, "CENTER", -135, 0)
									f6:SetPoint("CENTER", frameWindow, "CENTER", -225, 0)
								else
									f1:SetPoint("CENTER", frameWindow, "CENTER", 0, 230)
									f2:SetPoint("CENTER", frameWindow, "CENTER", 0, 140)
									f3:SetPoint("CENTER", frameWindow, "CENTER", 0, 50)
									f4:SetPoint("CENTER", frameWindow, "CENTER", 0, -50)
									f5:SetPoint("CENTER", frameWindow, "CENTER", 0, -140)
									f6:SetPoint("CENTER", frameWindow, "CENTER", 0, -230)
								end
							end
							
							if spell6 == 193356 then
								
								f6.MaxLabel:SetText("POINT COMBO X2")
							elseif spell6 == 193357 then
								
								if lang == "EN" then
								
									f6.MaxLabel:SetText("+25% CRITICAL")
								else
									f6.MaxLabel:SetText("+25% CRITIQUE")
								end
							elseif spell6 == 193358 then
								
								if lang == "EN" then
									f6.MaxLabel:SetText("+25% ATTACK SPEED")
								else
									f6.MaxLabel:SetText("+25% VITESSE ATTAQUE")
								end
							elseif spell6 == 199603 then
								
								if lang == "EN" then
									f6.MaxLabel:SetText("+25% SABER X2")
								else
									f6.MaxLabel:SetText("+25% SABRE X2")
								end
							elseif spell6 == 199600 then
								
								f6.MaxLabel:SetText("+25% REGEN")
							elseif spell6 == 193359 then
								
								if lang == "EN" then
									f6.MaxLabel:SetText("REDUCE COOLDOWN")
								else
									f6.MaxLabel:SetText("REDUIT COOLDOWN")
								end
							end
							
							if textAttackTop == true then
								f6.MaxLabel:ClearAllPoints();
								f6.MaxLabel:SetPoint("TOP", 0, 50)
							else
								f6.MaxLabel:ClearAllPoints();
								f6.MaxLabel:SetPoint("BOTTOM", 0, -50)
							end
							
							f6:Show()
							c6:Show()
							
							if textAttackIcons == true then
								f6.MaxLabel:Show()
							else
								f6.MaxLabel:Hide()
							end
							
							if tooltipcd == true then
								n6:SetText(dudu2)
								n6:Show()
							else
								n6:SetText("")
								n6:Hide()
							end
							CooldownFrame_Set(c6, expires-duration, duration, 1)
						end
					end
				end
			end

-- start SOUND 
			if e == 2 then
				if ifsoundisplaying == false and soundPlay == true then 
					PlaySoundFile("Interface\\AddOns\\XRoll\\Sound\\breaker.mp3", "Master")
					ifsoundisplaying = true;
				end
				elseif e > 2 then
					if ifsoundisplaying == false and soundPlay == true then 
						PlaySoundFile("Interface\\AddOns\\XRoll\\Sound\\ultra.mp3", "Master")
						ifsoundisplaying = true;
					end
			end
-- end SOUND 			
						

	end
end
f:SetScript("OnUpdate",asd);






local buuffs = {
	["Bordées"] = true,
	["Broadsides"] = true,
	
	["Eaux infestées de requins"] = true,
	["Shark Infested Waters"] = true,
	
	["Grande mêlée"] = true,
	["Grand Melee"] = true,
	
	["Relèvement vrai"] = true,
	["True Bearing"] = true,
	
	["Trésor enfoui"] = true,
	["Buried Treasure"] = true,
	
	["Pavillon noir"] = true,
	["Jolly Roger"] = true,
}
     
local function CheckCooldowns()
    for bbuff in pairs(buuffs) do
        if UnitBuff("player", bbuff) then
            if buuffs[bbuff] then
				buuffs[bbuff] = false
            end
        else
            if not buuffs[bbuff] then
				f1:Hide()
				c1:Hide()
				f1.MaxLabel:Hide()
				f2:Hide()
				c2:Hide()
				f2.MaxLabel:Hide()
				f3:Hide()
				c3:Hide()
				f3.MaxLabel:Hide()
				f4:Hide()
				c4:Hide()
				f4.MaxLabel:Hide()
				f5:Hide()
				c5:Hide()
				f5.MaxLabel:Hide()
				f6:Hide()
				c6:Hide()
				f6.MaxLabel:Hide()
				ifsoundisplaying = false
            end
			buuffs[bbuff] = true
        end
    end
end

local framii = CreateFrame('Frame') 
framii:RegisterEvent("UNIT_AURA", "player");
framii:SetScript('OnUpdate', CheckCooldowns)



















local debuuffs = {
	["Malédiction des lames d’effroi"] = true,
	["Curse of the Dreadblades"] = true,
}

local framiidebuff = CreateFrame("Frame")
framiidebuff:RegisterEvent("UNIT_DEBUFF", "player");
framiidebuff:RegisterEvent("PLAYER_ENTERING_WORLD")

local function checkdebuff()
    if (unit and unit ~= "player") then
        return
    end
    for debbuff in pairs(debuuffs) do
        if UnitDebuff("player", debbuff) then
            if debuuffs[debbuff] then
				debuuffs[debbuff] = false
            end
        else
            if not debuuffs[debbuff] then
				f8:Hide()
				c8:Hide()
				f8.MaxLabel:Hide()
				ifsoundisplayingdebuff = false
            end
			debuuffs[debbuff] = true
        end
    end
    
end
framiidebuff:SetScript("OnUpdate",checkdebuff);













local IconImage = CreateFrame("FRAME", nil, XRollOption.panel)
IconImage:SetPoint("TOP", 0, -20)
IconImage:SetWidth(600)
IconImage:SetHeight(100)
IconImage:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }});
IconImage:SetBackdropColor(0,0,0,1);	

CreateFrame("Frame","Test",IconImage)
Test:SetWidth(180)
Test:SetHeight(66)
Test:SetPoint("TOPLEFT",10,-5)
Test:CreateTexture("TestTexture")
TestTexture:SetAllPoints()
TestTexture:SetTexture("Interface\\AddOns\\XRoll\\Textures\\XRoll_logo.tga")

local IconImageText = IconImage:CreateFontString()
IconImageText:SetPoint("LEFT", 0, -35)
IconImageText:SetSize(320, 20)
IconImageText:SetFont("Fonts\\FRIZQT__.TTF", 12)
IconImageText:SetText("XRoll v2.6 - Create By Ninvisible-Archimonde EU")
















--CHECKBOX FR/EN
frenchlg = CreateFrame("CheckButton", "frenchlg_GlobalName", IconImage, "ChatConfigCheckButtonTemplate");
frenchlg:SetPoint("RIGHT", -75, 10)
getglobal(frenchlg:GetName() .. 'Text'):SetText("FRENCH");
frenchlg:SetScript("OnClick", 
  function()
		isChecked = frenchlg:GetChecked()
		if isChecked == false then
			frenchlg:SetChecked(true)
		end
		englishlg:SetChecked(false)
		lang = "FR"
		DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Langue en Français!", 1, 1, .5);
		
		--TITRE LANGUAGE FRENCH
		TitreLockText:SetText("Bloque/Débloque la Bar XRoll")
		tooltipoCool.tooltip = "Affiche ou cache le cooldown sur les icônes";
		testattack.tooltip = "Affiche ou cache le nom des buffs.";
		tooltipon.tooltip = "Affiche ou cache les tooltips.";
		attackTop.tooltip = "Affiche le nom des buffs au-dessus des icônes.";
		attackBot.tooltip = "Affiche le nom des buffs au-dessous des icônes.";
		Soundplay.tooltip = "Active/Désactive les sons.";
		BarSens.tooltip = "Active/Désactive la Bar Horizontale.";
		getglobal(attackBot:GetName() .. 'Text'):SetText("(En bas)");
		getglobal(attackTop:GetName() .. 'Text'):SetText("(En haut)");
		getglobal(testattack:GetName() .. 'Text'):SetText("Nom des Buffs On/Off");
		
		XRollPosDB = {
			["language"] = lang
		}
  end
);
englishlg = CreateFrame("CheckButton", "englishlg_GlobalName", IconImage, "ChatConfigCheckButtonTemplate");
englishlg:SetPoint("RIGHT", -75, -10)
getglobal(englishlg:GetName() .. 'Text'):SetText("ENGLISH");
englishlg:SetScript("OnClick", 
  function()
		isChecked = englishlg:GetChecked()
		if isChecked == false then
			englishlg:SetChecked(true)
		end
		frenchlg:SetChecked(false)
		lang = "EN"
		DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Language is English!", 1, 1, .5);
		
		--TITRE LANGUAGE ENGLISH
		TitreLockText:SetText("Lock/Unlock Bar XRoll")
		tooltipoCool.tooltip = "Show or Hide Cooldown number of the icons";
		testattack.tooltip = "Show or Hide text name of the buff.";
		tooltipon.tooltip = "Show or Hide tooltip buff.";
		attackTop.tooltip = "Show Buffs text is TOP.";
		attackBot.tooltip = "Show Buffs text is BOTTOM.";
		Soundplay.tooltip = "Enable/Disable all sounds.";
		BarSens.tooltip = "Enable/Disable Horizontal Bar.";
		getglobal(attackBot:GetName() .. 'Text'):SetText("(Bottom)");
		getglobal(attackTop:GetName() .. 'Text'):SetText("(Top)");
		getglobal(testattack:GetName() .. 'Text'):SetText("Buffs name On/Off");
		
		XRollPosDB = {
			["language"] = lang
		}
  end
);























--TEXT OPTION LOCK/UNLOCK	
local TitreLock = CreateFrame("FRAME", nil, XRollOption.panel)
TitreLock:SetPoint("CENTER", 0, 0)
TitreLock:SetWidth(600)
TitreLock:SetHeight(100)
    
TitreLockText = TitreLock:CreateFontString()
TitreLockText:SetPoint("TOP", 0, -10)
TitreLockText:SetSize(250, 20)
TitreLockText:SetFont("Fonts\\FRIZQT__.TTF", 16)
TitreLockText:SetText("Lock/Unlock Bar XRoll")
TitreLock:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }});
TitreLock:SetBackdropColor(0,0,0,1);

--LOCK BTN OPTION
btnlock = CreateFrame("Button", "MyButton", TitreLock, "UIPanelButtonTemplate")
btnlock:SetSize(100 ,25)
btnlock:SetText("LOCK")
btnlock:SetPoint("CENTER", -100, -5)
btnlock:SetScript("OnClick", function()
	btnunlock:Enable()
    frameWindow:SetMovable(false)
	frameWindow:EnableMouse(false)
	tex:SetAlpha(0);
	lock = true
	if lang == "EN" then
		DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Bar lock!", 1, 1, .5);
	else
		DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Bar bloqué!", 1, 1, .5);
	end
	btnlock:Disable()
end)

--UNLOCK BTN OPTION
btnunlock = CreateFrame("Button", "MyButton", TitreLock, "UIPanelButtonTemplate")
btnunlock:SetSize(100 ,25)
btnunlock:SetText("UNLOCK")
btnunlock:SetPoint("CENTER", 100, -5)
btnunlock:SetScript("OnClick", function()
    btnlock:Enable()
	frameWindow:SetMovable(true)
	frameWindow:EnableMouse(true)
	tex:SetAlpha(0.5);
	lock = false
	if lang == "EN" then
		DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Bar unlock!", 1, 1, .5);
	else
		DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Bar débloqué!", 1, 1, .5);
	end
	btnunlock:Disable()
end)
btnunlock:Enable()
btnlock:Disable()



















--TEXT OPTION ICONS SIZE	
local TitreIconSize = CreateFrame("FRAME", nil, XRollOption.panel)
TitreIconSize:SetPoint("CENTER", 0, -110)
TitreIconSize:SetWidth(600)
TitreIconSize:SetHeight(100)
    
TitreIconSizeText = TitreIconSize:CreateFontString()
TitreIconSizeText:SetPoint("TOPLEFT", -50, -10)
TitreIconSizeText:SetSize(250, 20)
TitreIconSizeText:SetFont("Fonts\\FRIZQT__.TTF", 16)
TitreIconSizeText:SetText("Icons Size")
	
TitreIconSize:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }});
TitreIconSize:SetBackdropColor(0,0,0,1);	
	
local fra = CreateFrame("Slider", nil, TitreIconSize)
fra:SetPoint("LEFT", 25, -5)
fra:SetSize(200, 17)
fra:EnableMouseWheel(true)
fra:SetHitRectInsets(0, 0, -14, -15)
fra:SetMinMaxValues(0, 100)
fra:SetValue(50)
fra:SetValueStep(50)
fra:SetHitRectInsets(0, 0, 0, 0)
fra:SetObeyStepOnDrag(true)
fra:EnableMouseWheel(true)
fra:SetOrientation("Horizontal")
fra:SetBackdrop({
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		tile = true,
		edgeSize = 8,
		tileSize = 8,
		insets = {left = 3, right = 3, top = 6, bottom = 6}
})
fra:SetBackdropBorderColor(0.7, 0.7, 0.7, 1.0)
fra:SetScript("OnEnter", function(self)
	self:SetBackdropBorderColor(1, 1, 1, 1)
end)
fra:SetScript("OnLeave", function(self)
	self:SetBackdropBorderColor(0.7, 0.7, 0.7, 1.0)
end)
fra:SetScript("OnMouseWheel", function(self, delta)
	if delta > 0 then
		self:SetValue(self:GetValue() + self:GetValueStep())
	else
		self:SetValue(self:GetValue() - self:GetValueStep())
	end
end)
fra:SetScript("OnValueChanged", function(self, value)
	--fra.EditBox:SetText(value)
	if value == 0 then
		tailleicon = 32
		if(horizontaly)then
			frameWindow:SetWidth(250);
			frameWindow:SetHeight(64);
			FrameWidth = 250
			FrameHeight = 64
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
			}
		else
			frameWindow:SetWidth(64);
			frameWindow:SetHeight(250);
			FrameWidth = 64
			FrameHeight = 250
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}
		end
		f1:SetWidth(tailleicon)
		f1:SetHeight(tailleicon)
		f2:SetWidth(tailleicon)
		f2:SetHeight(tailleicon)
		f3:SetWidth(tailleicon)
		f3:SetHeight(tailleicon)
		f4:SetWidth(tailleicon)
		f4:SetHeight(tailleicon)
		f5:SetWidth(tailleicon)
		f5:SetHeight(tailleicon)
		f6:SetWidth(tailleicon)
		f6:SetHeight(tailleicon)
		f7:SetWidth(tailleicon)
		f7:SetHeight(tailleicon)
		fra:SetValue(0)
		tailleFontTextattack = 8
	elseif value == 50 then
		tailleicon = 48
		if(horizontaly)then
			frameWindow:SetWidth(350);
			frameWindow:SetHeight(72);
			FrameWidth = 350
			FrameHeight = 72
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}
		else
			frameWindow:SetWidth(72);
			frameWindow:SetHeight(350);
			FrameWidth = 72
			FrameHeight = 350
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}

		end
		f1:SetWidth(tailleicon)
		f1:SetHeight(tailleicon)
		f2:SetWidth(tailleicon)
		f2:SetHeight(tailleicon)
		f3:SetWidth(tailleicon)
		f3:SetHeight(tailleicon)
		f4:SetWidth(tailleicon)
		f4:SetHeight(tailleicon)
		f5:SetWidth(tailleicon)
		f5:SetHeight(tailleicon)
		f6:SetWidth(tailleicon)
		f6:SetHeight(tailleicon)
		f7:SetWidth(tailleicon)
		f7:SetHeight(tailleicon)
		fra:SetValue(50)
		tailleFontTextattack = 10
	else
		tailleicon = 64
		if(horizontaly)then
			frameWindow:SetWidth(450);
			frameWindow:SetHeight(80);
			FrameWidth = 450
			FrameHeight = 80
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}
		else
			frameWindow:SetWidth(80);
			frameWindow:SetHeight(450);
			FrameWidth = 80
			FrameHeight = 450
			XRollPosDB = {
				["FrameWidth"] = FrameWidth,
				["FrameHeight"] = FrameHeight,
				["tailleicon"] = tailleicon,
			}

		end
		f1:SetWidth(tailleicon)
		f1:SetHeight(tailleicon)
		f2:SetWidth(tailleicon)
		f2:SetHeight(tailleicon)
		f3:SetWidth(tailleicon)
		f3:SetHeight(tailleicon)
		f4:SetWidth(tailleicon)
		f4:SetHeight(tailleicon)
		f5:SetWidth(tailleicon)
		f5:SetHeight(tailleicon)
		f6:SetWidth(tailleicon)
		f6:SetHeight(tailleicon)
		f7:SetWidth(tailleicon)
		f7:SetHeight(tailleicon)
		fra:SetValue(100)
		tailleFontTextattack = 11
	end
end)
		
fra.MinLabel = fra:CreateFontString(nil, "Overlay")
fra.MinLabel:SetFontObject(GameFontHighlightSmall)
fra.MinLabel:SetSize(0, 14)
fra.MinLabel:SetWordWrap(false)
fra.MinLabel:SetPoint("TopLeft", fra, "BottomLeft", 0, -1)
local min, max = fra:GetMinMaxValues()
fra.MinLabel:SetText("32x32")
		
fraCenterLabel = fra:CreateFontString(nil, "Overlay")
fraCenterLabel:SetFontObject(GameFontHighlightSmall)
fraCenterLabel:SetSize(0, 14)
fraCenterLabel:SetWordWrap(false)
fraCenterLabel:SetPoint("TOP", fra, "BOTTOM", 0, 0)
fraCenterLabel:SetText("48x48")
		
fra.MaxLabel = fra:CreateFontString(nil, "Overlay")
fra.MaxLabel:SetFontObject(GameFontHighlightSmall)
fra.MaxLabel:SetSize(0, 14)
fra.MaxLabel:SetWordWrap(false)
fra.MaxLabel:SetPoint("TopRight", fra, "BottomRight", 0, -1)
fra.MaxLabel:SetText("64x64")
		
fra.Title = fra:CreateFontString(nil, "Overlay")
fra.Title:SetFontObject(GameFontNormal)
fra.Title:SetSize(0, 14)
fra.Title:SetWordWrap(false)
fra.Title:SetPoint("Bottom", fra, "Top")
fra.Title:SetText("")
fra.Thumb = fra:CreateTexture(nil, "Artwork")
fra.Thumb:SetSize(32, 32)
fra.Thumb:SetTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
fra:SetThumbTexture(fra.Thumb)


















--TEXT OPTION FONT SIZE	
TitreFontSizeText = TitreIconSize:CreateFontString()
TitreFontSizeText:SetPoint("TOP", 115, -10)
TitreFontSizeText:SetSize(250, 20)
TitreFontSizeText:SetFont("Fonts\\FRIZQT__.TTF", 16)
TitreFontSizeText:SetText("Font Size")
	
	
local fra2 = CreateFrame("Slider", nil, TitreIconSize)
fra2:SetPoint("RIGHT", -25, -5)
fra2:SetSize(200, 17)
fra2:EnableMouseWheel(true)
fra2:SetHitRectInsets(0, 0, -14, -15)
fra2:SetMinMaxValues(0, 100)
fra2:SetValue(50)
fra2:SetValueStep(50)
fra2:SetHitRectInsets(0, 0, 0, 0)
fra2:SetObeyStepOnDrag(true)
fra2:EnableMouseWheel(true)
fra2:SetOrientation("Horizontal")
fra2:SetBackdrop({
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		tile = true,
		edgeSize = 8,
		tileSize = 8,
		insets = {left = 3, right = 3, top = 6, bottom = 6}
})
fra2:SetBackdropBorderColor(0.7, 0.7, 0.7, 1.0)
fra2:SetScript("OnEnter", function(self)
	self:SetBackdropBorderColor(1, 1, 1, 1)
end)
fra2:SetScript("OnLeave", function(self)
	self:SetBackdropBorderColor(0.7, 0.7, 0.7, 1.0)
end)
fra2:SetScript("OnMouseWheel", function(self, delta)
	if delta > 0 then
		self:SetValue(self:GetValue() + self:GetValueStep())
	else
		self:SetValue(self:GetValue() - self:GetValueStep())
	end
end)
fra2:SetScript("OnValueChanged", function(self, value)
	--fra.EditBox:SetText(value)
	if value == 0 then
		fontSize = 15
		fra2:SetValue(0)
		n1:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		n2:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		n3:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		n4:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		n5:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		n6:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		n7:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
	elseif value == 50 then
		fontSize = 20
		fra2:SetValue(50)
		n1:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
		n2:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
		n3:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
		n4:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
		n5:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
		n6:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
		n7:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
	else
		fontSize = 25
		fra2:SetValue(100)
		n1:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
		n2:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
		n3:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
		n4:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
		n5:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
		n6:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
		n7:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
	end
	XRollPosDB = {
		["FontSize"] = fontSize
	}
end)
		
fra2.MinLabel = fra2:CreateFontString(nil, "Overlay")
fra2.MinLabel:SetFontObject(GameFontHighlightSmall)
fra2.MinLabel:SetSize(0, 14)
fra2.MinLabel:SetWordWrap(false)
fra2.MinLabel:SetPoint("TopLeft", fra2, "BottomLeft", 0, -1)
local min, max = fra2:GetMinMaxValues()
fra2.MinLabel:SetText("15")
		
fra2CenterLabel = fra2:CreateFontString(nil, "Overlay")
fra2CenterLabel:SetFontObject(GameFontHighlightSmall)
fra2CenterLabel:SetSize(0, 14)
fra2CenterLabel:SetWordWrap(false)
fra2CenterLabel:SetPoint("TOP", fra2, "BOTTOM", 0, 0)
fra2CenterLabel:SetText("20")
		
fra2.MaxLabel = fra2:CreateFontString(nil, "Overlay")
fra2.MaxLabel:SetFontObject(GameFontHighlightSmall)
fra2.MaxLabel:SetSize(0, 14)
fra2.MaxLabel:SetWordWrap(false)
fra2.MaxLabel:SetPoint("TopRight", fra2, "BottomRight", 0, -1)
fra2.MaxLabel:SetText("25")
		
fra2.Title = fra2:CreateFontString(nil, "Overlay")
fra2.Title:SetFontObject(GameFontNormal)
fra2.Title:SetSize(0, 14)
fra2.Title:SetWordWrap(false)
fra2.Title:SetPoint("Bottom", fra2, "Top")
fra2.Title:SetText("")
fra2.Thumb = fra2:CreateTexture(nil, "Artwork")
fra2.Thumb:SetSize(32, 32)
fra2.Thumb:SetTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
fra2:SetThumbTexture(fra2.Thumb)






















--TEXT OPTION TOOLTIP	
local TitreTool = CreateFrame("FRAME", nil, XRollOption.panel)
TitreTool:SetPoint("CENTER", 0, -220)
TitreTool:SetWidth(600)
TitreTool:SetHeight(100)
    
local TitreToolText = TitreTool:CreateFontString()
TitreToolText:SetPoint("TOPLEFT", -35, -10)
TitreToolText:SetSize(250, 20)
TitreToolText:SetFont("Fonts\\FRIZQT__.TTF", 16)
--TitreToolText:SetText("Tooltip On/Off")

TitreTool:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }});
TitreTool:SetBackdropColor(0,0,0,1);

tooltipon = CreateFrame("CheckButton", "tooltipon_GlobalName", TitreTool, "ChatConfigCheckButtonTemplate");
tooltipon:SetPoint("LEFT", 25, 10)
getglobal(tooltipon:GetName() .. 'Text'):SetText("Tooltip On/Off");
--tooltipon.tooltip = "Show or Hide tooltip buff.";
tooltipon:SetScript("OnClick", 
  function()
		isChecked = tooltipon:GetChecked()
		if isChecked == false then
			iftooltip = false
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Tooltip is OFF!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Tooltip désactivé!", 1, 1, .5);
			end
		else
			iftooltip = true
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Tooltip is On!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Tooltip activé!", 1, 1, .5);
			end
		end
		XRollPosDB = {
			["iftooltip"] = iftooltip,
		}
  end
);



















--TEXT OPTION SOUNDPLAY	
Soundplay = CreateFrame("CheckButton", "Soundplay_GlobalName", TitreTool, "ChatConfigCheckButtonTemplate");
Soundplay:SetPoint("LEFT", 25, -15)
getglobal(Soundplay:GetName() .. 'Text'):SetText("Sounds On/Off");
--Soundplay.tooltip = "Show or Hide tooltip buff.";
Soundplay:SetScript("OnClick", 
  function()
		isChecked = Soundplay:GetChecked()
		if isChecked == false then
			soundPlay = false
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : All Sounds is OFF!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Tout les Sons désactivé!", 1, 1, .5);
			end
		else
			soundPlay = true
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : All Sounds is On!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Tout les Sons activé!", 1, 1, .5);
			end
		end
		XRollPosDB = {
			["soundPlay"] = soundPlay,
		}
  end
);




















--TEXT ON/OFF ATTACKS NAMES
local testattackText = TitreTool:CreateFontString()
testattackText:SetPoint("TOP", 0, -10)
testattackText:SetSize(250, 20)
testattackText:SetFont("Fonts\\FRIZQT__.TTF", 16)
--testattackText:SetText("Attack name On/Off")

testattack = CreateFrame("CheckButton", "testattack_GlobalName", TitreTool, "ChatConfigCheckButtonTemplate");
testattack:SetPoint("CENTER", -50, 10)
getglobal(testattack:GetName() .. 'Text'):SetText("Buff name On/Off");
--testattack.tooltip = "Show or Hide text name of the buff.";
testattack:SetScript("OnClick", 
	function()
		isChecked = testattack:GetChecked()
		if isChecked == false then
			textAttackIcons = false
			attackBot:Disable();
			attackTop:Disable();
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Buffs names is Off!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Nom des Buffs désactivé!", 1, 1, .5);
			end
		else
			textAttackIcons = true
			attackBot:Enable();
			attackTop:Enable();
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Buffs names is On!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Nom des Buffs activé!", 1, 1, .5);
			end
		end
		XRollPosDB = {
			["textAttackIcons"] = textAttackIcons,
		}
  end
);



























--TEXT TOP/BOTTOM BUFFS NAMES
local attackTextTop = TitreTool:CreateFontString()
attackTextTop:SetPoint("TOP", 0, -10)
attackTextTop:SetSize(100, 20)
attackTextTop:SetFont("Fonts\\FRIZQT__.TTF", 16)
--testattackText:SetText("Attack name On/Off")

attackTop = CreateFrame("CheckButton", "attackTop_GlobalName", TitreTool, "ChatConfigCheckButtonTemplate");
attackTop:SetPoint("CENTER", -25, -10)
getglobal(attackTop:GetName() .. 'Text'):SetText("(Top)");
--testattack.tooltip = "Show or Hide text name of the buff.";
attackTop:SetScript("OnClick", 
	function()
		isChecked = attackTop:GetChecked()
		if isChecked == false then
			attackTop:SetChecked(true);
		end
		attackBot:SetChecked(false);
		textAttackTop = true
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Buffs Text is Top!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Nom des Buffs en haut!", 1, 1, .5);
		end
		XRollPosDB = {
			["textAttackTop"] = textAttackTop,
		}
  end
);

attackBot = CreateFrame("CheckButton", "attackBot_GlobalName", TitreTool, "ChatConfigCheckButtonTemplate");
attackBot:SetPoint("CENTER", -25, -25)
getglobal(attackBot:GetName() .. 'Text'):SetText("(Bottom)");
--testattack.tooltip = "Show or Hide text name of the buff.";
attackBot:SetScript("OnClick", 
	function()
		isChecked = attackBot:GetChecked()
		if isChecked == false then
			attackBot:SetChecked(true);
		end
		attackTop:SetChecked(false);
		textAttackTop = false
		if lang == "EN" then
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Buffs Text is Bottom!", 1, 1, .5);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Nom des Buffs en bas!", 1, 1, .5);
		end
		XRollPosDB = {
			["textAttackTop"] = textAttackTop,
		}
  end
);


































--TEXT OPTION COOLDOWN OFF/ON
local TitrecdText = TitreTool:CreateFontString()
TitrecdText:SetPoint("TOP", 190, -10)
TitrecdText:SetSize(250, 20)
TitrecdText:SetFont("Fonts\\FRIZQT__.TTF", 16)
--TitrecdText:SetText("CoolDown On/Off")

tooltipoCool = CreateFrame("CheckButton", "tooltipoCool_GlobalName", TitreTool, "ChatConfigCheckButtonTemplate");
tooltipoCool:SetPoint("RIGHT", -145, 10)
getglobal(tooltipoCool:GetName() .. 'Text'):SetText("Cooldown On/Off");
--tooltipoCool.tooltip = "Show or Hide Cooldown number of the icons";
tooltipoCool:SetScript("OnClick", 
  function()
		CoolisChecked = tooltipoCool:GetChecked()
		if CoolisChecked == false then
			tooltipcd = false
			n7:Hide()
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Cooldown is Off!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Cooldown désactivé!", 1, 1, .5);
			end
		else
			tooltipcd = true
			n7:Show()
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : Cooldown is On!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : Cooldown activé!", 1, 1, .5);
			end
		end
		XRollPosDB = {
			["Cooldownn"] = tooltipcd,
		}
  end
);

















--TEXT OPTION HORIZONTALY
local TitreSensText = TitreTool:CreateFontString()
TitreSensText:SetPoint("TOP", 190, -10)
TitreSensText:SetSize(250, 20)
TitreSensText:SetFont("Fonts\\FRIZQT__.TTF", 16)
--TitrecdText:SetText("CoolDown On/Off")

BarSens = CreateFrame("CheckButton", "BarSens_GlobalName", TitreTool, "ChatConfigCheckButtonTemplate");
BarSens:SetPoint("RIGHT", -145, -15)
getglobal(BarSens:GetName() .. 'Text'):SetText("Bar Horizontal On/Off");
--tooltipoCool.tooltip = "Show or Hide Cooldown number of the icons";
BarSens:SetScript("OnClick", 
  function()
		BarSensisChecked = BarSens:GetChecked()
		if BarSensisChecked == false then
			horizontaly = false
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : The Bar is Vertical!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : La Bar est Verticale!", 1, 1, .5);
			end
			if tailleicon == 32 then
				frameWindow:SetWidth(64);
				frameWindow:SetHeight(250);
				FrameWidth = 64
				FrameHeight = 250
				XRollPosDB = {
					["FrameWidth"] = FrameWidth,
					["FrameHeight"] = FrameHeight,
					["tailleicon"] = tailleicon,
				}
			elseif tailleicon == 48 then
				frameWindow:SetWidth(72);
				frameWindow:SetHeight(350);
				FrameWidth = 72
				FrameHeight = 350
				XRollPosDB = {
					["FrameWidth"] = FrameWidth,
					["FrameHeight"] = FrameHeight,
					["tailleicon"] = tailleicon,
				}
			else
				frameWindow:SetWidth(80);
				frameWindow:SetHeight(450);
				FrameWidth = 80
				FrameHeight = 450
				XRollPosDB = {
					["FrameWidth"] = FrameWidth,
					["FrameHeight"] = FrameHeight,
					["tailleicon"] = tailleicon,
				}
			end
		else
			horizontaly = true
			if lang == "EN" then
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] say : The Bar is Horizontal!", 1, 1, .5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("[XRoll] dit : La Bar est Horizontale!", 1, 1, .5);
			end
			if tailleicon == 32 then
				frameWindow:SetWidth(250);
				frameWindow:SetHeight(64);
				FrameWidth = 250
				FrameHeight = 64
				XRollPosDB = {
					["FrameWidth"] = FrameWidth,
					["FrameHeight"] = FrameHeight,
					["tailleicon"] = tailleicon,
				}
			elseif tailleicon == 48 then
				frameWindow:SetWidth(350);
				frameWindow:SetHeight(72);
				FrameWidth = 350
				FrameHeight = 72
				XRollPosDB = {
					["FrameWidth"] = FrameWidth,
					["FrameHeight"] = FrameHeight,
					["tailleicon"] = tailleicon,
				}
			else
				frameWindow:SetWidth(450);
				frameWindow:SetHeight(80);
				FrameWidth = 450
				FrameHeight = 80
				XRollPosDB = {
					["FrameWidth"] = FrameWidth,
					["FrameHeight"] = FrameHeight,
					["tailleicon"] = tailleicon,
				}
			end
		end
		XRollPosDB = {
			["horizontaly"] = horizontaly,
		}
  end
);


































--BUTTON EXAMPLE OPTION
local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(193356)
f7 = CreateFrame("FRAME",nil, XRollOption.panel)
f7:SetFrameStrata("BACKGROUND")
f7:SetWidth(tailleicon) -- Set these to whatever height/width is needed 
f7:SetHeight(tailleicon) -- for your Texture
f7:SetPoint("CENTER", -200, 100)
t7 = f7:CreateTexture("$parentIcon","BACKGROUND")
t7:SetAllPoints(f7)
t7:SetTexture(icon)
n7 = f7:CreateFontString(nil, "OVERLAY")
n7:SetFont("Fonts\\FRIZQT__.TTF", fontSize, "OUTLINE")
n7:SetTextColor(0.8, 0.8, 0.8)
n7:SetPoint("CENTER", -1, 1)
n7:SetJustifyH("CENTER")
n7:SetText(19)
f7:Show()
n7:Show()





local XRoll_eventFrame = CreateFrame("Frame", nil, UIParent)
XRoll_eventFrame:RegisterEvent("PLAYER_LOGOUT")
XRoll_eventFrame:RegisterEvent("PLAYER_LOGIN")
XRoll_eventFrame:SetScript("OnEvent",function(self,event,...) 
	self[event](self,event,...);
end)

local XRoll_eventFrame2 = CreateFrame("Frame", nil, UIParent)
XRoll_eventFrame2:RegisterEvent("PLAYER_LOGIN")
XRoll_eventFrame2:SetScript("OnEvent", function(self,event,...) 
	if type(XRollPosDB) ~= "table" then
		XRollPosDB = {
			["Posx"] = posX,
			["PosY"] = posY,
			["CENTER"] = posPoint,
			["iftooltip"] = iftooltip,
			["tailleicon"] = tailleicon,
			["FrameWidth"] = FrameWidth,
			["FrameHeight"] = FrameHeight,
			["lockbar"] = lock,
			["FontSize"] = fontSize,
			["Cooldownn"] = tooltipcd,
			["language"] = lang,
			["textAttackIcons"] = textAttackIcons,
			["textAttackTop"] = textAttackTop,
			["soundPlay"] = soundPlay,
			["horizontaly"] = horizontaly,
		}
		ADDON_APPLY();
	else
		posPoint = XRollPosDB["CENTER"];
		posX = XRollPosDB["Posx"];
		posY = XRollPosDB["PosY"];
		FrameWidth = XRollPosDB["FrameWidth"];
		FrameHeight = XRollPosDB["FrameHeight"];
		iftooltip = XRollPosDB["iftooltip"];
		tailleicon = XRollPosDB["tailleicon"];
		FrameWidth = XRollPosDB["FrameWidth"];
		FrameHeight = XRollPosDB["FrameHeight"];
		fontSize = XRollPosDB["FontSize"];
		tooltipcd = XRollPosDB["Cooldownn"];
		lang = XRollPosDB["language"];
		textAttackIcons = XRollPosDB["textAttackIcons"];
		textAttackTop = XRollPosDB["textAttackTop"];
		soundPlay = XRollPosDB["soundPlay"];
		horizontaly = XRollPosDB["horizontaly"];
		ADDON_APPLY();
	end
end)

function XRoll_eventFrame:PLAYER_LOGIN()
	DEFAULT_CHAT_FRAME:AddMessage("XRoll v2.6 loaded:  /xr help", 1, 1, .5);
	DEFAULT_CHAT_FRAME:AddMessage("Create by Ninvisible-Archimonde EU", 1, 1, .5);
end


function ADDON_APPLY()
		frameWindow:SetPoint(posPoint, posX, posY)
		frameWindow:SetWidth(FrameWidth);
		frameWindow:SetHeight(FrameHeight);
		f1:SetWidth(tailleicon)
		f1:SetHeight(tailleicon)
		f2:SetWidth(tailleicon)
		f2:SetHeight(tailleicon)
		f3:SetWidth(tailleicon)
		f3:SetHeight(tailleicon)
		f4:SetWidth(tailleicon)
		f4:SetHeight(tailleicon)
		f5:SetWidth(tailleicon)
		f5:SetHeight(tailleicon)
		f6:SetWidth(tailleicon)
		f6:SetHeight(tailleicon)
		f7:SetWidth(tailleicon)
		f7:SetHeight(tailleicon)
		btnunlock:Enable()
		btnlock:Disable()
		if horizontaly == true then
			BarSens:SetChecked(true)
		elseif horizontaly == false then
			BarSens:SetChecked(false)
		end
		
		if soundPlay == true then
			Soundplay:SetChecked(true)
		else
			Soundplay:SetChecked(false)
		end
		if tailleicon == 32 then
			fra:SetValue(0)
			tailleFontTextattack = 8
			if(horizontaly)then
				frameWindow:SetWidth(250);
				frameWindow:SetHeight(64);
				FrameWidth = 250
				FrameHeight = 64
			else
				frameWindow:SetWidth(64);
				frameWindow:SetHeight(250);
				FrameWidth = 64
				FrameHeight = 250
			end
		elseif tailleicon == 48 then
			fra:SetValue(50)
			tailleFontTextattack = 10
			if(horizontaly)then
				frameWindow:SetWidth(350);
				frameWindow:SetHeight(72);
				FrameWidth = 350
				FrameHeight = 72
			else
				frameWindow:SetWidth(72);
				frameWindow:SetHeight(350);
				FrameWidth = 72
				FrameHeight = 350
			end
		else
			fra:SetValue(100)
			tailleFontTextattack = 11
			if(horizontaly)then
				frameWindow:SetWidth(450);
				frameWindow:SetHeight(80);
				FrameWidth = 450
				FrameHeight = 80
			else
				frameWindow:SetWidth(80);
				frameWindow:SetHeight(450);
				FrameWidth = 80
				FrameHeight = 450
			end
		end
		
		if iftooltip == true then
			tooltipon:SetChecked(true)
		else
			tooltipon:SetChecked(false)
		end
		
		if textAttackIcons == true then
			testattack:SetChecked(true)
			attackBot:Enable();
			attackTop:Enable();
		else
			testattack:SetChecked(false)
			attackBot:Disable();
			attackTop:Disable();
		end
		
		if fontSize == 15 then
			fra2:SetValue(0)
			n1:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
			n2:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
			n3:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
			n4:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
			n5:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
			n6:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
			n7:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE")
		elseif fontSize == 20 then
			fra2:SetValue(50)
			n1:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
			n2:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
			n3:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
			n4:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
			n5:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
			n6:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
			n7:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
		else
			fra2:SetValue(100)
			n1:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
			n2:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
			n3:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
			n4:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
			n5:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
			n6:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
			n7:SetFont("Fonts\\FRIZQT__.TTF", 25, "OUTLINE")
		end
		
		if tooltipcd == true then
			tooltipoCool:SetChecked(true)
			n7:Show()
		else
			tooltipoCool:SetChecked(false)
			n7:Hide()
		end
		
		if lang == "FR" then
			frenchlg:SetChecked(true)
			englishlg:SetChecked(false)
			TitreLockText:SetText("Bloque/Débloque la Bar XRoll")
			tooltipoCool.tooltip = "Affiche ou cache le cooldown sur les icônes";
			testattack.tooltip = "Affiche ou cache le nom des buffs.";
			tooltipon.tooltip = "Affiche ou cache les tooltips.";
			attackTop.tooltip = "Affiche le nom des buffs au-dessus des icônes.";
			attackBot.tooltip = "Affiche le nom des buffs au-dessous des icônes.";
			Soundplay.tooltip = "Active/Désactive les sons.";
			BarSens.tooltip = "Active/Désactive la Bar Horizontale.";
			getglobal(attackBot:GetName() .. 'Text'):SetText("(En bas)");
			getglobal(attackTop:GetName() .. 'Text'):SetText("(En haut)");
			getglobal(testattack:GetName() .. 'Text'):SetText("Nom des Buffs On/Off");
		else
			frenchlg:SetChecked(false)
			englishlg:SetChecked(true)
			TitreLockText:SetText("Lock/Unlock Bar XRoll")
			tooltipoCool.tooltip = "Show or Hide Cooldown number of the icons";
			testattack.tooltip = "Show or Hide text name of the buff.";
			tooltipon.tooltip = "Show or Hide tooltip buff.";
			attackTop.tooltip = "Show Buffs text is TOP.";
			attackBot.tooltip = "Show Buffs text is BOTTOM.";
			Soundplay.tooltip = "Enable/Disable all sounds.";
			BarSens.tooltip = "Enable/Disable Horizontal Bar.";
			getglobal(attackBot:GetName() .. 'Text'):SetText("(Bottom)");
			getglobal(attackTop:GetName() .. 'Text'):SetText("(Top)");
			getglobal(testattack:GetName() .. 'Text'):SetText("Buffs name On/Off");
		end
		if textAttackTop == true then
			attackTop:SetChecked(true)
			attackBot:SetChecked(false)
		else
			attackTop:SetChecked(false)
			attackBot:SetChecked(true)
		end
end

local XRoll_eventFrame3 = CreateFrame("Frame", nil, UIParent)
XRoll_eventFrame3:RegisterEvent("PLAYER_LOGOUT")
XRoll_eventFrame3:SetScript("OnEvent", function(self,event,...) 
	XRollPosDB = {
		["Posx"] = posX,
		["PosY"] = posY,
		["CENTER"] = posPoint,
		["iftooltip"] = iftooltip,
		["tailleicon"] = tailleicon,
		["FrameWidth"] = FrameWidth,
		["FrameHeight"] = FrameHeight,
		["lockbar"] = lock,
		["FontSize"] = fontSize,
		["Cooldownn"] = tooltipcd,
		["language"] = lang,
		["textAttackIcons"] = textAttackIcons,
		["textAttackTop"] = textAttackTop,
		["soundPlay"] = soundPlay,
		["horizontaly"] = horizontaly,
	}
end)

local function OnEnter1(self, motion)
GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
name = GetSpellInfo(spell1)
GameTooltip:SetText(name) 
GameTooltip:AddLine(GetSpellDescription(spell1), 1, 1, 1, true)
	if iftooltip == true then
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end
local function OnEnter2(self, motion)
GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
name = GetSpellInfo(spell2)
GameTooltip:SetText(name) 
GameTooltip:AddLine(GetSpellDescription(spell2), 1, 1, 1, true)
	if iftooltip == true then
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end
local function OnEnter3(self, motion)
GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
name = GetSpellInfo(spell3)
GameTooltip:SetText(name) 
GameTooltip:AddLine(GetSpellDescription(spell3), 1, 1, 1, true)
	if iftooltip == true then
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end
local function OnEnter4(self, motion)
GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
name = GetSpellInfo(spell4)
GameTooltip:SetText(name) 
GameTooltip:AddLine(GetSpellDescription(spell4), 1, 1, 1, true)
	if iftooltip == true then
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end
local function OnEnter5(self, motion)
GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
name = GetSpellInfo(spell5)
GameTooltip:SetText(name) 
GameTooltip:AddLine(GetSpellDescription(spell5), 1, 1, 1, true)
	if iftooltip == true then
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end
local function OnEnter6(self, motion)
GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
name = GetSpellInfo(spell6)
GameTooltip:SetText(name) 
GameTooltip:AddLine(GetSpellDescription(spell6), 1, 1, 1, true)
	if iftooltip == true then
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end
local function OnEnter7(self, motion)
GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
name = GetSpellInfo(193356)
GameTooltip:SetText(name) 
GameTooltip:AddLine(GetSpellDescription(193356), 1, 1, 1, true)
	if iftooltip == true then
		GameTooltip:Show()
	else
		GameTooltip:Hide()
	end
end

f1:SetScript("OnEnter", OnEnter1)
f2:SetScript("OnEnter", OnEnter2)
f3:SetScript("OnEnter", OnEnter3)
f4:SetScript("OnEnter", OnEnter4)
f5:SetScript("OnEnter", OnEnter5)
f6:SetScript("OnEnter", OnEnter6)
f7:SetScript("OnEnter", OnEnter7)

local function OnLeave()
GameTooltip:Hide()
end

f1:SetScript("OnLeave", OnLeave) 
f2:SetScript("OnLeave", OnLeave) 
f3:SetScript("OnLeave", OnLeave) 
f4:SetScript("OnLeave", OnLeave) 
f5:SetScript("OnLeave", OnLeave) 
f6:SetScript("OnLeave", OnLeave) 
f7:SetScript("OnLeave", OnLeave)


