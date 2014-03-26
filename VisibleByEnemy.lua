text = drawMgr:CreateText(client.screenSize.x/2.07,client.screenSize.y/17,0xD10A0A80,"Visible",drawMgr:CreateFont("manabarsFont","Arial",26,600))
text.visible = false

function Frame() 
	if not client.connected or client.loading or client.console or not entityList:GetMyHero() then return end 
	local me = entityList:GetMyHero()	   
	if me.visibleToEnemy then text.visible = true else text.visible = false end       
end
 
script:RegisterEvent(EVENT_TICK,Frame)
