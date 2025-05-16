#!/bin/bash
cd /home/ec2-user/fintrack
echo "Creating virtual environment and installing dependencies..."
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
