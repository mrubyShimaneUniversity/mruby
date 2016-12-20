def setup()
    $switch1 = GNSwitch.new(80, 40, "onTouch1")

    gr_pinMode($PIN_LED0, $OUTPUT)
    gr_pinMode($PIN_LED3, $OUTPUT)
    @a = 2
end

def onTouch1(param1, param2)

    b = 0
    if a == 2 && param1 == 1 then
        gr_digitalWrite($PIN_LED0, param1)
        a = 1
    end
    if param1 == 0 then
        gr_digitalWrite($PIN_LED0, param1)
        a = 0
    end
    
    if a == 0 && param1 = 1 then
        return b
    end
    
    Timer(a, param1, param2)
end
        
def Timer(a, param1, param2)
    b = 1

    for num in 1..100000 do
        onTouch1(1, param2)
    end
    
    gr_digitalWrite($PIN_LED3, b)

end

def loop()
end