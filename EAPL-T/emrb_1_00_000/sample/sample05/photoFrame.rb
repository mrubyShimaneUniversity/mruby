#=============================================================================
# メイン初期化
#-----------------------------------------------------------------------------
def setup()
    $counter = 0
    $photoNo = 0
end

# メインループ
#-----------------------------------------------------------------------------
def loop()
    if $counter == 0 then
        case $photoNo
            when 0 then
                GNDrawImage(0, 0, "tile.gbf")
            when 1 then
                GNDrawImage(0, 0, "bluesky.gbf")
            when 2 then
                GNDrawImage(0, 0, "flower.gbf")
            when 3 then
                GNDrawImage(0, 0, "green.gbf")
            when 4 then
                GNDrawImage(0, 0, "leaf.gbf")
        end
    end

    $counter += 1
    if $counter >= 50000 then
        $counter = 0
        $photoNo += 1
        if $photoNo >= 5 then
            $photoNo = 0
        end
    end
end
