# Docker image to use.
FROM sloopstash/base:v1.1.1

# Install system packages.
RUN yum install -y libcurl openssl xz-libs

# Switch work directory.
WORKDIR /etc/prometheus

 
# Download, extract, and install Prometheus
RUN set -x \
  && wget https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-amd64.tar.gz
  && tar xzf prometheus-2.51.2.linux-amd64.tar.gz
  && mv prometheus-2.51.2.linux-amd64/* /etc/prometheus \
  && rm -rf prometheus-2.51.2.linux-amd64.tar.gz \
  && rm -rf prometheus-2.51.2.linux-amd64 \
  && mv /etc/prometheus/prometheus /usr/local/bin/

# Create prometheus.yml  
  # my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]

  history -c  
    



 