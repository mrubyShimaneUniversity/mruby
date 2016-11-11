
def setup()
	gr_pinMode($PIN_IO2,$OUTPUT)
	gr_pinMode($PIN_IO3,$INPUT)#input
	gr_pinMode($PIN_IO4,$OUTPUT)#ps
	gr_pinMode($PIN_IO8,$OUTPUT)#clk
	
end
def loop()
	oto = 30
	gr_digitalWrite($PIN_LED0, 1)
	i = 0
	ma = 10

	gr_digitalWrite($PIN_IO4,1)
	#gr_delay(ma+oto)
	gr_digitalWrite($PIN_IO4,0)


	for i in 0..16 do
		gr_digitalWrite($PIN_IO8,1)
	#	gr_delay(ma)
		gr_digitalWrite($PIN_IO8,0)

		if  gr_digitalRead($PIN_IO3) == 1 then
			
			case i
				when 0
					gr_tone($PIN_IO2,1046,oto)
				when 1
					gr_tone($PIN_IO2,783,oto)
                    #$textbox3 = GNTextbox.new(30, 50, 90, "TextBox 01")	
				when 2
					gr_tone($PIN_IO2,10,oto)
					
				when 3
					gr_tone($PIN_IO2,10000,oto)
				
				when 4
					gr_tone($PIN_IO2,587,oto)
				
				when 5
					gr_tone($PIN_IO2,698,oto)
                
				when 6
					gr_tone($PIN_IO2,659,oto)
					 
				when 7
					gr_tone($PIN_IO2,523,oto)
			
				when 8
					gr_tone($PIN_IO2,987,oto)
					          
				when 9
					gr_tone($PIN_IO2,880,oto)
					  
				when 10
					gr_tone($PIN_IO2,20000,oto)
						
				when 11
					gr_tone($PIN_IO2,33330,oto)
			end
		end
		gr_digitalWrite($PIN_IO8,0)
		#gr_noTone
	end
end
