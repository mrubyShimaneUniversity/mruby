# 状態の定義
$ST_STOP = 0
$ST_PLAY = 1

# 1:ド 2:レ 3:ミ 4:ファ 5:ソ 6:ラ 7:シ 8:ド
$musicData = [
    1, 1, 5, 5, 6, 6, 5, 0, 4, 4, 3, 3, 2, 2, 1, 0
]
$musicLength = $musicData.size

# 再生と停止を切換える値(周囲の明るさによって調整してください)
$light_val = 150

# メイン初期化
#-----------------------------------------------------------------------------
def setup()
    # 状態の初期化
    $state = $ST_STOP

    # カウンタの初期化
    $tic = 0
    $playCount = 0

    # 明るさ表示部品の生成
    $numbmp1 = GNDigitalNum.new(10, 10)

    gr_pinMode($PIN_IO8, $OUTPUT)
end

# メインループ
#-----------------------------------------------------------------------------
def loop()
    # 明るさの取得
    light = gr_analogRead($PIN_AN5)
    $numbmp1.setInteger(light)

    case $state
    when $ST_STOP
        # 停止状態の場合
        if light < $light_val then
            $state = $ST_PLAY
            $tic = 0
            $playCount = 0
        end
    when $ST_PLAY
        # 再生状態の場合
        if light >= $light_val then
            $state = $ST_STOP
        end
    end

    # 再生状態ならばメロディの再生を行います
    if $state == $ST_PLAY then
        $tic += 1
        if $tic >= 300 then
            $tic = 0

            playMelody($musicData[$playCount])
            $playCount += 1
            if $playCount >= $musicLength then
                $playCount = 0
            end
        end
    end
end

# 音階再生
def playMelody( tone )
    case tone
    when 0
        # 音を止める
        gr_noTone($PIN_IO8)
    when 1
        # ドの音
        gr_tone($PIN_IO8, 523, 500)
    when 2
        # レの音
        gr_tone($PIN_IO8, 587, 500)
    when 3
        # ミの音
        gr_tone($PIN_IO8, 659, 500)
    when 4
        # ファの音
        gr_tone($PIN_IO8, 698, 500)
    when 5
        # ソの音
        gr_tone($PIN_IO8, 783, 500)
    when 6
        # ラの音
        gr_tone($PIN_IO8, 880, 500)
    when 7
        # シの音
        gr_tone($PIN_IO8, 986, 500)
    when 8
        # ドの音
        gr_tone($PIN_IO8, 1046, 500)
    end
end
