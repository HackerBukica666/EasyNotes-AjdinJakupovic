# 1. Node.js-Image als Basis auswählen
FROM node:18-alpine

# 2. Benutzer erstellen
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# 3. Arbeitsverzeichnis setzen
WORKDIR /app

# 4. Anwendungsdateien kopieren
COPY package*.json ./
COPY . .

# 5. Packages installieren
RUN npm install

# 6. Anwendung bauen
RUN npm run build

# 7. Berechtigungen für den appuser setzen
RUN chown -R appuser:appgroup /app

# 8. Port freigeben
EXPOSE 8080

# 9. Auf nicht-root-Benutzer wechseln
USER appuser

# 10. Anwendung starten (korrigiert)
CMD ["node", "dist/app.js"]