def setup()
    # ƒ{ƒ^ƒ“‚ğì¬
    $button1 = GNButton.new(10, 10, "onTouch1")

    gr_pinMode($PIN_LED0, $OUTPUT)
end

def onTouch1(param1, param2)
    # LED‚ğOn/Off
    gr_digitalWrite($PIN_LED0, param1)
end

def loop()
end
