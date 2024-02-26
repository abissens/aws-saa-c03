### CLoudwatch 

- Managed Monitoring service in AWS 
- System metrics (got out of the box - the more services are used, the more metrics there are)
- Application metrics (by installing CloudWatch agent - informations from inside EC2 instances)
- Alarms 
- Default metrics (no need to install agent)
  - CPU Utilization
  - Network throughput 
- Custom metrics (need agent)
  - EC2 Memory utilization 
  - EBS Storage capacity
- Basic monitoring = 5 minutes (no extra fee)
- Detailed monitoring = 1 minutes (extra fee)

#### Create Alarm 

- Metric and conditions
  - Select metric category (grouped by namespace)
  - Select instance/metric
  - Select statistics 
  - Selector operator (Greater, Lower, etc.)
  - Datapoints to alarm (number of Err of OK 1/1, 5/10, etc.)
  - Missing data treatment (nothing, good, bad, etc.)
- Configure action :
  - Notification
  - Autoscaling action
  - EC2 action (stop, terminate, reboot, recover)
  - System manager action : create incident
- Etc.

#### CloudWatch Logs 

- Managed tool for logs files from different sources to 
  - Monitor
  - Store 
  - Access
- CloudWatch Agent for custom logs (on AWS instances or on-premises servers)
- Terminology 
  - Log Event : timestamp + data
  - Log stream : log events from same source
  - Log Group : Collection of log streams (ex. httpd logs across hosts)
- Features 
  - Filter patterns : Look for specific terms in logs (ex. 400 errors)
    - Can send it to lambda or automation routine
  - Logs Insights : query using SQL-like interactive solutions
  - Alarms 
- /!\ if logs processing is not needed, just send logs to S3

#### Amazon Managed Grafana

- Query, correlate, visualize operational metrics, logs and traces 
- Workspaces : logical Grafana server (separation of data visualizations and querying)
- AWS Managed and Secure 
- Pricing by active user in a Workspace
- Data sources : 
  - CloudWatch
  - Prometheus
  - Amazon OpenSearch 
  - Amazon Timestream
  - Etc.
- Use cases 
  - Container Metrics (Prometheus, EKS, ECS, ON prem kubernetes cluster, etc.)
  - IoT and Edge device data (vast data plugins)
  - Troubleshooting (centralized dashboards)

#### Amazon Managed Prometheus

- AWS Managed, Serverless, Prometheus-compatible service 
- Securely monitoring container metrics at scale 
- Auto scale based on ingestion, storage and querying of metrics 
- High Availability : replicates across 3 AZ in same Region
- Works with Kubernetes cluster running on Amazon EKS or on premises Kubernetes 
- Uses PromQL : query language 
- Data is stored in workspaces for 150 days then deleted 