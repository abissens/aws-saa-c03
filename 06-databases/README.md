### RDS - Relational DB Services


- Types : Postgres, MySQL, MariaDB, Oracle, SQL Server, IBM DB2 and Aurora (AWS Proprietary DB)
- RDS is Managed :
    - Auto prov. os patching
    - Continuous Backup and restore
    - Monitoring
    - Read replicas for perfs
    - Multi AZ setup for DR (Disaster Recovery)
    - Maintenance windows for upgrades
    - Scaling capabilities both vert and horiz
    - EBS Backed Storage (gp2 or io1)
    - Failover support
- Usage : OLTP - Online transaction processing 
- Not suitable for OLAP : use redshift instead 
- Cannot do SSH
- Linked to SG

#### RDS - Storage Auto scaling

- All DB engines
- Max storage Threshold to be set
- Auto scale up or down storage if
    - Free space is less than 10% of allocated
    - And Low storage lasts at least 5 minutes
    - And 6 hours have passed since last modification

#### Read replicas

- Only Select (for performance not DR)
- Up to 15 read replicas (15 aurora, 5 mysql)
    - Async replication between main RDS instance and read replicas
    - Reads are Eventually consistent (because replication is async)
    - Can be within AZ, cross AZ or cross Region
- Replicas can be promoted to their own DB (breaks replication)
- Sample Use case : reporting and analytics
- Network cost :
    - free (no charges) if Read Replicas in same Region
    - charged for cross region

#### RDS Multi AZ (disaster recovery)

- master (or primary) and standby instances (different AZ)
- Synchronous replication
- One DNS name - automatic app failover to standby promoted to master db 
- Not used for scaling or performance - cannot use standby db when master is active 
- /!\ Note : a Read Replica can be set as Multi AZ
- Zero downtime to go from single to multi AZ

#### RDS Custom

- Managed Oracle and SQL Server Database with OS and db customization
- Access to underlying database and OS (EC2 instances) using SSH or SSM Session Manager
- Need to De-activate automation mode

#### Amazon Aurora

- Cloud optimized -> 5x perf. improvements overs MySQL and 3x over Postgres on RDS
- Uses shared storage volume
- Note : Aurora snapshots can be shared with other AWS Accounts 
- Posgtres and MySQL format are support (for drivers use)
- Auto grow in increments of 10GB up to 128 TB
- Master + up to 15 replicas (faster replication + possible autoscaling)
    - Support cross region replication
- Instantaneous failover - HA native
- Cost 20% more than RDS
- HA and read scaling
    - Min 2 copies across 3 AZ = 6 copies 
    - 4 needed for writes , 3 for reads
    - Self healing  with p2p replication
    - storage striped across 100s of volumes
    - Auto failover for master in less than 30 seconds (a reader become master)
- Writer endpoint (master) and reader endpoint (Connection Load Balancing over Readers)
- Backtrack turn on by default - restore data at any point of time
- Advanced
    - Replicas Auto scaling (ex. CPU usage)
    - 3 types of Replicas : Aurora (15), MySQL (5), Postgres (5)
      - Auto failover if only available with Aurora replicas 
    - Custom Endpoints (ex. for Analytics with 2xlarge read replicas)
    - Aurora Serverless
        - Automated database Client instantiation and autoscaling  based on actual usage
        - Good for infrequent, intermittent or unpredictable workloads
        - No capacity planning needed
        - Pay per second, can be more cost-effective
    - Global Aurora (different from Aurora cross region)
        - Decrease latency all over the world
        - 1 primary regison (r/w)
        - up to 5 secondary region (read only) and 16 replicas per secondary
        - Promoting a secondary region have RTO < 1 minute
        - Aurora Machine Learning
#### RDS & Aurora Backups

- Daily full backup
- Transaction logs backed up every 5 minutes
- point in time recovery
- 1 to 35 days retention (set to 0 to disable - onyl RDS; not in Aurora)
- Manual DB Snapshot
- Trick : to save costs snapshot and terminate DB
- Can restore into new DB
- Backup and restore from S3
- Possible de backup and restore from on premise MySQL to Aurora using Percona XtraBackup
- Aurora Database Cloning (create cluster from existing one)
    - Copy on write protocol
    - Good for staging DB

#### RDS & Aurora Security

- At rest encryption (launch time)
- Read replicas cannot be encrypted if main instance is not
- For existing DB (snapshot and restore )
- In flight encryption
- Can use IAM Roles to connect to DB (except for Oracle)
- Security Group
- Audit logs can be enabled and sent to CloudWatch for longer retention

#### RDS Proxy

- Allow pool and sharing DB connection
    - Minimize connection opening
- Serverless / autoscaling and multi-AZ (highly available)
- Reduce RDS and Aurora failure time by up to 66%
- Enforce IAM auth
- RDS Proxy are never publicly accessible - must be accessed from VPC
- Util for Lambda functions (since they multiply quickly)

#### ElastiCache

- Redis or Memcached
- Support IAM Authentication for Redis only
- Patterns
    - Lazy loading (data can become stale)
    - Write through (update cache on DB update - no stale state)
    - Session store
- Redis
    - Multi AZ with auto failover
    - Read replicas
    - Data durability using AOF persistence
    - Backup/restore
    - Supports Sets and Sorted Sets (guarantee both uniqueness and element ordering)
    - Supports SSL in flight encryption
- Memcached
    - Multi-node (data partition = sharding)
    - No replication (no high availability)
    - Non persistent
    - No backup and restore
    - Multi-threaded
    - Supports SASL-based authentication 

#### DynamoDB 

- NoSQL Database (Eventually consistent)
- Pay per request pricing / balances cost an perf / no minimum capacity 
- Create by creating Table 
- Support both Document and Key/Value data model 
- Stored on SSD 
- Spread across 3 geographically distinct DC 
- Strongly consistent reads : returns a result reflecting all successful writes 
- DAX - DynamoDB Accelerator 
  - In memory cache 
  - 10x faster : from milli to micro seconds 
  - Compatible with DynamoDB API (transparent)
- Security 
  - KMS
  - Site to site VPN
  - Direct Connect (DX)
  - IAM Policies and roles 
  - Fine grained access 
  - CloudWatch and CloudTrail
  - VPC endpoints 
- DynamoDB Transactions 
  - ACID across 1 or more tables 
  - Allowed up to 25 items or 4MB of data per transaction 
  - 3 read options : eventual consistency, strong consistency and transactional 
  - 2 options for writes : standard and transactional 
- DynamoDB Backups
  - On demand 
    - Zero impact
    - Consistent within second 
    - Retained until deleted 
    - Same region as source table 
  - Point in TIme recovery (PITR)
    - Not enabled by default 
    - Restore to any point in the last 35 days 
    - Protects against accidental writes or deletes 
    - Incremental backups 
    - Latest restorable : 5 minutes in the past

#### DynamoDB Streams 

- Time ordered sequence of item level changes in a table (steam records)
- Stored for 24 hours
- Stream records grouped by shards

#### DynamoDB Global tables 

- Managed multi master, multi region replication
- Transparent and Native to DynamoDB 
- Based on DynamoDB streams
- Replication latency = 1 second

#### Amazon DocumentDB (MongoDB compatible)

- Allows to Run mongodb on AWS as managed service 

#### Amazon Keyspaces

- Allows to Run Casandra Workloads on AWS as managed service 

#### Amazon Neptune 

- Graph Database 
- Use cases : Connections, Graph applications, detect fraud patterns, Security, etc. 

#### Amazon Quantum Ledger Database 

- NoSQL immutable, transparent having cryptographically verifiable tx logs

#### Amazon Timestream 

- Time series Database  
- Trillions of events by day
- Usecases : IoT, agriculture, analytics, DevOps apps