
echo "1. Checking Health..."
curl -s http://localhost:8182/health
echo "\n\n2. Signing Up User..."
curl -s -X POST http://localhost:8182/auth/signup -H "Content-Type: application/json" -d "{\"email\": \"test@example.com\", \"password\": \"securePass123!\", \"fullName\": \"Test User\"}"
echo "\n\n3. Logging In..."
curl -s -X POST http://localhost:8182/auth/login -H "Content-Type: application/json" -d "{\"email\": \"test@example.com\", \"password\": \"securePass123!\"}" > token.json
cat token.json
echo "\n\n4. Fetching Profile..."
set /p TOKEN=<token.json
REM Extract token using a simpler method if jq is not available, or just manually for now.
REM For this automated script, we assume successful login returns json.
