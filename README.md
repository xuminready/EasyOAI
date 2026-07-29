# EasyOAI

EasyOAI is a simplified deployment project for OpenAirInterface (OAI) 5G components. It provides a pre-configured environment to quickly set up a 5G Core Network (CN) and a Next-Generation NodeB (gNB) using Docker containers.

## Project Structure

- `oai-cn5g/`: Contains the 5G Core Network configuration and Docker Compose files.
  - `docker-compose.yaml`: The main orchestration file for all 5G Core services and the gNB.
  - `conf/`: Configuration files for the 5G Core functions (AMF, SMF, UPF, etc.).
  - `database/`: SQL scripts for initializing the OAI database.
  - `healthscripts/`: Scripts for health checks of the services.
- `GENERIC-NR-5GC/`: Contains configuration files for the Next-Generation NodeB (gNB).
  - `CONF/`: Various gNB configuration files for different bands and PRB settings (default is band 78).
- `start.sh`: A helper script to start the 5G Core and gNB components.

## Prerequisites

- **Operating System**: Linux (tested on Ubuntu).
- **Docker**: Installed and running.
- **Docker Compose**: Installed (version 2.x recommended).
- **Hardware (Optional)**: A USRP B210 or similar SDR if you intend to run the gNB with physical hardware.

## Installation & Usage

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd EasyOAI
   ```

2. **Start the 5G Stack**:
   You can use the provided helper script:
   ```bash
   ./start.sh
   ```
   Or run docker-compose directly:
   ```bash
   cd oai-cn5g
   docker compose up -d
   ```

3. **Verify the Deployment**:
   Check the status of the containers:
   ```bash
   docker compose ps
   ```
   Follow the gNB logs to ensure it's running correctly:
   ```bash
   docker logs oai-cn5g-oai-gnb-1 --follow
   ```

## Configuration

### gNodeB (gNB)
The gNB configuration is located in `GENERIC-NR-5GC/CONF/`. By default, the `docker-compose.yaml` maps:
`../GENERIC-NR-5GC/CONF/gnb.sa.band78.fr1.106PRB.usrpb210.conf` to the gNB container.

If you need to use a different configuration (e.g., a different band or PRB count), update the volume mapping in `oai-cn5g/docker-compose.yaml`.

### 5G Core (CN)
The Core Network parameters (PLMN, MNC, MCC, DNN, etc.) are defined in `oai-cn5g/conf/config.yaml`.

## Troubleshooting

- **Hardware Access**: Ensure the USRP is connected and accessible by the host. The `oai-gnb` container runs in privileged mode with access to `/dev/bus/usb/`.
- **Network Mode**: The gNB is configured in `host` network mode for performance reasons. Ensure there are no port conflicts on the host.
- **Database Issues**: If the services fail to connect to the database, ensure the `mysql` container is healthy.

## License
See the `LICENSE` file for details.