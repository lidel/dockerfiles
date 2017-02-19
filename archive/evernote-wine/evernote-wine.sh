#!/bin/bash
echo "Starting Evernote with Wine $(wine --version)"

echo "==> Loading wineboot"
WINEDLLOVERRIDES="mshtml,mscoree=" wineboot -u

if [ ! -f /evernote/.wine/drive_c/Program\ Files/Evernote/Evernote/Evernote.exe ]; then
    echo "==> Running Winetricks Install"
    winetricks -q corefonts
    winetricks -q settings fontsmooth=rgb

    echo "==> Running Evernote Install"
    echo "Please wait, downloading binary from evernote.com..."
    aria2c "https://evernote.com/download/get.php?file=Win" \
           --file-allocation=none \
           --summary-interval=5 \
           -c -d /evernote -o evernote.exe && \
    wine /evernote/evernote.exe
    wineserver --wait

fi

echo "==> Running Evernote"
exec wine /evernote/.wine/drive_c/Program\ Files/Evernote/Evernote/Evernote.exe


echo "==> Waiting for clean wineserver shutdown (run 'make stop' in new terminal to force-kill)"
wineserver --wait
