tiles = {}
for i = 1, 192, 1 do
    tiles[#tiles+1] = 0
end

enemyAlive = {}
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
    -- enemy alive state
    for b = 0x661, 0x665, 1 do
        gui.drawText(240, 10 + 13*9 + 13*(b-0x661), memory.readbyte(b))
    end
        
        
    
    gui.drawBox(4, 4, 16*4 + 4, 13*4 + 4, 0xff888888 ,0x40000000)
    
    
    for c = 1, 15*16, 1 do
    	tiles[c] = 0
    end
    
    -- Get Mario Coordinates
    marioX = memory.readbyte(0x00090) + memory.readbyte(0x00075) * 256 + 2
    if memory.readbyte(0x00087) ~= 255 then 
   		marioY = memory.readbyte(0x000A2) + memory.readbyte(0x00087) * 256
	else
		--Omdat aan de top van de map vertical low byte gelijk is aan 255
		marioY = 0 
	end
    gui.drawText(4,75,marioX)
    gui.drawText(4,95,marioY)
    
    -- Check if solid 
	for i = 1, 240, 1 do
		tileX = marioX - 128 + (16*(i-1))%256   
		tileY = marioY - 128 + 16*math.floor((i-1)/16)
		
		tileHorizontalLow = math.floor(tileX/256)
		tileHorizontalHigh = math.floor((tileX%256)/16)
		if tileY >= 0 then
			tileVertical = math.floor(tileY/16)
		else
			-- Dit is voor dezelfde redenen als bij marioY hierboven
			tileVertical = 0			
		end
		
		tileData = memory.readbyte(0x6000 + tileHorizontalLow*27*16 + tileHorizontalHigh + tileVertical*16)
	
		--[[Eerste Level:
				44, 83, 84, 85, 86, 87, 95, 97, 99, 103, 110, 121, 173, 174, 177, 178, 186, 187, 
				Alleen van boven solid: 
				37, 38, 39, 80, 81, 82, 160, 161, 162, 226, 227, 228
					
			Tweede level en verder:
				46, 105, 107, 113, 114, 154, 155, 156, 158, 157, 167, 168, 169, 170, 171, 182, 183, 184, 185
				
		--]]
		
		
			if 	tileData == 44  or tileData == 83  or tileData == 85  or tileData == 87  or tileData == 95  or tileData == 97  or tileData == 99  or tileData == 103 or 
				tileData == 110 or tileData == 112 or tileData == 121 or tileData == 173 or tileData == 174 or tileData == 177 or 
				tileData == 178 or tileData == 186 or tileData == 187 or tileData == 37  or tileData == 38  or tileData == 39  or tileData == 80  or 
				tileData == 81  or tileData == 82  or tileData == 160 or tileData == 161 or tileData == 162 or tileData == 226 or tileData == 227 or 
				tileData == 228 or tileData == 46  or tileData ==  49 or tileData == 105 or tileData == 107 or tileData == 109 or tileData == 113 or tileData == 114 or 
				tileData == 116 or tileData == 154 or tileData == 155 or tileData == 156 or tileData == 157 or tileData == 158 or tileData == 167 or tileData == 168 or 
				tileData == 169 or tileData == 170 or tileData == 171 or tileData == 182 or tileData == 183 or tileData == 184 or tileData == 185
		then
			tiles[i] = 1
		end

	end
	    
    --Tile data onder Mario = memory.readbyte(0x6000 + math.floor((marioX/256))*27*16 + math.floor((marioX%256)/16) + (math.floor(marioY/16))*16 + 32)	

    
    for i = 1, 5, 1 do
    	enemyAlive[i] = memory.readbyte(0x665 - i + 1)
    	enemyVertical[i] = math.floor((memory.readbyte(167 - i + 1)) / 16) + 3
    	enemyHorizontal[i]  = math.floor((memory.readbyte(176 - i + 1)) / 16) + 1
    	enemyDirecion[i] = memory.readbyte(176 - i + 1) - enemyHorizontalPrevious[i]
    	enemyHorizontalPrevious[i] =  memory.readbyte(176 - i + 1)
    end
    
    --update tiles for enemies
    for i = 1, 5, 1 do
    	if enemyAlive[i] == 2 or enemyAlive[i] == 5 then
   			tiles[(enemyVertical[i]-1)*16 + enemyHorizontal[i]] = 2
   		end
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
    
    --draw mario
    gui.drawBox(9*4+1, 9*4+1, 9*4+2, 11*4, 0xFF740858, 0xFF740858)
    gui.drawBox(9*4-1,11*4-1,9*4+4, 11*4, 0xFF740858, 0xFF740858)
    
    
    emu.frameadvance();
end