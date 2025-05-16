#!/bin/bash
echo "Stopping any running FinTrack service..."
pkill -f app.py || true
