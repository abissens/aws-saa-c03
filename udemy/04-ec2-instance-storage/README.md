### Instance Storage 


#### EBS : Elastic Block Store 

- Network drive volume 
- Attached to one instance at a time (except multi-attach for some EBS)
- Allow data persistence after instance termination 
- Locked to AZ / snapshot to move across AZ
  - Cannot attach to instances from another AZ
- Provisioning : Size and IOPS (IP per second)
- Billed for capacity / capacity can be increased over time 
- Delete on Termination attribute = True / false
  - Default to true to root EBS volume 

##### EBS Snapshot 

- Can be copied across AZ/Regions 
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

##### EBS Volume Types

- 6 Types (only the first 4 can be used as boot)
  - gp2 / gp3 SSD - General purpose 
    - 1GiB to 16TiB
    - Cost effective / Low latency 
  - io1 / io2 Block Express SSD (low latency / high throughput workload)
    - 4GiB to 16TiB
    - Sustained IOPS perfs 
    - Support multi-attach 
  - st1 HDD : Low cost HDD for frequently accessed, throughput intensive workloads 
    - 125 GiB to 16TiB
    - Big Data, Log processing, Data warehouses 
    - Max throughput 500 MiB/s / max IPOS 500
  - sc1 HDD : Lowest cost HDD for less frequently accessed workload
    - Cold HDD

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
- To encrypt an existing one : snapshot then re-attach 

#### EC2 Instance Store 

- High performance hardware disk 
- Better I/O
- Ephemeral (lost on stop)
- Use case : buffer, cache, temp, etc. 
- Risk of data loss if hardware fail 


#### EFS - Elastic File System 

- Managed NFS (only for linux instances)
- Works with EC2 instances in multi AZ
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


#### AMI - Amazon Machine Image 

- Customization of EC2 instance (faster boot / prepackage software)
- Built for specific region and can be copied across regions 
  - So shared across same region AZ
- Types
  - AWS Provided Public AMI 
  - Custom API
  - AWS Marketplace AMI 
- Can build AMI from EC2 instance (start -> customize -> stop -> Build AMI)
  - This will create EBS snapshots 