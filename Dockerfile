FROM ubuntu:20.04

# Créer un utilisateur non-root
RUN useradd -m iceuser

# Installer Icecast2
RUN apt-get update && \
    apt-get install -y icecast2 && \
    apt-get clean

# Copier la config
COPY icecast.xml /etc/icecast2/icecast.xml

# Donner les droits à l'utilisateur
RUN chown -R iceuser /etc/icecast2

# Exposer le port
EXPOSE 8000

# Lancer Icecast2 en tant qu'utilisateur non-root
USER iceuser
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
