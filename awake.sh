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

# OPTION 1
if [ "$opt" == "1" ]; then
    echo ""
    echo "🔧 Configuring SSH keep-alive..."

    mkdir -p ~/.ssh
    CONFIG_FILE="$HOME/.ssh/config"
    touch "$CONFIG_FILE"

    grep -q "ServerAliveInterval" "$CONFIG_FILE" || {
        echo "" >> "$CONFIG_FILE"
        echo "Host *" >> "$CONFIG_FILE"
        echo "    ServerAliveInterval 60" >> "$CONFIG_FILE"
        echo "    ServerAliveCountMax 20" >> "$CONFIG_FILE"
    }

    echo ""
    echo "✅ Done!"
    echo "👉 SSH will now stay alive ~20 minutes tolerance"
fi

# OPTION 2
if [ "$opt" == "2" ]; then
    echo ""
    echo "📦 Installing tmux..."

    sudo apt update -y
    sudo apt install tmux -y

    echo ""
    echo "✅ tmux installed!"

    read -p "Start tmux session now? (y/n): " tstart

    if [ "$tstart" == "y" ]; then
        read -p "Session name (default: work): " sname
        sname=${sname:-work}

        tmux new-session -d -s "$sname"
        echo "🚀 Session '$sname' started"

        read -p "Run a command inside tmux? (y/n): " rcmd
        if [ "$rcmd" == "y" ]; then
            read -p "Enter command: " cmd
            tmux send-keys -t "$sname" "$cmd" C-m
        fi

        echo "👉 Attach with: tmux attach -t $sname"
    fi
fi

# OPTION 3
if [ "$opt" == "3" ]; then
    echo ""
    echo "==================== README ===================="
    echo ""
    echo "1) SSH KEEPALIVE"
    echo "- Prevents disconnects"
    echo "- 20 min tolerance"
    echo ""
    echo "2) TMUX"
    echo "- Keeps sessions alive"
    echo "- Works even if SSH drops"
    echo ""
    echo "Commands:"
    echo "tmux attach"
    echo "tmux ls"
    echo "tmux kill-session -t name"
    echo "================================================"
fi

echo ""
echo "👋 Done."
