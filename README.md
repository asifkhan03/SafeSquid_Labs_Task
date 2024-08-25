# SafeSquid_Labs_Task
For Task-1 (Monitoring System Resources for a Proxy Server)

## Prerequisites

Before running the script, ensure the following prerequisites are met:

1. **Operating System**: The script is designed for Linux systems.
2. **Bash Shell**: Ensure you have a Bash shell available (common in most Linux distributions).
3. **Required Utilities**: The script uses several standard Linux utilities. Make sure these are installed on your system:
   - `ps`: Process monitoring tool.
   - `netstat`: Network statistics tool (can be replaced by `ss` in some modern systems).
   - `df`: Disk space usage tool.
   - `free`: Memory usage reporting tool.
   - `ifstat`: Network interface statistics tool (install it using your package manager if not available).
   - `systemctl`: Service management tool.

### Installing Required Utilities
- **Debian/Ubuntu**:
  sudo apt-get update
  sudo apt-get install procps net-tools ifstat

- **RedHat/CentOS**:
 sudo yum install procps-ng net-tools ifstat

## Instructions to perform the task:

- **Save the script above as 'system_monitor.sh'**
Run the following command to make the script executable
         chmod +x system_monitor.sh

- **Run the script:**
For the full dashboard with automatic refresh
   ./system_monitor.sh

To view specific parts of the dashboard, use the CLI switches. 
For example:  
./system_monitor.sh --cpu
      
       Available switches are --cpu, --network, --disk, --load, --memory, --processes, and -- 
       services










