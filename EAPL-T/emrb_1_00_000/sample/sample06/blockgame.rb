# 状態遷移の定義
$ST_CREATE = 0
$ST_PLAY   = 1
$ST_CLEAR  = 2

# ステージデータの定義
$DT_FLOOR  = 0
$DT_WALL   = 1
$DT_PLAYER = 2
$DT_BLOCK  = 3
$DT_GOAL   = 4

# 画面上の表示物の大きさ
$UNIT_SCALE = 20

# ステージデータ
$totalStage = 2
$stageData = [
    [
        0, 0, 1, 1, 1, 1, 0, 0,
        1, 1, 1, 0, 0, 1, 0, 0,
        1, 2, 0, 3, 0, 1, 0, 0,
        1, 1, 1, 1, 0, 1, 0, 0,
        0, 0, 1, 0, 0, 1, 1, 0,
        0, 0, 1, 0, 0, 4, 1, 0,
        0, 0, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ],
    [
        0, 0, 0, 0, 1, 1, 1, 0,
        0, 1, 1, 1, 1, 0, 1, 1,
        0, 1, 0, 0, 0, 4, 0, 1,
        1, 1, 0, 1, 1, 4, 0, 1,
        1, 2, 0, 3, 0, 0, 0, 1,
        1, 1, 1, 3, 0, 0, 0, 1,
        0, 0, 1, 0, 0, 1, 1, 1,
        0, 0, 1, 1, 1, 1, 0, 0,
    ],
]

# ステージ情報参照メソッド
def getStageData(x, y)
    return $stageData[$stage_no][y*8+x]
end

# ステージ生成メソッド
def createStage()
    for y in 0..7
        for x in 0..7
            case getStageData(x, y)
            when $DT_FLOOR
                # 床を描画
                drawFloor(x, y)
            when $DT_WALL
                # 壁を描画
                drawWall(x, y)
            when $DT_PLAYER
                # プレイヤーキャラクタを描画
                $player.setPos(x, y)
            when $DT_BLOCK
                # ブロックを生成して描画
                $blockList.push(DisplayObject.new(x, y, "block.gbf"))
            when $DT_GOAL
                # ゴールを描画
                drawGoal(x, y)
            end
        end
    end
end

# 壁描画メソッド
def drawWall(x, y)
    GNDrawImage(x * $UNIT_SCALE, y * $UNIT_SCALE, "wall.gbf")
end

# 床描画メソッド
def drawFloor(x, y)
    GNDrawImage(x * $UNIT_SCALE, y * $UNIT_SCALE, "floor.gbf")
end

# ゴール描画メソッド
def drawGoal(x, y)
    GNDrawImage(x * $UNIT_SCALE, y * $UNIT_SCALE, "goal.gbf")
end

# ブロック有無判定メソッド
def isBlockExist(x, y)
    $blockList.each { |block|
        if (x == block.posX) && (y == block.posY) then
            return block
        end
    }
    return nil
end

# 画面表示物クラス
class DisplayObject
    attr_accessor :posX, :posY

    # 初期化処理
    def initialize(x, y, fName)
        @fName = fName
        setPos(x, y)
    end

    # 位置設定
    def setPos(x, y)
        @posX = x
        @posY = y
        GNDrawImage(@posX * $UNIT_SCALE, @posY * $UNIT_SCALE, @fName)
    end

    # 移動
    def moveTo(x, y)
        # 移動元を描画
        if getStageData(@posX, @posY) == $DT_GOAL then
            drawGoal(@posX, @posY)
        else
            drawFloor(@posX, @posY)
        end

        # 現在位置を移動、移動先に画像を描画
        setPos(x, y)
    end
end

#-----------------------------------------------------------------------------
# メイン初期化
#=============================================================================
def setup()
    # 状態初期化
    $state = $ST_CREATE

    # ステージ番号初期化
    $stage_no = 0

    # ブロック配列生成
    $blockList = []

    # デジタルパッド生成
    $digitalpad = GNDigitalPad.new(50, 185, "onPad")

    # プレイヤー生成
    $player = DisplayObject.new(0, 0, "player.gbf")
end

# メインループ
#-----------------------------------------------------------------------------
def loop()
    if $state == $ST_CREATE then
        # ブロック配列クリア
        $blockList.clear

        # ステージ生成
        createStage()

        # プレイ開始
        $state = $ST_PLAY
    end
end

# デジタルパッド操作時処理
#-----------------------------------------------------------------------------
def onPad(param1, param2)
    # ステージクリア状態の場合はパッド操作で次のステージへ
    if $state == $ST_CLEAR then
        $stage_no += 1
        if $stage_no >= $totalStage then
            $stage_no = 0
        end

        # 次のステージの生成を開始する
        $state = $ST_CREATE

        return
    end

    if $state == $ST_PLAY then
        # ゲームプレイ中状態の場合はプレイヤーの移動を行う
        dx = 0              # プレイヤーキャラクタx移動量
        dy = 0              # プレイヤーキャラクタy移動量
        isBlockMove = 1     # ブロック移動判定フラグ
        isStageClear = 1    # ステージクリア判定フラグ

        # デジタルパッド入力に対する移動処理
        case param1
        when $DPAD_UP
            dy = -1
        when $DPAD_DOWN
            dy = 1
        when $DPAD_LEFT
            dx = -1
        when $DPAD_RIGHT
            dx = 1
        end

        # プレイヤーの移動先にブロックがあるかどうか
        block = isBlockExist($player.posX + dx, $player.posY + dy)
        if block != nil then
            # ブロックの移動先の算出
            blockMoveX = $player.posX + dx * 2
            blockMoveY = $player.posY + dy * 2

            # ブロックの移動先に何かあるか
            if (isBlockExist(blockMoveX, blockMoveY) == nil) &&
               (getStageData(blockMoveX, blockMoveY) != $DT_WALL) then
                # ブロックの移動先にブロックも壁もなければ移動可能
                block.moveTo(blockMoveX, blockMoveY)
            else
                # ブロックが移動できない
                isBlockMove = 0
            end
        end

        # ゴール判定
        $blockList.each { |block|
            if getStageData(block.posX, block.posY) != $DT_GOAL then
                # ブロックがゴールの上に無ければステージクリア判定フラグを0にする
                isStageClear = 0
            end
        }

        # プレイヤーの移動
        if (getStageData($player.posX + dx, $player.posY + dy) != $DT_WALL) &&
           (isBlockMove == 1) then
            $player.moveTo($player.posX + dx, $player.posY + dy)
        end

        # クリア判定
        if isStageClear == 1 then
            GNDrawImage(80, 70, "clear.gbf")
            $state = $ST_CLEAR
        end
    end
end
