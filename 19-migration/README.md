### Migration 

#### Snow family 

- Load data in truck and ship it physically to AWS 
- Both ways : On Prem <-> AWS 
- Types 
  - Snowcone 
    - 8TB, 4GB RAM, 2vCPUs
    - IoT sensor integration 
    - Perfect for edge computing 
  - Snowball Edge 
    - 48 to 81 TB storage 
    - Varying amount of CPU and RAM 
    - Perfect for off the grid and migration 
  - Snowmobile 
    - 100 PB of storage 
    - Designed for exabyte scale data 

#### Storage Gateway (Hybrid solution)

- Hybrid Cloud storage 
  - Merge on prem resources with the cloud 
  - One time migration or long term pairing 
- File Gateway 
  - Caching local files 
  - NFS or SMB mount 
  - Extend on prem storage 
- Volume Gateway (backup drives)
  - ISCSI mount 
  - Cached or stored mode 
  - Create EBS snapshots 
- Tape Gateway
  - Replace physical tapes 

#### AWS DataSync (One time migration)

- Agent based solution for on-prem to AWS storage migration (S3, EFS, FSx)
- Move data between NFS and SMB shares and AWS storage solutions 

#### AWS Transfer Family 

- Move files in and out S3 or EFS using SFTP, FTPS or FTP

#### AWS Migration Hub 

- Single place to track the progress of application migration to AWS 
- Integrates with Server Migration Service (SMS) and DB Migration Service (DMS)
- SMS 
  - Schedule migration 
  - Uploads 
  - Convert
  - Create AMI 
- DMS 
  - AWS Schema conversion Tool 
  - Upload to Aurora

#### AWS Application Discovery Service and Application Migration Service 

- Application Discovery Service 
  - Plan migrations to AWS via usage and config data from on prems servers 
  - Integrates with AWS Migration Hub
  - Discover servers and group by application
  - Track each application migration 
  - Discovery types 
    - Agent less
      - Agentless collector 
      - OVA within VMware vCenter 
    - Agent Based
      - AWS Application Discovery Agent to install on each VM and Physical server
      - Windows and linux 
-  Application Migration Service (AWS MGN)
  - Automated Lift and shift service for expediting migration of apps to AWS 
  - Flexible 
  - Avoid cutover windows or disruptions 
  - Features : RTO (minutes - OS boot time) and RPO (sub second range)

####  Zoom to AWS Database migration Service

- Migrates relational, non relational and data warehouses
- On prems <-> AWS 
- One time or On going (continuously replicate changes)
- Endpoints : Source and target data stores 
- Same engine migration vs different engine migrations 
- Must have ONE endpoint at AWS
- SCT - Schema Conversion Tool 
  - Supports both OLAP and OLTP and data warehouses 
  - Any supported Amazon datastore type 
  - Can even use converted schemas on DB running on EC2 or data stored in S3
- 3 migration types 
  - Full load 
  - Full load and CDC - Change Data Capture (only one that guarantee transactional integrity)
  - CDC only 
- Can migrate data stores with AWS Snowball 
  - Still use SCT 
  - CDC compatible 