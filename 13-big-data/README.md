### Bigdata 

- 3V's 
  - Volume : ranges from TB to PB of data
  - Variety 
  - Velocity : speed of collection, storage, processing and analysis 

### Amazon Redshift 

- Managed PB scaled Data warehouse (up to 16PB)
- Large relational DB : Standard SQL and BI Tools 
- Based on PosgtreSQL - no OLTP Workloads neither and RDS replacement 
- 10x other DWH 
- Columnar 
- Multi-AZ : only 2 AZ 
- Snapshots are incremental and point in time : can be automated or manual 
  - Always contained in S3 (you cannot managed the bucket)
- No conversion from Single AZ to multi-AZ and vice-versa 
- /!\ Exam tip : always favor large batches to optimize Redshift perfs

#### Redshift spectrum 

- Query and retrieve S3 Data without loading data into Redshift tables 
  - Uses independent Redshift servers 

#### EChanced VPC Routing 

- All COPY and UNLOAD Traffic between cluster and data repositories are forced through a VPC 
  - Enhances data security an controls 
  - Use of VPC Features like Endpoints and Flow Logs 

### AWS EMR - Elastic MaPReduce

- AWS Managed ETL 
  - Use cases : Web indexing, machine learning, large-scale genomics, etc. 
- Uses open source tools such as Spark, Hive, HBase, Flink, Hudi and Presto 
- 3 types of storage 
  - HDFS : popular for caching during processing
  - EMR File System : extends Hadoop with the ability to access S3 as if part of HDFS
  - Local file system : EC2 instance store volumes
- Clusters and undoes 
  - Cluster = group of EC2 instances (node)
  - Primary Node : manage the cluster, distribute data and tasks, tracks health status 
  - Core Node (long running) : run tasks and stores data in HDFS 
  - Task Node (optional) : run tasks with no storage - typically Spot instances 
- Purchase options 
  - On-Demand 
  - Reserved
  - Spot 
  - Type : Long-running or transient 

### AWS Kinesis 

- Ingest, process and analyze real-time streaming data (huge data highway)
- 2 Versions 
  - Kinesis Data Streams : real time 
    - Consumer creation is managed by architect (app dev)
    - Model
      - Producers
      - Shards (n shards)
      - Consumers (EC2 instances pointing to output storage (S3, Redshift, Data Firehose, EMR, DynamoDB etc.))
  - Kinesis Data Firehose : Near real time
    - Sends only to S3, Redshift, Elasticsearch or Splunk
    - Plug and play
    - Model 
      - Input -> Data Firehose -> output storage (S3, Redshift, etc.)

- Kinesis Data Analytics and SQL 
  - Analyse data using standard SQL 
  - No servers, transparent 
  - Pay as u use
- Kinesis vs SQS 
  - In contrast with SQS - Kinesis is real time 
  - SQS is Simpler 

### AWS Athena & Glue

- Athena : Serverless interactive Query service to analyse S3 using SQL 
  - Directly query S3 Data without loading into DB 
- Glue : Serverless data integration service 
  - ETL without EC2 instances 
  - Replace EMR
- Athena and Glue 
  - S3 -> Glue Crawlers (build structure for data) -> Glue Data Catalog -> Athena -> Quick Sight 
  - Alternatively : S3 -> Glue Crawlers (build structure for data) -> Glue Data Catalog Redshift Spectrum 

### AWS Quick Sight 

- Serverless, Fully managed BI Data viz service 
- Create dashboards
- Share dashboards with users and groups 
- Use cases 
  - Data viz, ad-hoc analytics, business insights 
- Integrates with : RDS, Aurora, Athena, S3, etc. 
- SPICE : Robust in memory engine - advanced calculations 
- Enterprise offering : Column-Level Security (CLS)
- Pricing : Per session, per user 
- Create Users and Groups (EEnterprise version) for Quick sights - not same as IAM ones
- Create Dashboards and share them 

### AWS Data pipeline 

- Managed ETL used for automated movement of data 
- Data Driven Workflows 
- Define parameters for data transformations 
- Highly Available, Fault tolerant 
- Handles Failures and integrates with SNS 
- Works with AWS Storage services
- Works with AWS Compute services (EC2, EMR)
- Components 
  - Pipeline Definition 
  - Managed Compute 
  - Task Runners 
  - Data nodes 
  - Activities : pipeline components to define work to perform
- Flexibility to schedule tasks 
- Use cases : 
  - Processing data in EMR using Hadoop streaming 
  - Importing or exporting DynamoDB data 
  - Copying CSV files between S3 buckets 
  - Exporting RDS data to S3
  - Copying data to Redshift 

### AWS MSK - Managed Streaming for Apache Kafka 

- Managed streaming service for Apache Kafka 
- Provides Control plane operations : creates, updates and delete clusters 
- Leverage Kafka data plane operations for producing, consuming streaming data 
- Open source version of Apache Kafka - support of existing apps, tools and plugins
- Component 
  - Broker nodes 
  - ZooKeeper nodes 
  - Cluster Operations 
  - Producers, Consumers and Topics 
- Residency 
  - Automatic Recovery - same state (broker IP) after successful recovery 
  - Failure Detection 
  - Reduce data: Reuse storage from older brokers 
  - Time required 
- MSK Connect : stream data to and from Apache Kafka clusters 
- Security and logging 
  - Integrates with SSE
  - Encrypt data at rest by default 
  - TLS 1.2 for encryption in transit 
  - Broker logs to CloudWatch, S3 and Kinesis Data Firehose 
  - Metrics are sent to CloudWatch 
  - All MSK API calls are logged to AWS CloudTrail 

### AWS OpenSearch 

- Managed services for search and analytics engines 
- Successor of Amazon Elasticsearch Service
- Used for managed analytics and viz service 
- Features 
  - Quick analysis : ingest search and analyse data 
  - Scalable 
  - Security : IAM, VPC SG, encryption at rest and in transit and field level security 
  - Stability : Multi-AZ Capable (master and snapshots)
  - Flexible : Can use SQL for BI apps 
  - Integrates with CloudWatch, CloudTrail, S3 and Kinesis
- /!\ OpenSearch service is widely used for log analytics 



