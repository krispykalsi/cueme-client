#!/bin/sh

# Set the port
PORT=5000

# switch directories
cd build/web/ || exit

# Start the server
echo 'Server starting on port' $PORT '...'
python3 -m http.server $PORT