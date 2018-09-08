# copy from https://misc.flogisoft.com/bash/tip_colors_and_formatting#terminals_compatibility
# implementaion https://github.com/fatih/color/blob/master/color.go
#
# Format: <Esc>[<FormatCode>m<text><Esc>[<ResetCode>m
#   <ESC>: \e, \033, \x1b
#
# FormatCode:
#   Set: 1-8
#       Effect: Bold Faint Italic Underline BlinkSlow BlinkRapid ReverseVideo Concealed CrossedOut
#   Reset: 0, 21-28
#
#   Colors:
#     8/16 colors: (The following colors works with most terminals and terminals emulators)
#       Foreground: 39, 30-37, 90-97
#       Background: 49, 40-47, 100-107
#
#     88/256 colors: (Some terminals can support 88 or 256 colors)
#       Foreground: <Esc>[38;5;<ColorNumber>m
#         <ColorNumber>: 0-255
#       Background: <Esc>[48;5;<ColorNumber>m
#         <ColorNumber>: 0-255
#
#   Attribute combinations: separated by a semicolon (";").

# Terminals compatibility
# Terminal	        Formatting	                            Colors	        Comment
#                   Bold Dim Underlined Blink Invert Hidden	8	16	88	256
# aTerm	            ok	-	ok	-	ok	-	                ok	~	-	-	Lighter background instead of blink.
# Eterm	            ~	-	ok	-	ok	-	                ok	~	-	ok	Lighter color instead of Bold. Lighter background instead of blink. Can overline a text with the “^[[6m” sequence.
# GNOME Terminal    ok	ok	ok	-	ok	ok	                ok	ok	-	ok	Strikeout with the “^[[9m” sequence.
# Guake	            ok	ok	ok	-	ok	ok	                ok	ok	-	ok	Strikeout with the “^[[9m” sequence.
# Konsole           ok	-	ok	ok	ok	-	                ok	ok	-	ok
# Nautilus Terminal	ok	ok	ok	-	ok	ok	                ok	ok	-	ok	Strikeout with the “^[[9m” sequence.
# rxvt	            ok	-	ok	~	ok	-	                ok	ok	ok	-	If the background is not set to the default color, Blink make it lighter instead of blinking. Support of italic text with the “^[[3m” sequence.
# Terminator        ok	ok	ok	-	ok	ok	                ok	ok	-	ok	Strikeout with the “^[[9m” sequence.
# Tilda	            ok	-	ok	-	ok	-	                ok	ok	-	-	Underline instead of Dim. Convert 256-colors in 16-colors.
# XFCE4 Terminal    ok	ok	ok	-	ok	ok	                ok	ok	-	ok	Strikeout with the “^[[9m” sequence.
# XTerm	            ok	-	ok	ok	ok	ok	                ok	ok	-	ok
# xvt               ok	-	ok	-	ok	-	                -	-	-	-
# Linux TTY	        ok	-	-	-	ok	-	                ok	~	-	-	Specials colors instead of Dim and Underlined. Lighter background instead of Blink, Bug with 88/256 colors.
# VTE Terminal 	    ok	ok	ok	-	ok	ok	                ok	ok	-	ok	Strikeout with the “^[[9m” sequence.

echoColors16() {
    #Background
    for clbg in {40..47} {100..107}; do
        #Foreground
        for clfg in {30..37} {90..97}; do
            #Print the result
            echo -en "\e[${clbg};${clfg}m ^[${clbg};${clfg}m \e[0m"
        done
        echo #Newline
    done

    #Formatting
    clbg=49
    clfg=39
    for attr in {1..8} ; do
        #Print the result
        echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
    done
    echo #Newline
}

echoColors256() {
    for fgbg in 38 48 ; do # Foreground / Background
        for color in {0..255} ; do # Colors
            # Display the color
            printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
            # Display 6 colors per lines
            if [ $((($color + 1) % 6)) = 4 ] ; then
                echo # New line
            fi
        done
        echo # New line
    done
}
