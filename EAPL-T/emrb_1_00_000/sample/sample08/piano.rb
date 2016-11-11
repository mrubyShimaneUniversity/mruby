# メイン初期化
#-----------------------------------------------------------------------------
def setup()
    $button1 = GNButton.new(  0,   0, "onTouch1")
    $button2 = GNButton.new(  0,  50, "onTouch2")
    $button3 = GNButton.new( 62,  74, "onTouch3")
    $button4 = GNButton.new( 62, 124, "onTouch4")
    $button5 = GNButton.new(124, 148, "onTouch5")
    $button6 = GNButton.new(124, 198, "onTouch6")
    $button7 = GNButton.new(186, 220, "onTouch7")
    $button8 = GNButton.new(186, 270, "onTouch8")

    gr_pinMode($PIN_IO8, $OUTPUT)
end

# メインループ
#-----------------------------------------------------------------------------
def loop()
end

def onTouch1(param1, param2)
    if param1 == 1 then
        # ドの音
        gr_tone($PIN_IO8, 1046, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

def onTouch2(param1, param2)
    if param1 == 1 then
        # シの音
        gr_tone($PIN_IO8, 986, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

def onTouch3(param1, param2)
    if param1 == 1 then
        # ラの音
        gr_tone($PIN_IO8, 880, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

def onTouch4(param1, param2)
    if param1 == 1 then
        # ソの音
        gr_tone($PIN_IO8, 783, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

def onTouch5(param1, param2)
    if param1 == 1 then
        # ファの音
        gr_tone($PIN_IO8, 698, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

def onTouch6(param1, param2)
    if param1 == 1 then
        # ミの音
        gr_tone($PIN_IO8, 659, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

def onTouch7(param1, param2)
    if param1 == 1 then
        # レの音
        gr_tone($PIN_IO8, 587, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

def onTouch8(param1, param2)
    if param1 == 1 then
        # ドの音
        gr_tone($PIN_IO8, 523, 0)
    else
        gr_noTone($PIN_IO8)
    end
end

