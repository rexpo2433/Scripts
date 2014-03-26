--ĞŸĞ¾Ğ´ĞºĞ»ÑÑ‡ĞµĞ½Ğ¸Ğµ Ğ±Ğ¸Ğ±Ğ»Ğ¸Ğ¾Ñ‚ĞµĞºĞ¸
require("libs.Utils")

--ÑĞ¾Ğ·Ğ´Ğ°ĞµĞ¼ Ñ‚Ğ°Ğ±Ğ»Ğ¸Ñ†Ñƒ
hero = {}

--Ğ¨Ñ€Ğ¸Ñ„Ñ‚
F16 = drawMgr:CreateFont("F16","Arial",16,500)

--Ğ¢Ğ°Ğ±Ğ»Ğ¸Ñ†Ñ‹ ÑƒÑ€Ğ¾Ğ½Ğ°
dmgL = {80,160,240,320}
dmgR = {100,175,250,325}
dmg = {400,500,600,700,800}

--Ğ“Ğ»Ğ°Ğ²Ğ½Ğ°Ñ Ñ„ÑƒĞ½ĞºÑ†Ğ¸Ñ
function Frame( tick )

-- ĞŸÑ€Ğ¾Ğ²ĞµÑ€ĞºĞ° Ğ¸Ğ³Ñ€Ğ°ĞµĞ¼ Ğ»Ğ¸ Ğ¼Ñ‹
	if not client.connected or client.loading or client.console or not entityList:GetMyHero() or not SleepCheck() then return end
	
-- ĞœĞ¾Ğ¹ Ğ³ĞµÑ€Ğ¾Ğ¹

	me = entityList:GetMyHero() 
	
-- ĞŸÑ€Ğ¾Ğ²ĞµÑ€ĞºĞ° Ğ½Ğ° Ğ³ĞµÑ€Ğ¾Ñ
	if me.name ~= "npc_dota_hero_tinker" then		
		return
	end

-- ĞŸĞ¾Ğ·Ğ¸Ñ†Ğ¸Ñ ÑĞºÑ€Ğ°Ğ½Ğ° Ğ¸ Ğ½Ğ°Ğ·Ğ½Ğ°Ñ‡ĞµĞ½Ğ¸Ñ ÑĞºĞ¸Ğ»Ğ¾Ğ²
	local laser = me:GetAbility(1)
	local rocket = me:GetAbility(2)
	
-- ĞŸÑ€Ğ¾Ğ²ĞµÑ€ĞºĞ° ÑĞ¿ĞµĞ»Ğ»Ğ¾Ğ²
	if laser.level == 0 and rocket.level == 0 then
		return
	end

-- ĞĞ¿Ñ€ĞµĞ´ĞµĞ»ĞµĞ½Ğ¸Ğµ Ğ´Ğ°Ğ³Ğ¾Ğ½Ğ°
	local dagon = me:FindItem("item_dagon_5")
    dagon = dagon or me:FindItem("item_dagon_4")
    dagon = dagon or me:FindItem("item_dagon_3")
    dagon = dagon or me:FindItem("item_dagon_2")
    dagon = dagon or me:FindItem("item_dagon")
	
-- ĞœĞ¾Ğ´Ğ¸Ñ„Ğ¸ĞºĞ°Ñ‚Ğ¾Ñ€ ÑƒÑ€Ğ¾Ğ½Ğ° Ñ Ğ´Ğ°Ğ³Ğ¾Ğ½Ğ°
	if dagon then
		local lvl = string.match (dagon.name, "%d+")
		if not lvl then lvl = 1 end dmgD = dmg[lvl*1]
	end

-- Ğ¢Ğ°Ğ±Ğ»Ğ¸Ñ†Ğ° Ğ³ĞµÑ€Ğ¾ĞµĞ²
	local enemies = entityList:GetEntities({type=LuaEntity.TYPE_HERO,illusion = false})
	
	--ĞšĞ°Ğ»ÑŒĞºÑƒĞ»ÑÑ‚Ğ¾Ñ€ ÑƒÑ€Ğ¾Ğ½Ğ°
		for i,v in ipairs(enemies) do
			if v.team ~= me.team then
			
			test = v.position
			test.z = test.z + v.healthbarOffset
			local OnScreen, pos = client:ScreenPosition(test)
			
		--Ğ”Ğ¸Ğ½Ğ°Ğ¼Ğ¸Ñ‡ĞµÑĞºĞ°Ñ Ğ¿Ñ€Ğ¾Ñ€Ğ¸ÑĞ¾Ğ²ĞºĞ° Ñ‚ĞµĞºÑÑ‚Ğ°
				if not hero[v.handle] then hero[v.handle] = {}			
					hero[v.handle].txt = drawMgr:CreateText(0, 0, 0xFFFFFFFF, "",F16) hero[v.handle].txt.visible = false 				
				end	
			
				if v.health > 0 and OnScreen and v.alive and v.visible then
					if laser.level == 0 then
						if v.health >  ((dmgR[rocket.level]) * (1 - v.magicDmgResist)) then
							local hits = math.floor(v.health -  ((dmgR[rocket.level]) * (1 - v.magicDmgResist)))
							hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "No kill :" ..hits
						elseif v.health < ((dmgR[rocket.level]) * (1 - v.magicDmgResist)) then
							hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "Ezy kill"							
						end
					elseif rocket.level == 0 then
						if v.health >  dmgL[laser.level] then
							local hits = math.floor(v.health -  dmgL[laser.level])
							hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "No kill :" ..hits
						elseif v.health < dmgL[laser.level] then
							hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "Ezy kill"
						end
					elseif dagon then
						if me:FindItem("item_ethereal_blade") then
							if v.health > (dmgL[laser.level] + 1.4*((dmgD + (me.intellectTotal*2+75) + dmgR[rocket.level]) * (1 - v.magicDmgResist))) then		
								local hits = math.floor(v.health - (dmgL[laser.level] + 1.4*((dmgD + (me.intellectTotal*2+75) + dmgR[rocket.level]) * (1 - v.magicDmgResist))))
								hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "No kill :" ..hits
								elseif v.health < (dmgL[laser.level] + 1.4*((dmgD + (me.intellectTotal*2+75) + dmgR[rocket.level]) * (1 - v.magicDmgResist))) then
								hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "Ezy kill"
							end
						else
							if v.health > (dmgL[laser.level] + ((dmgD + dmgR[rocket.level]) * (1 - v.magicDmgResist))) then		
								local hits = math.floor(v.health - (dmgL[laser.level] + ((dmgD+dmgR[rocket.level]) * (1 - v.magicDmgResist))))
								hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "No kill :" ..hits
							elseif v.health < (dmgL[laser.level] + ((dmgD + dmgR[rocket.level]) * (1 - v.magicDmgResist))) then
								hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "Ezy kill"
							end
						end
					elseif laser.level ~= 0 and rocket.level ~= 0 then
						if v.health > (dmgL[laser.level] + (dmgR[rocket.level] * (1 - v.magicDmgResist))) then		
							local hits = math.floor(v.health - (dmgL[laser.level] + (dmgR[rocket.level] * (1 - v.magicDmgResist))))
							hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "No kill :" ..hits
						elseif v.health < (dmgL[laser.level] + (dmgR[rocket.level] * (1 - v.magicDmgResist))) then
							hero[v.handle].txt.visible = true hero[v.handle].txt.x = pos.x -20  hero[v.handle].txt.y = pos.y - 45 hero[v.handle].txt.text = "Ezy kill"
						end
					else
						hero[v.handle].txt.visible = false
					end			
				else
					hero[v.handle].txt.visible = false
				end
			end
		end
		Sleep(10)
end

function GameClose()
	hero = {}
	collectgarbage("collect")	
end
 
script:RegisterEvent(EVENT_CLOSE,GameClose)
script:RegisterEvent(EVENT_FRAME,Frame)
