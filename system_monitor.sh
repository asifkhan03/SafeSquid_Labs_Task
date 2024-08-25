#!/bin/bash

# Function to display top 10 most used applications by CPU and memory
function top_applications {
    echo "Top 10 Applications by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11
    echo ""
    echo "Top 10 Applications by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 11
}

# Function to monitor network
function network_monitor {
    echo "Network Monitoring:"
    echo "Number of concurrent connections:"
    netstat -an | grep ESTABLISHED | wc -l
    echo "Packet Drops:"
    netstat -s | grep "packets dropped" | tail -1
    echo "Network traffic (MB in and out):"
    ifstat 1 1 | awk 'NR==3 {print "In: "$1" MB, Out: "$2" MB"}'
}

# Function to monitor disk usage
function disk_usage {
    echo "Disk Usage:"
    df -h | awk '{if($5+0 > 80) print "WARNING: " $0; else print $0}'
}

# Function to show system load and CPU usage
function system_load {
    echo "System Load and CPU Usage:"
    uptime
    echo "CPU Usage Breakdown:"
    top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
}

# Function to display memory usage
function memory_usage {
    echo "Memory Usage:"
    free -h | awk 'NR==2{printf "Total: %s, Used: %s, Free: %s\n", $2,$3,$4}'
}

# Function to monitor processes
function process_monitor {
    echo "Process Monitoring:"
    echo "Number of active processes:"
    ps aux | wc -l
    echo "Top 5 processes by CPU usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo "Top 5 processes by Memory usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Function to monitor essential services
function service_monitor {
    echo "Service Monitoring:"
    for service in sshd nginx apache2 iptables; do
        if systemctl is-active --quiet $service; then
            echo "$service is running"
        else
            echo "$service is not running"
        fi
    done
}

# Main script logic for handling command-line switches
if [ $# -eq 0 ]; then
    # No arguments provided, show full dashboard
    while true; do
        clear
        echo "===== System Resource Monitoring Dashboard ====="
        top_applications
        echo ""
        network_monitor
        echo ""
        disk_usage
        echo ""
        system_load
        echo ""
        memory_usage
        echo ""
        process_monitor
        echo ""
        service_monitor
        sleep 5
    done
else
    # Handle command-line switches
    case "$1" in
        --cpu) top_applications ;;
        --network) network_monitor ;;
        --disk) disk_usage ;;
        --load) system_load ;;
        --memory) memory_usage ;;
        --processes) process_monitor ;;
        --services) service_monitor ;;
        *) echo "Usage: $0 [--cpu | --network | --disk | --load | --memory | --processes | --services]" ;;
    esac
fi
