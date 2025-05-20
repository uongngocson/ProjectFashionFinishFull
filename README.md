# Fashion Finish Project - Docker Setup

This repository contains Docker configurations for running the Fashion Finish application which consists of:
- Backend Spring Boot API
- Frontend Spring MVC with JSP
- SQL Server Database
- NGINX for routing and SSL termination

## Prerequisites

- Docker and Docker Compose installed on your system
- OpenSSL (for certificate generation)

## Getting Started

### 1. Generate SSL Certificates

Before starting the application, generate self-signed SSL certificates for development:

```bash
chmod +x generate-cert.sh
./generate-cert.sh
```

### 2. Start the Application

```bash
docker-compose up -d
```

This will:
- Build and start the backend API (accessible at https://localhost/api/)
- Build and start the frontend (accessible at https://localhost/)
- Start a SQL Server database
- Configure NGINX as a reverse proxy

### 3. Initialize Database (First Run)

As noted in the original Readme, to set the order sequence:

```bash
docker exec -it fashion-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P YourStrongPassword!23 -Q "ALTER SEQUENCE OrderSequence RESTART WITH 1400;"
```

### 4. Access the Application

- Frontend: https://localhost/
- Backend API: https://localhost/api/
- Actuator Endpoints: https://localhost/actuator/

## Development Workflow

### Rebuilding Services

If you make changes to the code, rebuild the affected service:

```bash
docker-compose build backend
docker-compose build frontend
docker-compose up -d
```

### Viewing Logs

```bash
# View logs for all services
docker-compose logs -f

# View logs for a specific service
docker-compose logs -f backend
docker-compose logs -f frontend
```

### Stopping the Application

```bash
docker-compose down
```

To remove volumes as well (this will delete the database data):

```bash
docker-compose down -v
```

## Security Notes

- This setup uses self-signed certificates for development purposes only
- The SQL Server password in the docker-compose.yml should be changed in production
- For production, replace the self-signed certificates with proper certificates from a trusted CA 