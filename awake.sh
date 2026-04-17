#!/bin/bash

clear

echo "====================================="
echo "        ⚡ AWAKENING TOOL ⚡"
echo "====================================="
echo ""
echo "Choose what you want:"
echo ""
echo "1) 🔌 Enable SSH Keep-Alive (20 min safe window)"
echo "2) 🧠 Install + Setup tmux (safe sessions)"
echo "3) 📄 Show README"
echo "4) 🚪 Exit"
echo ""

read -p "Enter option (1-4): " opt

# -------------------------------------
# OPTION 1 - SSH KEEPALIVE
# -------------------------------------
if [ "$opt" == "1" ]; then
    echo ""
    echo "🔧 Configuring SSH keep-alive..."

    mkdir -p ~/.ssh

    CONFIG_FILE="$HOME/.ssh/config"

    touch "$CONFIG_FILE"

    grep -q "ServerAliveInterval" "$CONFIG_FILE" || cat >> "$CONFIG_FILE" <<EOF

Host *
    ServerAliveInterval 60
    ServerAliveCountMax 20
EOF

    echo ""
    echo "✅ Done!"
    echo "👉 SSH will now stay alive ~20 minutes of inactivity tolerance"
    echo "👉 Active connection = stays alive indefinitely"
    echo ""
fi

# -------------------------------------
# OPTION 2 - TMUX INSTALL + SETUP
# -------------------------------------
if [ "$opt" == "2" ]; then
    echo ""
    echo "📦 Installing tmux..."

    sudo apt update -y
    sudo apt install tmux -y

    echo ""
    echo "✅ tmux installed!"

    echo ""
    read -p "Do you want to start a tmux session now? (y/n): " tstart

    if [ "$tstart" == "y" ]; then
        echo ""
        read -p "Enter session name (or press enter for 'work'): " sname

        if [ -z "$sname" ]; then
            sname="work"
        fi

        tmux new-session -d -s "$sname"

        echo ""
        echo "🚀 tmux session '$sname' started in background"

        echo ""
        read -p "Do you want to run a command inside it? (y/n): " rcmd

        if [ "$rcmd" == "y" ]; then
            read -p "Enter command to run: " cmd
            tmux send-keys -t "$sname" "$cmd" C-m
            echo "✅ Command sent to tmux session"
        fi

        echo ""
        echo "👉 To attach later use:"
        echo "tmux attach -t $sname"
    fi
fi

# -------------------------------------
# OPTION 3 - README
# -------------------------------------
if [ "$opt" == "3" ]; then
    echo ""
    cat <<EOF
