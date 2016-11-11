# 傾きの中心値の設定(センサを水平な場所に置いて調整してください)
$centerX = 336
$centerY = 336
$margin  = 4

# 表示する矩形の大きさ
$sizeX = 24
$sizeY = 24

# メイン初期化
#-----------------------------------------------------------------------------
def setup()
    # 傾きの値を表示する部品を配置
    $numbmp1 = GNDigitalNum.new(10, 10)
    $numbmp2 = GNDigitalNum.new(10, 30)

    # 表示位置
    $posX = 120
    $posY = 160
    $newX = 120
    $newY = 160

    # 移動範囲
    $posXmin = 0
    $posYmin = 0
    $posXmax = 240 - $sizeX
    $posYmax = 320 - $sizeY
end

# メインループ
#-----------------------------------------------------------------------------
def loop()
    # x方向傾きの取得
    axisX = gr_analogRead($PIN_AN4)
    $numbmp1.setInteger(axisX)

    # y方向傾きの取得
    axisY = gr_analogRead($PIN_AN5)
    $numbmp2.setInteger(axisY)

    # 移動量を一旦0にします
    velX = 0
    velY = 0

    # x方向の傾きによってx方向の移動量を決めます
    if axisX > ($centerX + $margin) then
        velX = 1
    end
    if axisX < ($centerX - $margin) then
        velX = -1
    end

    # y方向の傾きによってy方向の移動量を決めます
    if axisY > ($centerY + $margin) then
        velY = 1
    end
    if axisY < ($centerY - $margin) then
        velY = -1
    end

    # 新しいx座標を計算します
    $newX = $posX + velX

    # 画面の端では止まります
    if $newX > $posXmax then
        $newX = $posXmax
    end
    if $newX < $posXmin then
        $newX = $posXmin
    end

    # 新しいy座標を計算します
    $newY = $posY + velY

    # 画面の端では止まります
    if $newY > $posYmax then
        $newY = $posYmax
    end
    if $newY < $posYmin then
        $newY = $posYmin
    end

    # 移動している場合は矩形の表示を更新します
    if $posX != $newX || $posY != $newY then
        # 現在位置を消去
        GNDrawRect($posX, $posY, $sizeX, $sizeY, 31, 31, 31)

        # 新しい位置に描画
        GNDrawRect($newX, $newY, $sizeX, $sizeY, 0, 0, 0)

        # 描画位置の更新
        $posX = $newX
        $posY = $newY
    end
end
