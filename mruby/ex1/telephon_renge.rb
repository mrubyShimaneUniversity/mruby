def setup()
    $button1 = GNButton.new(10, 10, "onTouch1")
    $button2 = GNButton.new(100, 10, "onTouch2")

    gr_pinMode($PIN_LED0, $OUTPUT)
    gr_pinMode($PIN_LED1, $OUTPUT)
    gr_pinMode($PIN_LED2, $OUTPUT)
    gr_pinMode($PIN_LED3, $OUTPUT)

    $state = 0
    $time  = 0
end

def onTouch1(param1, param2)
	if param1 == 1 then
		gr_digitalWrite($PIN_LED0, param1)
		$state = 1
	end

	if param1 == 0 then
		gr_digitalWrite($PIN_LED0, param1) 
		$state = 2
		$time = 0
	end

	
end

def onTouch2(param1, param2)
	if param1 == 1
		$state = 3
	end
end

# wait for about 5 second
def timer(second)
	time = second * 100000
	while time > 0
		time = time - 1
	end
end

def loop()
	if $state == 5 || $state == 3 then	# when finish
		$state = 0						# initialize statement
		$time  = 0
	end
	if $state == 2 then
	 	$time = $time + 1
	 	if $time >= 35714 then
		 	if $state == 3 then
		 		gr_digitalWrite($PIN_LED1, 1)
		 		$state = 0
		 	else
		 		gr_digitalWrite($PIN_LED3, 1)
		 		$state = 4
		 		timer(5)
		 		gr_digitalWrite($PIN_LED3, 0)
		 		$state = 5
		 	end
		 end
	end 
end
