def setup()
    $button1 = GNButton.new(10, 10, "onTouch1")
    $button1 = GNButton.new(100, 100, "onTouch2")

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
    
    if a == 0 then
        Timer(a, param1)
    end
end

def onTouch2(param1, param2)
    b = 1

    if param1 == 1 then
        b = 0
    else
        b = 1
    end

    return b
end
        
def Timer(a, param1)
    sec = 3
    b = 1

    for num in 1..100000 do
        onTouch2(param1, param2)
    end
    
    gr_digitalWrite($PIN_LED3, b)

end

def loop()
end