#!/bin/bash
echo "Stopping Flask app..."
pkill -f app.py || true
