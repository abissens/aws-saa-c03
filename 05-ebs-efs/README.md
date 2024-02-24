### Instance Storage


#### EBS : Elastic Block Store

- Network drive volume
- Attached to one instance at a time (except multi-attach for some EBS)
- Allow data persistence after instance termination
- Highly available across AZ
- Locked to AZ / snapshot to move across AZ
    - Cannot attach to instances from another AZ
- Provisioning : Size and IOPS (IO per second)
- Billed for capacity 
- Scalable 
  - Capacity can be increased over time without downtime 
  - Volume type can be changed on the fly 
- Delete on Termination attribute = True / false
    - Default to true to root EBS volume
- Always in the same AZ of the instance using them 
- 

##### EBS Snapshot

- Can be copied across AZ/Regions and are shared only in their region
- Can create volume from snapshot
- EBS Snapshot archive
    - 75% cheaper
    - Take within 24 to 72 hours to restoring the archive
- Recycle Bin for EBS Snapshots
    - Rule for snapshot retention after deletion
    - Retention period : from 1 day to 1 year
- Fast Snapshot Restore (FSR)
    - Full initialization of snapshot with no latency on first use
    - Costly
- Snapshots are incremental 
- Recommendation : stop instance before taking snap 

##### EBS Volume Types

- 6 Types (only the first 4 can be used as boot)
    - gp2 / gp3 SSD - General purpose
        - 1GiB to 16TiB
        - Cost effective / Low latency
        - use case high performance / lower cost 
    - io1 / io2 Block Express SSD (low latency / high throughput workload)
        - 4GiB to 16TiB
        - Sustained IOPS perfs
        - Support multi-attach
        - Use cases ! Big data, data warehouses, ETL, log processing => throughput (ex. 500MB/s per TB)
    - st1 HDD : Low cost HDD for frequently accessed, throughput intensive workloads
        - 125 GiB to 16TiB
        - Big Data, Log processing, Data warehouses
        - Max throughput 500 MiB/s / max IPOS 500
    - sc1 HDD : Lowest cost HDD for less frequently accessed workload
        - Cold HDD
##### IOPS vs Throughput 

| IOPS                                           | Throughput                                     |
|------------------------------------------------|------------------------------------------------|
| Nb of R/W per second                           | nb of bits R/W per s                           |
| Quick transactions, low latency, transactional | important for larger datasets, complex queries |
| Choose IO types                                | Choose Throughput optimized HDD                |




##### EBS multi-attach

- Only io1/io2 family
- Same EBS to multiple EC2 instances in the same AZ (up to 16 EC2)
- Each instance has full r/w permissions
- Must use cluster aware file system
- Use case : higher application availabilty (ex: Teradata); concurrent write operations

##### EBS Encryption

- Encrypted EBS Volume
    - At rest
    - in flight
    - snapshot
    - volumes created from snapshots
- Minimal impact on latency
- Keys from KMS (AES-256)
- To encrypt an existing one : snapshot then re-attach (launch instance from AMI if root volume)

#### EC2 Instance Store

- High performance hardware disk
- Better I/O
- Ephemeral (lost on stop)
- Use case : buffer, cache, temp, etc.
- Risk of data loss if hardware fail


#### EFS - Elastic File System

- Managed NFS (only for linux instances uses NFSv4 protocol)
- Support 1000s of concurrent connections and scale to petabytes 
- Works with EC2 instances in multi AZ (basically it s a shared storage)
- No capacity plan (FS Scale) Pay per use (expensive = 3 x gp2)
- Highly available and scalable
- Use security groups to access
- Performance Mode
    - General Purpose (default) - latency sensitive use cases
    - Max IO - higher latency , throughput (big data, media processing)
- Throughput mode
    - Bursting : 1 TB = 50MiB/s + burst of up to 100MiB/s
    - Provisioned : Throughput set regardless of storage size
    - Elastic : Auto scales based on workloads
- Storage classes
    - Storage Tiers : Standard or Infrequent access (EFS-IA)
        - Must use lifecycle policy to enable EFS-IA
    - Availability and durability
        - Standard / Multi AZ
        - One Zone (good for Dev / cost saving)
- Use case : content management, web serving, data sharing, etc.

#### FSx

- FSx for Windows 
  - Managed native Windows file system (built on windows server)
  - Supports AD users, ACLs, etc. 
  - Support SMB protocaol 
  - Encrypts keys via KMS
- FSx for Lustre 
  - Lustre file system to process massive datasets 
  - HPC: Millions of IOPS, GBs of throughput's, sub milliseconds latencies  
  - Can store data directly on S3

#### AMI - Amazon Machine Image

- Customization of EC2 instance (faster boot / prepackage software)
- Region specific : Built for specific region and can be copied across regions
    - So shared across same region AZ
- Types
    - AWS Provided Public AMI
    - Custom API
    - AWS Marketplace AMI
- Can build AMI from EC2 instance (start -> customize -> stop -> Build AMI)
    - This will create EBS snapshots 
- AMIs are either backed by 
  - EBS : the root device is an EBS volume created from an EBS snapshot 
  - Instance Store : the root device is a EC2 Instance Store volume created from a template stored in S3

#### AWS Backup 

- Consolidate backups across multiple AWS Services 
  - EC2, EBS, EFS, FSx, Storage Gateway, DRS, DynamoDB
  - Can be used with Organizations 
  - Benefits : central management, automation, improved compliance 