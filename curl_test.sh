echo "Error curl"
curl \
    -X POST \
    -u foo:bar \
    http://localhost:4567/attendances/is-exists-idm \
    -H 'Content-Type: application/json' \
    -d '{"idm": "1145141919810"}'

echo "\n"
echo "Succes curl"

curl \
    -X POST \
    -u foo:bar \
    http://localhost:4567/attendances/is-exists-idm \
    -H 'Content-Type: application/json' \
    -d '{"idm": "0101031299182322"}'
