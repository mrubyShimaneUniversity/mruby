def setup()
    $button1 = GNButton.new(10, 10, "onTouch1")

    gr_pinMode($PIN_LED0, $OUTPUT)
    gr_pinMode($PIN_LED3, $OUTPUT)
end

def onTouch1(param1, param2)
    a = 2
    if param1 == 1 then
        gr_digitalWrite($PIN_LED0, param1)
        a = 1
    end
    if param1 == 0 then
        gr_digitalWrite($PIN_LED0, param1)
        a = 0
    end
    Timer(a)
end

def Timer(a)
    sec = 2
    if a == 0 then
        while sec > 0 do
            gr_digitalWrite($PIN_LED3, 1)
            sec -= 1
        end
        while sec <= 0 do
            gr_digitalWrite($PON_LED3, 0)
        end
    end
end

def loop()
end
