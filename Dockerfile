# =========================================
# Stage 1: Build de l'application Vue.js
# =========================================
FROM node:20-alpine AS builder

WORKDIR /build

# Copier les fichiers package
COPY app/package.json app/package-lock.json ./

# Installer les dépendances
RUN npm ci

# Copier le code source
COPY app/ ./

# Build de production
RUN npm run build

# =========================================
# Stage 2: Servir avec Nginx
# =========================================
FROM nginx:alpine AS production

# Copier la configuration Nginx personnalisée
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier les fichiers build depuis l'étape précédente
COPY --from=builder /build/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
