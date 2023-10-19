# Network Interface Bridging Script

## Overview

This script is designed to bridge network interfaces on a Linux system, allowing you to connect and route traffic between two interfaces. Bridging network interfaces can be useful in various scenarios, such as creating a software-based switch for virtual machines or combining multiple physical interfaces into a single network connection.
For example, say you want to bridge your ethernet interface to your wifi interface (in this case I am assuming your wifi interface is the one connected to the internet). Well then this script can help with that

**Note**: This script requires administrative privileges to configure network interfaces and firewall rules.

## Prerequisites

Before using this script, ensure you have the following prerequisites in place:

1. A Linux system with multiple network interfaces.
2. Administrative access or superuser (root) privileges.

## Usage

To use the script, follow these steps:

1. Clone this repository or download the script to your Linux system.

   ```bash
   git clone https://github.com/tendai98/Net-Bridge.git
   ```

2. Open a terminal and navigate to the directory where the script is located.

   ```bash
   cd Net-Bridge.git
   ```

3. Make the script executable, if needed.

   ```bash
   chmod +x init-bridge.sh
   ```

4. Run the script with the following arguments:

   - `<input-interface>`: The network interface to bridge from.
   - `<output-interface>`: The network interface to bridge to.
   - `<gateway-ip>`: The IP address to assign to the input interface.

   For example:

   ```bash
   ./init-bridge.sh enp4s0 wlp3s0 192.168.90.1
   ```

   If you're unsure about the arguments, you can run the script without any arguments to see a usage example.

   ```bash
   ./init-bridge.sh
   ```

5. The script will configure the network interfaces and enable IP forwarding on your system. It will also set up firewall rules to allow traffic to pass through the bridge.

6. Once the script completes its execution, your network interfaces should be bridged, and traffic can flow between them.

## Configuration

The script includes the following configuration options:

- **IP Forwarding**: The script enables IP forwarding, which allows your Linux system to route traffic between the bridged interfaces. This can be further customized to suit your network needs.

- **Firewall Rules**: The script sets up basic firewall rules to allow traffic to flow through the bridge. You can modify the rules in the script to meet your specific requirements.

- **Interface Configuration**: The script uses `busybox ifconfig` to configure the input interface with the specified `<gateway-ip>`. You can customize this part of the script to meet your network's addressing needs.

- **DHCP Server**: The script starts a DHCP server on the input interface to provide IP addresses to devices connected to the bridge. You can adjust the DHCP configuration by editing the `dhcp.conf` file.

## Note
 - **I included an busybox binary so that the script works out of the box, but you can use your own busybox installation

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
