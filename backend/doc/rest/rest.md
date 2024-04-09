# signup
```bash
curl  -X POST \
  'http://localhost:8090/api/v1/signup' \
  --header 'Accept: */*' \
  --header 'User-Agent: Thunder Client (https://www.thunderclient.com)' \
  --header 'Content-Type: application/json' \
  --data-raw '{
  "full_name": "navas",
  "email": "navas@email.com",
  "password": "123456",
  "password_confirmation": "123456"
}'
```
### response 201
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhbGwiLCJleHAiOjE3MTI2MzQwNzAsImp0aSI6ImIwZWVhZWE0LThlYjctNDA5OC04ODNkLTEzYWRlZTEwYjEwNSIsImlhdCI6MTcxMjYzMzE3MCwiaXNzIjoiNWYyM2FhNDAtOWU4ZC00MWI2LTllODItYjQwNDdmMjA3MzFlIiwibmJmIjoxNzEyNjMzMTcwLCJzdWIiOiI2NDAwZDJiNC04NGI5LTQ2NTYtOTFmZC1hMzQ4NzQzMmQ5MTMifQ.RF33pmxOWqF0uxXTp3wTw1T95N1M6J_0vXMyB_EHS84"
}
```
### response 400
```json
{
  "message": "any error"
}
```

## signin
```bash
curl  -X POST \
  'http://localhost:8090/api/v1/signin' \
  --header 'Accept: */*' \
  --header 'User-Agent: Thunder Client (https://www.thunderclient.com)' \
  --header 'Content-Type: application/json' \
  --data-raw '{
  "email": "navas@email.com",
  "password": "123456"
}'
```
### response 200
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhbGwiLCJleHAiOjE3MTI2MzQwNzAsImp0aSI6ImIwZWVhZWE0LThlYjctNDA5OC04ODNkLTEzYWRlZTEwYjEwNSIsImlhdCI6MTcxMjYzMzE3MCwiaXNzIjoiNWYyM2FhNDAtOWU4ZC00MWI2LTllODItYjQwNDdmMjA3MzFlIiwibmJmIjoxNzEyNjMzMTcwLCJzdWIiOiI2NDAwZDJiNC04NGI5LTQ2NTYtOTFmZC1hMzQ4NzQzMmQ5MTMifQ.RF33pmxOWqF0uxXTp3wTw1T95N1M6J_0vXMyB_EHS84"
}
### response 400
```json
{
  "message": "any error"
}
```