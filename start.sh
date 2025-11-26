#!/bin/bash

echo "🚀 Starting Beefree SDK Simple Schema Demo"
echo "=========================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are installed"

# Check if node_modules exists, if not install dependencies
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
    if [ $? -ne 0 ]; then
        echo "❌ Failed to install dependencies"
        exit 1
    fi
    echo "✅ Dependencies installed successfully"
else
    echo "✅ Dependencies already installed"
fi

# Check if credentials.js exists
if [ ! -f "credentials.js" ]; then
    echo "❌ credentials.js file not found!"
    echo "Please create a credentials.js file with your API keys:"
    echo ""
    echo "const credentials = {"
    echo "    client_id: 'your_beefree_client_id',"
    echo "    client_secret: 'your_beefree_client_secret',"
    echo "    beefree_api_key: 'your_beefree_api_key',"
    echo "    anthropic_api_key: 'your_anthropic_api_key'"
    echo "};"
    echo ""
    echo "module.exports = credentials;"
    exit 1
fi

echo "✅ credentials.js file found"

echo ""
echo "🌐 Starting the proxy server..."
echo "The demo will be available at: http://localhost:3000"
echo ""
echo "📝 How to use:"
echo "1. Open http://localhost:3000 in your browser"
echo "2. Describe the email you want to create in the chat"
echo "3. The AI will generate a simple JSON template"
echo "4. The template will be converted to full JSON using Beefree API"
echo "5. Click 'Edit your design in the builder' to open the Beefree SDK"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start the proxy server
node proxy-server.js