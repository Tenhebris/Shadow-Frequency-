FROM ubuntu:20.04

# Create non-root user
RUN useradd -m iceuser

# Install Icecast2 and dependencies
RUN apt-get update && \
    apt-get install -y icecast2 mime-support && \
    apt-get clean

# Create log directory
RUN mkdir -p /var/log/icecast && \
    chown -R iceuser /var/log/icecast

# Create web/admin directories to avoid startup errors
RUN mkdir -p /usr/share/icecast2/web && \
    mkdir -p /usr/share/icecast2/admin && \
    chown -R iceuser /usr/share/icecast2

# Copy config
COPY icecast.xml /etc/icecast2/icecast.xml

# Set permissions
RUN chown -R iceuser /etc/icecast2

# Expose port
EXPOSE 8000

# Run Icecast2 as non-root
USER iceuser
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
