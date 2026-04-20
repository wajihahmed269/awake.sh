# awake.sh

==================== README ====================

🔥 WHAT THIS TOOL DOES

1) SSH KEEPALIVE MODE
- Prevents EC2 SSH disconnects
- Sends heartbeat every 60 seconds
- Allows ~20 min idle tolerance

2) TMUX MODE
- Keeps sessions alive even if SSH dies
- Perfect for long installs (Kubernetes, builds, logs)
- You can detach and reattach anytime

KEY COMMANDS:

Detach tmux:
CTRL + B then D

Reattach:
tmux attach

List sessions:
tmux ls

Kill session:
tmux kill-session -t name

================================================
EOF
fi

echo ""
echo "👋 Done. Re-run ./awake.sh anytime."

🔥 Make it executable
chmod +x awake.sh

Run it:

./awake.sh

git clone https://github.com/wajihahmed269/awake.sh.git

to run this
