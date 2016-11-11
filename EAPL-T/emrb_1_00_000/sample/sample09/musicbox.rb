# ��Ԃ̒�`
$ST_STOP = 0
$ST_PLAY = 1

# 1:�h 2:�� 3:�~ 4:�t�@ 5:�\ 6:�� 7:�V 8:�h
$musicData = [
    1, 1, 5, 5, 6, 6, 5, 0, 4, 4, 3, 3, 2, 2, 1, 0
]
$musicLength = $musicData.size

# �Đ��ƒ�~��؊�����l(���̖͂��邳�ɂ���Ē������Ă�������)
$light_val = 150

# ���C��������
#-----------------------------------------------------------------------------
def setup()
    # ��Ԃ̏�����
    $state = $ST_STOP

    # �J�E���^�̏�����
    $tic = 0
    $playCount = 0

    # ���邳�\�����i�̐���
    $numbmp1 = GNDigitalNum.new(10, 10)

    gr_pinMode($PIN_IO8, $OUTPUT)
end

# ���C�����[�v
#-----------------------------------------------------------------------------
def loop()
    # ���邳�̎擾
    light = gr_analogRead($PIN_AN5)
    $numbmp1.setInteger(light)

    case $state
    when $ST_STOP
        # ��~��Ԃ̏ꍇ
        if light < $light_val then
            $state = $ST_PLAY
            $tic = 0
            $playCount = 0
        end
    when $ST_PLAY
        # �Đ���Ԃ̏ꍇ
        if light >= $light_val then
            $state = $ST_STOP
        end
    end

    # �Đ���ԂȂ�΃����f�B�̍Đ����s���܂�
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

# ���K�Đ�
def playMelody( tone )
    case tone
    when 0
        # �����~�߂�
        gr_noTone($PIN_IO8)
    when 1
        # �h�̉�
        gr_tone($PIN_IO8, 523, 500)
    when 2
        # ���̉�
        gr_tone($PIN_IO8, 587, 500)
    when 3
        # �~�̉�
        gr_tone($PIN_IO8, 659, 500)
    when 4
        # �t�@�̉�
        gr_tone($PIN_IO8, 698, 500)
    when 5
        # �\�̉�
        gr_tone($PIN_IO8, 783, 500)
    when 6
        # ���̉�
        gr_tone($PIN_IO8, 880, 500)
    when 7
        # �V�̉�
        gr_tone($PIN_IO8, 986, 500)
    when 8
        # �h�̉�
        gr_tone($PIN_IO8, 1046, 500)
    end
end
