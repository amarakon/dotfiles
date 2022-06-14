video() {
    cd ~/.local/share/yt-dlp/Videos && downloader --sponsorblock-mark all -f 'bestvideo[ext=mkv]+bestaudio[ext=flac]/bestvideo+bestaudio' --merge-output-format mkv "$@" | dmenu -i -l 10 
}

audio() {
    cd ~/.local/share/yt-dlp/Audio && downloader --sponsorblock-remove all -f 'bestaudio/best' -x --audio-format flac "$@" | dmenu -i -l 10
}

pages_to_scrape=3
