def setup()
    # �{�^�����쐬
    $button1 = GNButton.new(10, 10, "onTouch1")

    gr_pinMode($PIN_LED0, $OUTPUT)
end

def onTouch1(param1, param2)
    # LED��On/Off
    gr_digitalWrite($PIN_LED0, param1)
end

def loop()
end
