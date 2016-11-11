def setup()
    $button1 = GNButton.new(10, 10, "onTouch1")
    $numbmp1 = GNDigitalNum.new(170, 10)
    $slider1 = GNVSlider.new(180, 30, 0, 255, "onTouch2")
    gr_pinMode($PIN_LED0, $OUTPUT)
    gr_pinMode($PIN_LED3, $OUTPUT)
end

def onTouch1(param1, param2)
    # LED‚ðOn/Off
    gr_digitalWrite($PIN_LED0, param1)
end

def onTouch2(param1, param2)
    gr_analogWrite($PIN_LED3, param1)
    $numbmp1.setInteger(param1)
end

def loop()
end
