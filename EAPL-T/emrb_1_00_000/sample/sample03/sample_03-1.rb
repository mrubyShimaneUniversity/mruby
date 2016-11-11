def setup()
    # É{É^ÉìÇçÏê¨
    	$button1 =GNButton.new(1,1, "onTouch1")
	$button2=GNButton.new(200,159, "onTouch2")
	$button3=GNButton.new(1,290, "onTouch3")
    gr_pinMode($PIN_LED0, $OUTPUT)
end


def onTouch1(param1, param2)

gr_digitalWrite($PIN_LED0, param1)
end

def onTouch2(param1, param2)

gr_digitalWrite($PIN_LED1, param1)
end

def onTouch3(param1, param2)

gr_digitalWrite($PIN_LED2, param1)
end

def loop()
	
	
end
