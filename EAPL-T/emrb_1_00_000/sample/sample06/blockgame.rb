# ��ԑJ�ڂ̒�`
$ST_CREATE = 0
$ST_PLAY   = 1
$ST_CLEAR  = 2

# �X�e�[�W�f�[�^�̒�`
$DT_FLOOR  = 0
$DT_WALL   = 1
$DT_PLAYER = 2
$DT_BLOCK  = 3
$DT_GOAL   = 4

# ��ʏ�̕\�����̑傫��
$UNIT_SCALE = 20

# �X�e�[�W�f�[�^
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

# �X�e�[�W���Q�ƃ��\�b�h
def getStageData(x, y)
    return $stageData[$stage_no][y*8+x]
end

# �X�e�[�W�������\�b�h
def createStage()
    for y in 0..7
        for x in 0..7
            case getStageData(x, y)
            when $DT_FLOOR
                # ����`��
                drawFloor(x, y)
            when $DT_WALL
                # �ǂ�`��
                drawWall(x, y)
            when $DT_PLAYER
                # �v���C���[�L�����N�^��`��
                $player.setPos(x, y)
            when $DT_BLOCK
                # �u���b�N�𐶐����ĕ`��
                $blockList.push(DisplayObject.new(x, y, "block.gbf"))
            when $DT_GOAL
                # �S�[����`��
                drawGoal(x, y)
            end
        end
    end
end

# �Ǖ`�惁�\�b�h
def drawWall(x, y)
    GNDrawImage(x * $UNIT_SCALE, y * $UNIT_SCALE, "wall.gbf")
end

# ���`�惁�\�b�h
def drawFloor(x, y)
    GNDrawImage(x * $UNIT_SCALE, y * $UNIT_SCALE, "floor.gbf")
end

# �S�[���`�惁�\�b�h
def drawGoal(x, y)
    GNDrawImage(x * $UNIT_SCALE, y * $UNIT_SCALE, "goal.gbf")
end

# �u���b�N�L�����胁�\�b�h
def isBlockExist(x, y)
    $blockList.each { |block|
        if (x == block.posX) && (y == block.posY) then
            return block
        end
    }
    return nil
end

# ��ʕ\�����N���X
class DisplayObject
    attr_accessor :posX, :posY

    # ����������
    def initialize(x, y, fName)
        @fName = fName
        setPos(x, y)
    end

    # �ʒu�ݒ�
    def setPos(x, y)
        @posX = x
        @posY = y
        GNDrawImage(@posX * $UNIT_SCALE, @posY * $UNIT_SCALE, @fName)
    end

    # �ړ�
    def moveTo(x, y)
        # �ړ�����`��
        if getStageData(@posX, @posY) == $DT_GOAL then
            drawGoal(@posX, @posY)
        else
            drawFloor(@posX, @posY)
        end

        # ���݈ʒu���ړ��A�ړ���ɉ摜��`��
        setPos(x, y)
    end
end

#-----------------------------------------------------------------------------
# ���C��������
#=============================================================================
def setup()
    # ��ԏ�����
    $state = $ST_CREATE

    # �X�e�[�W�ԍ�������
    $stage_no = 0

    # �u���b�N�z�񐶐�
    $blockList = []

    # �f�W�^���p�b�h����
    $digitalpad = GNDigitalPad.new(50, 185, "onPad")

    # �v���C���[����
    $player = DisplayObject.new(0, 0, "player.gbf")
end

# ���C�����[�v
#-----------------------------------------------------------------------------
def loop()
    if $state == $ST_CREATE then
        # �u���b�N�z��N���A
        $blockList.clear

        # �X�e�[�W����
        createStage()

        # �v���C�J�n
        $state = $ST_PLAY
    end
end

# �f�W�^���p�b�h���쎞����
#-----------------------------------------------------------------------------
def onPad(param1, param2)
    # �X�e�[�W�N���A��Ԃ̏ꍇ�̓p�b�h����Ŏ��̃X�e�[�W��
    if $state == $ST_CLEAR then
        $stage_no += 1
        if $stage_no >= $totalStage then
            $stage_no = 0
        end

        # ���̃X�e�[�W�̐������J�n����
        $state = $ST_CREATE

        return
    end

    if $state == $ST_PLAY then
        # �Q�[���v���C����Ԃ̏ꍇ�̓v���C���[�̈ړ����s��
        dx = 0              # �v���C���[�L�����N�^x�ړ���
        dy = 0              # �v���C���[�L�����N�^y�ړ���
        isBlockMove = 1     # �u���b�N�ړ�����t���O
        isStageClear = 1    # �X�e�[�W�N���A����t���O

        # �f�W�^���p�b�h���͂ɑ΂���ړ�����
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

        # �v���C���[�̈ړ���Ƀu���b�N�����邩�ǂ���
        block = isBlockExist($player.posX + dx, $player.posY + dy)
        if block != nil then
            # �u���b�N�̈ړ���̎Z�o
            blockMoveX = $player.posX + dx * 2
            blockMoveY = $player.posY + dy * 2

            # �u���b�N�̈ړ���ɉ������邩
            if (isBlockExist(blockMoveX, blockMoveY) == nil) &&
               (getStageData(blockMoveX, blockMoveY) != $DT_WALL) then
                # �u���b�N�̈ړ���Ƀu���b�N���ǂ��Ȃ���Έړ��\
                block.moveTo(blockMoveX, blockMoveY)
            else
                # �u���b�N���ړ��ł��Ȃ�
                isBlockMove = 0
            end
        end

        # �S�[������
        $blockList.each { |block|
            if getStageData(block.posX, block.posY) != $DT_GOAL then
                # �u���b�N���S�[���̏�ɖ�����΃X�e�[�W�N���A����t���O��0�ɂ���
                isStageClear = 0
            end
        }

        # �v���C���[�̈ړ�
        if (getStageData($player.posX + dx, $player.posY + dy) != $DT_WALL) &&
           (isBlockMove == 1) then
            $player.moveTo($player.posX + dx, $player.posY + dy)
        end

        # �N���A����
        if isStageClear == 1 then
            GNDrawImage(80, 70, "clear.gbf")
            $state = $ST_CLEAR
        end
    end
end
