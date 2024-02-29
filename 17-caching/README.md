### Caching 

- AWS Cache 
  - Externally (o user) vs Internally (to local services)
  - When ever possible favor answer with caches 


#### CloudFront 

- CloudFront is CDN distributing data, videos, applications and APIs using AWS Edge locations 
- Used for speed 
- Settings 
  - Security 
    - Default to HTTPS 
    - Can use custom SSL Certificate
  - Global distribution 
    - Cannot pick specific countries, just general areas (use WAF if wanna blocking connections/countries)
  - Endpoint support 
    - Can be used to front AWS Endpoints along with non AWS application
  - Expiring Content 
    - TTL
    - Can force the expiration 


#### ElastiCache 

- Managed version of Memcached and Redis 
  - Generally Sits in front of DB (excels in front of RDSs)
- Memcached 
  - Simple database caching solution
  - Not a database 
  - No failover or multi AZ
  - No backups 
- Redis 
  - Caching solution 
  - Functions as a standalone database 
  - Failover and multi-AZ
  - Supports backups 

#### DAX - DynamoDB Accelerator 

- In Memory Cache : reduces DynamoDB response times to microseconds 
- Highly available and lives inside the VPC 
- Custom Node size and count for the cluster, TTL for the data and maintenance windows for updates 


#### Global Accelerator (GA)

- IP Caching -> think GA
- Networking services that sends user traffic through AWS Global network infrastructure via accelerators 
- Increase performance and deal with IP caching by leveraging Anycast IP 
- Meant for TCP/UDP traffic 
- Concepts 
  - Accelerators : Directs user traffic to optimal AWS Endpoints 
  - Listeners : Processes inbound connections based on ports and protocols 
  - Endpoint : Resources that GA directs traffic to 
- Function 
  - 2 Static Anycast IP addresses for accelerators 
  - Dual stack receives 4 static IP addresses (2 v4 and 2 v6)
  - Static IPs single fixed entry for ALL client traffic 
  - Traffic routed based on location, health checks and wights 
  - Traffic routed to specified EC2 instances and ports in VPC 