concat-mp4-files() {
    # thanks to https://raw.githubusercontent.com/falconws/concat_movie/master/concat.py
    # require ffmpeg version 1.1 or higher
    # e.g. concat-mp4-files $(ls *.mp4)

    listfile=mp4filelist.txt
    outputfile=output.mp4

    [ -f $outputfile ] && rm $outputfile
    [ -f $listfile ] && rm $listfile

    for x in $@; do
        # ignore exist output file
        if [ $x != $outputfile ]; then
            echo file "'$x'" >> $listfile
        fi
    done
    cat $listfile

    ffmpeg -y -f concat -i $listfile -c copy $outputfile &>/dev/null && echo && echo Generated $outputfile
    rm $listfile
}
