def setup()
    gr_pinMode($PIN_LED0, $OUTPUT)
end

def loop()
    gr_digitalWrite($PIN_LED0, 1)
    gr_delay(50)
    gr_digitalWrite($PIN_LED0, 0)
    gr_delay(50)
end
