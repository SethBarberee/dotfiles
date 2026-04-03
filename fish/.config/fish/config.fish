if status is-interactive
# Commands to run in interactive sessions can go here
end

function fish_prompt
    powerline-shell --shell bare $status
end

# I can ask nicely
alias please='sudo $(fc -ln -1)'

# Nice aliases for when I just wanna listen/watch random stuff from YouTube
function yta
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$argv"
end

function yt
    mpv ytdl://ytsearch:"$argv"
end


# Set up DevKitArt for my GBADev stuff
export DEVKITPRO=/opt/devkitpro
export DEVKITARM={$DEVKITPRO}/devkitARM
export DEVKITPPC={$DEVKITPRO}/devkitPPC
export PATH="$PATH:{$DEVKITPRO}/tools/bin"

# Set nvim as pager
export PAGER="nvim +Man!"
export EDITOR="nvim"
