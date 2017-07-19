curl -X POST \
    http://localhost:4567/protect/attendances/create \
    -H 'Content-Type: application/json' \
    -u foo:bar \
    -d '{"idm": "0101031299182322", "datetime": "'"$(date +"%Y/%m/%d %I:%M:%S") "'" }'
