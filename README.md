# Vue Blog Application

Это веб-приложение, состоящее из Vue.js фронтенда и Rails API бэкенда, объединенных в единое приложение с помощью Docker и Kubernetes.

## Архитектура

- **Frontend**: Vue.js приложение с Vite
- **Backend**: Rails API-only приложение
- **База данных**: PostgreSQL
- **Контейнеризация**: Docker
- **Оркестрация**: Kubernetes (Minikube для локальной разработки)

## Запуск приложения

### 1. Запуск в режиме разработки (через Docker Compose)

Для локальной разработки с возможностью горячей перезагрузки:

1. Убедитесь, что у вас установлены:
   - Docker
   - Docker Compose

2. Запустите приложение:

```bash
docker-compose up --build
```

3. Приложение будет доступно по адресу:
   - Frontend: http://localhost:5173
   - Backend: http://localhost:3000

### 2. Запуск через Kubernetes (Minikube)

Для запуска в Kubernetes-кластере (например, для тестирования production-окружения):

1. Убедитесь, что у вас установлены:
   - Minikube
   - kubectl

2. Запустите Minikube:

```bash
minikube start
```

3. Настройте Docker-контекст на Minikube:

```bash
eval $(minikube docker-env)
```

4. Соберите Docker-образы:

```bash
# Для backend
cd backend
docker build -t vue-blog-backend:latest .
cd ..

# Для frontend
cd frontend
docker build -t vue-blog-frontend:latest .
cd ..
```

5. Примените конфигурации Kubernetes:

```bash
kubectl apply -f kubernetes/
```

6. Проверьте статус развёрнутых компонентов:

```bash
kubectl get pods
kubectl get services
```

7. Приложение будет доступно по адресу:

```bash
minikube service frontend-service --url
```

## Структура проекта

- `backend/` - Rails API приложение
- `frontend/` - Vue.js приложение
- `kubernetes/` - Kubernetes конфигурации
- `docker-compose.yml` - Docker Compose конфигурация для локальной разработки

## Технологии

- Ruby 3.2.2
- Rails 7.0.4
- Vue.js
- PostgreSQL 14
- Docker
- Kubernetes
- Nginx

## API маршруты

- `/api/v1/posts` - управление постами
- `/api/v1/sign_up` - регистрация
- `/api/v1/sign_in` - аутентификация
- `/api/v1/profile` - профиль пользователя

## Troubleshooting

Если возникают проблемы с доступом к API из фронтенда, убедитесь, что:
- Nginx правильно проксирует запросы из `/api/` в бэкенд
- Роуты в Rails соответствуют ожидаемым путям
- Бэкенд доступен по внутреннему адресу в кластере

Для проверки логов компонентов в Kubernetes:

```bash
kubectl logs deployment/backend-deployment
kubectl logs deployment/frontend-deployment
```
