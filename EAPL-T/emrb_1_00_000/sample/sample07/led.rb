# メイン初期化
#-----------------------------------------------------------------------------
def setup()
    # IO8を出力設定とする
    gr_pinMode($PIN_IO8, $OUTPUT)
end

# メインループ
#-----------------------------------------------------------------------------
def loop()
    # IO8の出力をOnとする
    gr_digitalWrite($PIN_IO8, 1)
    gr_delay(100)

    # IO8の出力をOffとする
    gr_digitalWrite($PIN_IO8, 0)
    gr_delay(100)
end
