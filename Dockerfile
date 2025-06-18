# Étape 1 : Build avec Node 22
FROM node:22 AS builder

# Définir le dossier de travail
WORKDIR /app

# Copier les fichiers nécessaires
COPY package*.json ./
COPY vite.config.* ./
COPY . .

# Installer les dépendances
RUN npm install

# Construire l'application pour la production
RUN npm run build

# Étape 2 : Utiliser une image nginx pour servir les fichiers statiques
FROM nginx:alpine

# Copier les fichiers build dans le répertoire nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Supprimer la config nginx par défaut et ajouter la tienne (optionnel)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port
EXPOSE 80

# Lancer nginx
CMD ["nginx", "-g", "daemon off;"]
