# �X���̒��S�l�̐ݒ�(�Z���T�𐅕��ȏꏊ�ɒu���Ē������Ă�������)
$centerX = 336
$centerY = 336
$margin  = 4

# �\�������`�̑傫��
$sizeX = 24
$sizeY = 24

# ���C��������
#-----------------------------------------------------------------------------
def setup()
    # �X���̒l��\�����镔�i��z�u
    $numbmp1 = GNDigitalNum.new(10, 10)
    $numbmp2 = GNDigitalNum.new(10, 30)

    # �\���ʒu
    $posX = 120
    $posY = 160
    $newX = 120
    $newY = 160

    # �ړ��͈�
    $posXmin = 0
    $posYmin = 0
    $posXmax = 240 - $sizeX
    $posYmax = 320 - $sizeY
end

# ���C�����[�v
#-----------------------------------------------------------------------------
def loop()
    # x�����X���̎擾
    axisX = gr_analogRead($PIN_AN4)
    $numbmp1.setInteger(axisX)

    # y�����X���̎擾
    axisY = gr_analogRead($PIN_AN5)
    $numbmp2.setInteger(axisY)

    # �ړ��ʂ���U0�ɂ��܂�
    velX = 0
    velY = 0

    # x�����̌X���ɂ����x�����̈ړ��ʂ����߂܂�
    if axisX > ($centerX + $margin) then
        velX = 1
    end
    if axisX < ($centerX - $margin) then
        velX = -1
    end

    # y�����̌X���ɂ����y�����̈ړ��ʂ����߂܂�
    if axisY > ($centerY + $margin) then
        velY = 1
    end
    if axisY < ($centerY - $margin) then
        velY = -1
    end

    # �V����x���W���v�Z���܂�
    $newX = $posX + velX

    # ��ʂ̒[�ł͎~�܂�܂�
    if $newX > $posXmax then
        $newX = $posXmax
    end
    if $newX < $posXmin then
        $newX = $posXmin
    end

    # �V����y���W���v�Z���܂�
    $newY = $posY + velY

    # ��ʂ̒[�ł͎~�܂�܂�
    if $newY > $posYmax then
        $newY = $posYmax
    end
    if $newY < $posYmin then
        $newY = $posYmin
    end

    # �ړ����Ă���ꍇ�͋�`�̕\�����X�V���܂�
    if $posX != $newX || $posY != $newY then
        # ���݈ʒu������
        GNDrawRect($posX, $posY, $sizeX, $sizeY, 31, 31, 31)

        # �V�����ʒu�ɕ`��
        GNDrawRect($newX, $newY, $sizeX, $sizeY, 0, 0, 0)

        # �`��ʒu�̍X�V
        $posX = $newX
        $posY = $newY
    end
end
