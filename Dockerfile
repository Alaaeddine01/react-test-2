# Étape 1 : Build de l'app React avec Vite
FROM node:22-alpine AS build

WORKDIR /app

# Copier package.json et package-lock.json (ou yarn.lock)
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier tout le reste des fichiers
COPY . .

# Build de l'app pour la production
RUN npm run build

# Étape 2 : Servir l'app avec un serveur Nginx léger
FROM nginx:alpine

# Copier le build de Vite vers le dossier Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx en premier plan
CMD ["nginx", "-g", "daemon off;"]
