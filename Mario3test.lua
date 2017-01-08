tiles = {}
for i = 1, 240, 1 do
    tiles[#tiles+1] = 1
end

while true do
    memory.writebyte(0x000ED, 05)
    gui.drawText(5,55,memory.readbyte(0x00090))
    gui.drawText(35,55,memory.readbyte(0x00075))
    gui.drawText(65,55,memory.readbyte(0x00090) + memory.readbyte(0x00075) * 256)
	
    gui.drawText(5,75,memory.readbyte(0x000A2))
    gui.drawText(35,75,memory.readbyte(0x00087))
    if memory.readbyte(0x00087) == 255 then
       gui.drawText(65,75, -(256 - memory.readbyte(0x000A2)))
    else
        gui.drawText(65,75,memory.readbyte(0x000A2) + memory.readbyte(0x00087) * 256)
    end
    --controller = joypad.get()    
    
    tiles[25] = 0
    --tiles[50] = 0
    --tiles[10] = 0
    --tiles[1] = 0
    --tiles[230] = 0
    
for layer = 1, 15, 1 do
    for i = 1, 16, 1 do
        if tiles[layer*16+i-15] == 1 then
            sqX = 4 + i * 4
            sqY = 4 + layer * 4                
            gui.drawBox(sqX, sqY, sqX + 4, sqY + 4, line, black)            
        end       
    end
end
    
    
    
    emu.frameadvance();
end