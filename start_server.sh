#!/bin/bash
cd /opt/fintrack
source venv/bin/activate
echo "Starting Flask app..."
nohup python3 app.py > app.log 2>&1 &
