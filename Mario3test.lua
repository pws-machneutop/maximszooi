tiles = {}
for i = 1, 240, 1 do
    tiles[#tiles+1] = 0
end

while true do
    memory.writebyte(0x000ED, 05)
    gui.drawText(5,75,memory.readbyte(0x00090))
    gui.drawText(35,75,memory.readbyte(0x00075))
    gui.drawText(65,75,memory.readbyte(0x00090) + memory.readbyte(0x00075) * 256)
	
    gui.drawText(5,95,memory.readbyte(0x000A2))
    gui.drawText(35,95,memory.readbyte(0x00087))
    if memory.readbyte(0x00087) == 255 then
       gui.drawText(65,95, -(256 - memory.readbyte(0x000A2)))
    else
        gui.drawText(65,95,memory.readbyte(0x000A2) + memory.readbyte(0x00087) * 256)
    end
    --controller = joypad.get()    
    
    tiles[1] = 1
    tiles[2] = 2
    tiles[17] = 2
    tiles[240] = 1
    tiles[239] = 2
    tiles[224] = 2
    tiles[16] = 1
    tiles[15] = 2
    tiles[32] = 2
    -- misschien dienen de locaties 1 lager dan deze hier ook als enemy, maar dan als projectile. Hiet moet nog even naar gekeken worden.
    --ENEMY LOCATIONS
    --Vertical high
    for a = 164, 170, 1 do
        gui.drawText(200, 12*(a-164), memory.readbyte(a))
    end
    --Horizontal hight
    for a = 173, 179, 1 do
        gui.drawText(200, 12*8 + 12*(a-173), memory.readbyte(a))
    end
    --Vertical low
    for b = 137, 143, 1 do
        gui.drawText(230, 12*(b-137), memory.readbyte(b))
    end
    --Horizontal low
    for b = 119, 125, 1 do
        gui.drawText(230, 12*8 + 12*(b-119), memory.readbyte(b))
    end
    gui.drawBox(200, 12*8, 240, 12*8+1, 0xffffffff, 0xffffffff)
        
    
    gui.drawBox(4, 4, 16*4 + 4, 15*4 + 4, 0xff888888 ,0x40000000)
    
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