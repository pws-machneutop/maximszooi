tiles = {}
for i = 1, 192, 1 do
    tiles[#tiles+1] = 0
end

enemyVertical = {}
enemyHorizontal  = {} 
enemyDirecion = {} 
enemyVerticalPrevious = {} 
enemyHorizontalPrevious = {}
for i = 1, 5, 1 do
	enemyHorizontalPrevious[i] = 256
end


while true do
    memory.writebyte(0x000ED, 05) -- eternal tanooki
    memory.writebyte(0x05F1, 1) -- timer denial
    --for i =0, 0 do
    --	memory.writebyte(i, 0)
    --end
    -- misschien dienen de locaties 1 lager dan deze hier ook als enemy, maar dan als projectile. Hiet moet nog even naar gekeken worden.
    --ENEMY LOCATIONS
    --Vertical high
    for a = 163, 170, 1 do
        gui.drawText(155, 10 + 13*(a-163), memory.readbyte(a))
    end
    --Horizontal hight
    for a = 172, 179, 1 do
        gui.drawText(215, 10 + 13*(a-172), memory.readbyte(a))
    end
    --Vertical low
    for b = 136, 143, 1 do
        gui.drawText(180, 10 + 13*(b-136), memory.readbyte(b))
    end
    --Horizontal low
    for b = 118, 125, 1 do
        gui.drawText(240, 10 + 13*(b-118), memory.readbyte(b))
    end
    for b = 1, 5, 1 do
   	 	gui.drawText(110, 10 + 13*(b-1), "en." .. 6-b .. ":")
    end
    	gui.drawText(110, 10 + 13*5, "p. up")
	    gui.drawText(110, 10 + 13*6, "block")   
        
    
    gui.drawBox(4, 4, 16*4 + 4, 13*4 + 4, 0xff888888 ,0x40000000)
    
    
    for c = 1, 15*16, 1 do
    	tiles[c] = 0
    end
    
    
    marioX = memory.readbyte(0x00090) + memory.readbyte(0x00075) * 256
    if memory.readbyte(0x00087) ~= 255 then
   		marioY = memory.readbyte(0x000A2) + memory.readbyte(0x00087) * 256
	else
		marioY = 0 --Omdat aan de top van de map vertical low gelijk is aan 255
	end
    gui.drawText(4,75,marioX)
    gui.drawText(4,95,marioY)
    
    
    
    
    
    
    for i = 1, 5, 1 do
    	enemyVertical[i] = math.floor((memory.readbyte(167 - i + 1)) / 16) + 3
    	enemyHorizontal[i]  = math.floor((memory.readbyte(176 - i + 1)) / 16) + 1
    	enemyDirecion[i] = memory.readbyte(176 - i + 1) - enemyHorizontalPrevious[i]
    	enemyHorizontalPrevious[i] =  memory.readbyte(176 - i + 1)
    end
    
    --update tiles for enemies
    for i = 1, 5, 1 do
   		tiles[(enemyVertical[i]-1)*16 + enemyHorizontal[i]] = 2
    end
    
    
    for layer = 1, 15, 1 do
        for i = 1, 16, 1 do
            sqX = 4 + (i-1) * 4
            sqY = 4 + (layer-1) * 4 
            --ENEMIES
            if tiles[(layer-1)*16+i] == 2 then       
                gui.drawBox(sqX, sqY, sqX + 3, sqY + 3, 0xFF000000, 0xFF000000)            
            else if tiles[(layer-1)*16+i] == 1 then
                    gui.drawBox(sqX, sqY, sqX + 3, sqY + 3, 0xffffffff, 0xffffffff)
                else
                    gui.drawBox(sqX, sqY, sqX + 3, sqY + 3, 0x000000, 0x000000) 
                end
            end       
        end
    end
    
    
    
    emu.frameadvance();
end