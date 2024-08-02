import psutil
import socket
import time

def get_process_info(conn):
    try:
        proc = psutil.Process(conn.pid)
        return proc.name()
    except psutil.NoSuchProcess:
        return "Unknown"

def monitor_connections():
    existing_connections = set()
    while True:
        connections = psutil.net_connections(kind='inet')
        for conn in connections:
            if conn.status == 'ESTABLISHED' and conn.raddr:
                if conn not in existing_connections:
                    existing_connections.add(conn)
                    ip, port = conn.raddr
                    process = get_process_info(conn)
                    print(f"New outbound connection detected: IP={ip}, Port={port}, Process={process}")
        time.sleep(1)

if __name__ == "__main__":
    monitor_connections()
