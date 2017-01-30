-- Initiation of the input array (tiles)
tiles = {}
for i = 1, 256, 1 do
    tiles[#tiles+1] = 0
end

-- Initiation array enemy for-loops
enemyAlive = {}
enemyVertical = {}
enemyHorizontal  = {} 
EnableEnemyRender = {}
<<<<<<< HEAD

-- Variables to retain previous frame data
fireballPrevious1 = 0
fireballPrevious2 = 0
fireballSecondPrevious1 = 0
fireballSecondPrevious2 = 0
boomarangPrevious1 = 0
boomarangPrevious2 = 0
boomarangSecondPrevious1 = 0
boomarangSecondPrevious2 = 0

-- Finish block Y position
memory.writebyte(0x00A9, 128);

-- Neural Network data
generation = 12
species = 50
genome = 24
fitness = 666
fitnessMax = 1234
progress = 24
marioX = 0
=======

-- Variables to retain previous frame data
fireballPrevious1 = 0
fireballPrevious2 = 0
fireballSecondPrevious1 = 0
fireballSecondPrevious2 = 0
boomarangPrevious1 = 0
boomarangPrevious2 = 0
boomarangSecondPrevious1 = 0
boomarangSecondPrevious2 = 0
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d

-- Controller data
controller = {}
outputs = {
	false,
	true,
	false,
	true,
	false
}
buttonNames = {
	"A",
	"B",
	"Up",
	"Down",
	"Left",
	"Right"
}
	
while true do
<<<<<<< HEAD




	-- Temporary, development only
    memory.writebyte(0x000ED, 05) -- Infinite Tanooki power-up
    -- memory.writebyte(0x05F1, 1) -- Disable timer
	
	
	time = memory.readbyte(0x05EE)*100 + memory.readbyte(0x05EF)*10 + memory.readbyte(0x05F0)
	score =  memory.readbyte(0x0717)*10 + memory.readbyte(0x0716)*2560
	fitness = marioX + time + score
	
	
-- BLOCK 3: DRAW NETWORK	
	
	-- Refresh Outputs
	for i = 1, 6 do
    	controller["P1 " .. buttonNames[i]] = false
    end
	--joypad.set(controller)
	
	for i = 1, 6 do
		controller["P1 " .. buttonNames[i]] = outputs[i] 
	end
	--joypad.set(controller)
	
	-- Draw Buttons
	for i = 1, 6 do
    	if outputs[i] == false then
    		gui.drawText(220, 4 + 8*i, buttonNames[i], 0xff000000, 0x00000000, 10 )
  			gui.drawBox(215, 8 + 8*i, 218, 11 + 8*i, 0xff888888, 0x40000000)  
  		end
  		if outputs[i] == true then
    		gui.drawText(220, 4 + 8*i, buttonNames[i], 0xff276d1c, 0x00000000, 10 )
  			gui.drawBox(215, 8 + 8*i, 218, 11 + 8*i, 0xffffffff, 0xffffffff)  
  		end
  	end
	
	
	
-- BLOCK 1: DRAW DATA    
    gui.drawBox(0,210,255,255, 0x8fffffff, 0xDfffffff)
    	
    gui.drawText(10, 220, "Gen: " .. generation, 0xff000000, 0x00000000, 10)
    gui.drawText(65, 220, "Species: " .. species, 0xff000000, 0x00000000, 10)
    gui.drawText(140, 220, "Genome: " .. genome, 0xff000000, 0x00000000, 10)
    gui.drawText(220, 220, "(" .. progress .. "%)", 0xff000000, 0x00000000, 10)
  
    gui.drawText(10, 210, "Fitness: " .. fitness, 0xff000000, 0x00000000, 10)
    gui.drawText(100, 210, "Max Fitness: " .. fitnessMax, 0xff000000, 0x00000000, 10)
    	
    	
    	
-- BLOCK 2: INPUTS - TO NEURAL NETWORK    	
	-- Draw Input Box - empty
    gui.drawBox(3, 11, 16*4 + 4, 15*4 + 12, 0xff000000 ,0x40000000)
    gui.drawLine(15, 12, 15, 71, 0xff888888)
    gui.drawLine(56, 12, 56, 71, 0xff888888)
=======
    -- Temporary, development only
    memory.writebyte(0x000ED, 05) -- Infinite Tanooki power-up
    memory.writebyte(0x05F1, 1) -- Disable timer
    
   
    
    -- Draw GUI - empty
    gui.drawBox(4, 4, 16*4 + 4, 15*4 + 4, 0xff888888 ,0x40000000)
    gui.drawLine(16, 0, 16, 64, 0xff888888)
    gui.drawLine(56, 0, 56, 64, 0xff888888)
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d
    
    -- Refresh inputs
    for c = 1, 16*16, 1 do
    	tiles[c] = 0
    end
    
    -- Update frame-dependent Variables
    screenHorizontalPosition = memory.readbyte(0x00FD) + memory.readbyte(0x0012)*256
    
	-- Get Mario Coordinates
    marioX = memory.readbyte(0x00090) + memory.readbyte(0x00075) * 256 + 8
    if memory.readbyte(0x00087) ~= 255 then 
   		marioY = memory.readbyte(0x000A2) + memory.readbyte(0x00087) * 256
	else
		-- (The vertical Low byte is equal to 255 on the topmost row of the map)
		marioY = 0 
	end
    
	-- Check all tiles around Mario for hitboxes and update inputs (hitboxes)
<<<<<<< HEAD
	for i = 1, 241, 1 do
=======
	for i = 1, 240, 1 do
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d
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
		if	tileData == 44  or tileData == 83  or tileData == 85  or tileData == 87  or tileData == 95  or tileData == 97  or tileData == 99  or tileData == 103 or 
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
	    
    -- Get enemy data
    for i = 1, 5, 1 do
    	enemyAlive[i] = memory.readbyte(0x665 - i + 1)
    	
    	enemyX = screenHorizontalPosition + memory.readbyte(176 - i + 1) + 8
    	enemyHorizontal[i]  = math.floor((enemyX - marioX) / 16) - 7
    
    	enemyY = memory.readbyte(167 - i + 1) + 256
    	enemyVertical[i] = math.floor(enemyY / 16) + 9 - math.floor(marioY/16)
    end
   -- Circumvent enemy position overflow - No enemies render outside the two lines
   for i = 1, 5, 1 do 
    	if enemyHorizontal[i] < -12 or enemyHorizontal[i] > -3 then
    		EnableEnemyRender[i] = 0	
    	else
    		EnableEnemyRender[i] = 1
    	end
    end  
    -- Update inputs (enemies)
    for i = 1, 5, 1 do
    	if EnableEnemyRender[i] == 1 then
    		if enemyAlive[i] == 2 or enemyAlive[i] == 5 then			
<<<<<<< HEAD
   					tiles[(enemyVertical[i])*16 + enemyHorizontal[i]] = -1
=======
   					tiles[(enemyVertical[i])*16 + enemyHorizontal[i]] = 2
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d
   			end
    	end
    end
    
    -- Get Projectile data (fireball)
    fireballHorizontal1  = math.floor((memory.readbyte(0x05CB)+256-marioX)/16)%16 - 6
    fireballHorizontal2  = math.floor((memory.readbyte(0x05CC)+256-marioX)/16)%16 - 6
    fireballVertical1  = math.floor((memory.readbyte(0x05C1) + 256 - marioY)/16) + 9
    fireballVertical2  =  math.floor((memory.readbyte(0x05C2) + 256 - marioY)/16) + 9
       
    fireballDirection1 = fireballSecondPrevious1 - memory.readbyte(0x05CB)
    fireballSecondPrevious1 = fireballPrevious1
    fireballPrevious1 = memory.readbyte(0x05CB)
    
    fireballDirection2 = fireballSecondPrevious2 - memory.readbyte(0x05CC)
    fireballSecondPrevious2 = fireballPrevious2
    fireballPrevious2 = memory.readbyte(0x05CC)
   
    -- Get Projectile data (boomarang)
    boomarangHorizontal1  = math.floor((memory.readbyte(0x05CD)+256-marioX)/16)%16 - 6
    boomarangHorizontal2  = math.floor((memory.readbyte(0x05CE)+256-marioX)/16)%16 - 6
    boomarangVertical1  = math.floor((memory.readbyte(0x05C3) + 256 - marioY)/16) + 9
    boomarangVertical2  =  math.floor((memory.readbyte(0x05C4) + 256 - marioY)/16) + 9
       
    boomarangDirection1 = boomarangSecondPrevious1 - memory.readbyte(0x05CD)
    boomarangSecondPrevious1 = boomarangPrevious1
    boomarangPrevious1 = memory.readbyte(0x05CD)
<<<<<<< HEAD
    
    boomarangDirection2 = boomarangSecondPrevious2 - memory.readbyte(0x05CE)
    boomarangSecondPrevious2 = boomarangPrevious2
    boomarangPrevious2 = memory.readbyte(0x05CE)
    
    -- Update inputs (projectiles)
    if fireballDirection1 ~= 0 then
    	tiles[fireballVertical1*16 + fireballHorizontal1] = -1
    end
    if fireballDirection2 ~= 0 then
    tiles[fireballVertical2*16 + fireballHorizontal2] = -1
    end
    if boomarangDirection1 ~= 0 then
    	tiles[boomarangVertical1*16 + boomarangHorizontal1] = -1
    end
    if boomarangDirection2 ~= 0 then
    tiles[boomarangVertical2*16 + boomarangHorizontal2] = -1
    end
    
=======
    
    boomarangDirection2 = boomarangSecondPrevious2 - memory.readbyte(0x05CE)
    boomarangSecondPrevious2 = boomarangPrevious2
    boomarangPrevious2 = memory.readbyte(0x05CE)
    
    -- Update inputs (projectiles)
    if fireballDirection1 ~= 0 then
    	tiles[fireballVertical1*16 + fireballHorizontal1] = 2
    end
    if fireballDirection2 ~= 0 then
    tiles[fireballVertical2*16 + fireballHorizontal2] = 2
    end
    if boomarangDirection1 ~= 0 then
    	tiles[boomarangVertical1*16 + boomarangHorizontal1] = 2
    end
    if boomarangDirection2 ~= 0 then
    tiles[boomarangVertical2*16 + boomarangHorizontal2] = 2
    end
    
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d
   
    -- Draw inputs
    for layer = 1, 15, 1 do
        for i = 1, 16, 1 do
            sqX = 4 + (i-1) * 4
<<<<<<< HEAD
            sqY = 12 + (layer-1) * 4 
            -- Enemies and projectiles
            if tiles[(layer-1)*16+i] == -1 then       
=======
            sqY = 4 + (layer-1) * 4 
            -- Enemies and projectiles
            if tiles[(layer-1)*16+i] == 2 then       
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d
                gui.drawBox(sqX, sqY, sqX + 3, sqY + 3, 0xFF000000, 0xFF000000)            
            else 
            -- Hitboxes
            if tiles[(layer-1)*16+i] == 1 then
                gui.drawBox(sqX, sqY, sqX + 3, sqY + 3, 0xffffffff, 0xffffffff)
            else
            -- Empty space
                gui.drawBox(sqX, sqY, sqX + 3, sqY + 3, 0x000000, 0x000000) 
            end
            end       
        end
    end
    
    -- Draw position Mario
<<<<<<< HEAD
    gui.drawBox(37, 45, 38, 51, 0xFF740858, 0xFF740858)
    gui.drawLine(34, 51, 41, 51, 0xFF740858)
    
=======
    gui.drawBox(37, 37, 38, 43, 0xFF740858, 0xFF740858)
    gui.drawLine(34, 43, 41, 43, 0xFF740858)
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d
    
    
-- BLOCK 3: VISUALISATION NEURAL NETWORK AND OUTPUTS
--[[	
	for i = 1, 247, 1 do
		if i <= 240 then
			nodeX[i] = 4 + 4 * (i%16)
			nodeY[i] = 12 + 4 * (math.floor(i/16)-1)
		end
		if i == 241 then
			nodeX[i] = 16*4
			nodeY[i] = 79
		do
		if i >= 242 and i <= 247 then
			nodeX[i] = 215
			nodeY[i] = 8 + 8*(i-241)
		do
	end	
	
	for i = 1, 247, 1 do
		nodeDrawn[i] = true
	end
		
	
	for i = 1, #nodes do 	
		nodeNumber = nodes[i]
		distanceToOutput =														!!!!!!!!
		distanceToInput = 														!!!!!!!!
		if nodeDrawn[nodeNumber] == false then
			nodeSeparation = 147 / (distanceToOutput + distanceToInput)
			nodeX[nodeNumber] = 17*4 + distanceToInput*nodeSeparation	
			nodeY[nodeNumber] = 12 + (i-247)*5 
			nodeDrawn[nodeNumber] = true
		end
	end
	
	for i = 1, #nodes
		if |nodestate| == 0 then												!!!!!!!!
			nodeOutput[i] = 0
		end
		if |nodestate| < 1 then													!!!!!!!!
			nodeOutput[i] = 1
		end	
		if |nodestate| > 1 then													!!!!!!!!
			nodeOutput[i] = -1
		end
	end
	
	for i = 248, #nodes do
		if nodeOuput[i] == 0 then
  			gui.drawBox(nodeX[i], nodeY[i], nodeX[i]+3, nodeY[i]+3, 0xff888888, 0x40000000)  
  		end
  		if nodeOutput[i] == 1 then
  			gui.drawBox(nodeX[i], nodeY[i], nodeX[i]+3, nodeY[i]+3, 0xffffffff, 0xffffffff)  
  		end
  		if nodeOutput[i] == -1 then
  			gui.drawBox(nodeX[i], nodeY[i], nodeX[i]+3, nodeY[i]+3, 0xff000000, 0xff000000)  
  		end
	end
	
	
	for 1 = 1, #connections do	
		source = connection[i][1] 
		sink = connection[i][2] 
		if nodeDrawn[source] and nodeDrawn[sink] then
			if nodeOutput[source] == 0 then
				gui.drawLine(nodeX[source]+1, nodeY[source]+1, nodeX[sink+1], nodeY[sink]+1, 0x6Fffffff)
			end
			if nodeOutput[source] > 0 then 
				gui.drawLine(nodeX[source]+1, nodeY[source]+1, nodeX[sink]+1, nodeY[sink]+1, 0xFF00ff00)
			end
			if nodeOutput[source] < 0 then
				gui.drawLine(nodeX[source]+1, nodeY[source]+1, nodeX[sink]+1, nodeY[sink]+1, 0xFFff0000)
			end
		end	
	end
--]]
	
	
    emu.frameadvance();
end

<<<<<<< HEAD

=======
>>>>>>> 651e9725b35140633c6d4afc44876f36d9ff241d
