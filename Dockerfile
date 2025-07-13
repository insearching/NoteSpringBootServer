########## Stage 1 – build ##########
FROM gradle:8.5-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle bootJar --no-daemon

########## Stage 2 – runtime ##########
FROM eclipse-temurin:17-jdk-alpine

# --- FIX: add CA certificates (and set timezone if you like) ---
RUN apk add --no-cache ca-certificates tzdata && \
    update-ca-certificates

WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

# Let platforms like Railway/Fly set the port dynamically
ENV PORT 8080
EXPOSE ${PORT}

ENTRYPOINT ["sh", "-c", "exec java -jar app.jar --server.port=${PORT}"]

