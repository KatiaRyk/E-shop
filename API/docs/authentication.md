# Авторизация через Bearer Token (JWT)
## Пример запроса на аутентификацию
Для получения токена аутентификации выполните запрос на эндпоинт /login.

# Пример запроса:
curl -X POST "https://virtserver.swaggerhub.com/KATIARYK_1/Iba//login" \
-H "Content-Type: application/json" \
-d '{
  "username": "example@example.com", 
    "password": "password"
}'
