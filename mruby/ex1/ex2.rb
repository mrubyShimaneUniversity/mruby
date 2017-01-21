def setup()
    $button1 = GNButton.new(10, 10, "onTouch1")
    $button2 = GNButton.new(100, 10, "onTouch2")

    gr_pinMode($PIN_LED0, $OUTPUT)
    gr_pinMode($PIN_LED3, $OUTPUT)

    $state = 0
end

def onTouch1(param1, param2)
	while param1 == 1
		gr_digitalWrite($PIN_LED0, param1)
	end
	$state = 2
end

def onTouch2(param1, param2)
	while param1 == 1
		gr_digitalWrite($PIN_LED3, param1)
	end
	$state = 3
end

# wait for about 5 second
def Timer(sec)
	time = sec * 20000
	while time > 0
		time = time - 1
	end
end

def loop()
	if $state == 5 || $state == 3 then	# when finish
		$state = 0						# initialize statement
	end

	if $state == 2 then
	 	Timer(5)
	 	if $state == 3 then
	 		$state = 0
	 	else
	 		gr_digitalWrite($PIN_LED3, 1)
	 		$state = 4
	 		Timer(5)
	 		gr_digitalWrite($PIN_LED3, 0)
	 		$state = 5
	 	end
	end 
end
