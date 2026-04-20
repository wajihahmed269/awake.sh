
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

    cat >> "$CONFIG_FILE" <<EOF

Host *
    ServerAliveInterval 60
    ServerAliveCountMax 20
EOF

    echo ""
    echo "✅ Done!"
    echo "👉 SSH will now stay alive ~20 minutes of inactivity tolerance"
    echo "👉 Active connection = stays alive indefinitely"
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

        echo ""
        echo "👉 Attach with: tmux attach -t $sname"
    fi
fi

# -------------------------------------
# OPTION 3 - README
# -------------------------------------
if [ "$opt" == "3" ]; then

cat <<EOF

if [ "$opt" == "3" ]; then
    echo ""
    echo "==================== README ===================="
    echo ""
    echo "🔥 WHAT THIS TOOL DOES"
    echo ""
    echo "1) SSH KEEPALIVE MODE"
    echo "- Prevents SSH disconnects"
    echo "- Sends heartbeat every 60 seconds"
    echo "- Allows ~20 min idle tolerance"
    echo ""
    echo "2) TMUX MODE"
    echo "- Keeps sessions alive even if SSH drops"
    echo "- Ideal for long-running tasks"
    echo ""
    echo "KEY COMMANDS:"
    echo ""
    echo "Detach tmux:"
    echo "CTRL + B then D"
    echo ""
    echo "Reattach:"
    echo "tmux attach"
    echo ""
    echo "List sessions:"
    echo "tmux ls"
    echo ""
    echo "Kill session:"
    echo "tmux kill-session -t name"
    echo ""
    echo "================================================"
fi

echo ""
echo "👋 Done. Run ./awake.sh again anytime."
