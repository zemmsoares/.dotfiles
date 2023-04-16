#!/bin/sh
# i3block for displaying the number of torrents that are currently downloading, paused and being seeded

torrents=$(transmission-remote -l)
downloading=$(echo "$torrents" | grep "Downloading\|Up & Down" | wc -l)
paused=$(echo "$torrents" | grep "Stopped" | wc -l)
seeding=$(echo "$torrents" | grep "Seeding" | wc -l)
idle=$(echo "$torrents" | grep "Idle" | wc -l)

echo "📥$downloading 🛑 $paused 📤 $seeding 🗄️ $idle"
