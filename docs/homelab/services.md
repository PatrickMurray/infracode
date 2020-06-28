# Services

| Service   | Host       | Port  | Protocol |
|-----------|------------|-------|----------|
| InfluxDB  | 10.1.10.3  |  8086 | http     |
| Telegraf  | *          |  8092 | udp      |
| Telegraf  | *          |  8094 | tcp      |
| Telegraf  | *          |  8125 | statsd   |
| Grafana   | 10.1.10.3  |  3000 | http     |
| PiHole    | 10.1.10.4  |    53 | udp      |
| PiHole    | 10.1.10.4  |    53 | tcp      |
| GitLab    | 10.1.10.4  |    80 | http     |
| GitLab    | 10.1.10.4  |   443 | https    |
| OpenVPN   | 10.1.10.4  |   943 | https    |
| OpenVPN   | 10.1.10.4  |  1194 | udp      |
| GitLab    | 10.1.10.4  |  2022 | ssh      |
| PiHole    | 10.1.10.4  |  2080 | http     |
| PiHole    | 10.1.10.4  |  2443 | https    |
| Minecraft | 10.1.10.11 | 25565 | tcp      |
