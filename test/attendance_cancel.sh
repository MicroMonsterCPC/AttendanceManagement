curl -X POST \
    http://localhost:4567/protect/attendances/cancel \
    -H 'Content-Type: application/json' \
    -u foo:bar \
    -d '{"idm": "0101031299182322"}'
