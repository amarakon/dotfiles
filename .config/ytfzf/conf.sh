video() {
    cd ~/.local/share/yt-dlp/Videos && tmpfile=`mktemp -t ytfzf-video.XXXXXX` && downloader --sponsorblock-mark all -f 'bestvideo[ext=mkv]+bestaudio[ext=flac]/bestvideo+bestaudio' --merge-output-format mkv "$@" --exec "echo %(filepath)q >> $tmpfile" && $PLAYER --player-operation-mode=pseudo-gui --playlist=$tmpfile
}

audio() {
    cd ~/.local/share/yt-dlp/Videos && tmpfile=`mktemp -t ytfzf-audio.XXXXXX` && downloader --sponsorblock-remove all -f 'bestaudio/best' -x --audio-format flac "$@" --exec "echo %(filepath)q >> $tmpfile" && $PLAYER --player-operation-mode=pseudo-gui --playlist=$tmpfile
}

pages_to_scrape=3
