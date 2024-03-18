### Glossary 

#### Security

* AWS CloudTrail : Record AWS Management Console actions and API calls 
* AWS Shield : Free DDOS Protection
* AWS Shield advanced : Payed DDOS Protection 
* AWS WAF : Applies to CloudFront or ALB
* AWS Firewall manager : Security management service in a single pane of glass
* AWS Network firewall : Managed service to deploy a physical firewall protection across VPCs
* AWS GuardDuty : Threat detection service with AI - 7-14 days to set a baseline
* AWS Inspector : Inspects Network and EC2 instances
* AWS Detective : Use ML to analyse, investigate and identify the root cause of potential security issues or suspicious activities
* AWS Security Hub : Single place to view all security reports from services
* AWS KMS : Key management service - create and control (lifecycle) encryption keys
* AWS Certificate manager : Create, manage and deploy public and private SSL certificates for user with  other services
* AWS Secret Manager : Stores, encrypts and rotates database credentials and other secrets 
* Parameter Store : Free, secure, hierarchical storage for configuration data management and secrets management (10 K max)
* AWS Macie : PII - Personally Identifiable Information (HIPAA and GDPR)
* AWS Audit manager : Continuously audit AWS usage, produces specific reports to auditors for PCI compliance, GDPR, etc.
* AWS Artifacts : Single source to get compliance related informations (reports to download)
* Temporarily share S3 Objects / CloudFront content : presigned URL or Cookies
* AWS Cognito : Authentication, authorization and user management for Web and mobile apps (Identity broker)

#### Governance

* AWS Organizations : Free governance tool to manage multiple AWS Accounts 
  * Management vs member accounts 
* AWS RAM - Resource Access Manager : Facilitate sharing resources with other accounts (even out of organization)
* Cross account Role access : Cross account role access gives the ability to set up temporary access that can be managed
* AWS Config : Inventory Management and control tool
* AWS Directory Service : Managed AD - Types : Managed Microsoft AD; AD Connector and Simple AD
* AWS Cost explorer : Visualize, analyse and generate reports for cloud costs and costs breakdown
* AWS Cost and usage reports (CUR) :  Most comprehensive set of cost and usage data
  * Publish billing reports to S3
* AWS Budgets : Service to plan and set expectations around cloud costs (create alerts)
* AWS Compute optimizer : Analyzes configuration and utilization metrics of AWS resources then produce recommendations 
* AWS Trusted Advisor :  Best practices auditing tool (cost, perf, secu, fault tolerance and service limits)
* AWS Console tower :  Orchestration service that automates account creation, management and security controls
  * Guardrail rules 
* AWS License manager : Centrally manage licenses across AWS accounts and on prems env.
* AWS Personal Health Dashboard : Visibility of resource performances and availability of AWS services or accounts
  * EventBridge integrations, automations  and alerts (near real time)
* AWS Service Catalog : Create and Manage Catalog of Approved IT Services
* AWS Proton : Create and manage infrastructure and deployment tooling for users as well as serverless and container based apps
* Savings Plans Types
  * Compute Savings
  * EC2 Instance Savings
  * SageMaker Savings

#### Migration 

* Snowcone (8TB) < Snowball Edge (48 to 81 TB ) < Snowmobile (100 PB)
* AWS Storage Gateway : Hybrid Cloud storage (File - NFS or SMB, Volume (EBS Snapshot - think backup) or Tape gateway)
* AWS DataSync (One time migration) : Agent based solution for on-prem to AWS storage migration (S3, EFS, FSx)
* AWS Transfer Family :  Move files in and out S3 or EFS using SFTP, FTPS or FTP
* AWS Application Discovery : Plan migrations to AWS via usage and config data from on prems servers (Agent or Agent-less)
* AWS Application Migration Service: Automated Lift and shift service for expediting migration of apps to AWS
* AWS Database migration Service : Migrates relational, non relational and data warehouses 
  * On prems <-> AWS
  * One time or On going (continuously replicate changes)
  * SCT - Schema Conversion Tool
  * 3 migration types : Full load; CDC - Change Data Capture;  Full load and CDC (only one that guarantee transactional integrity) 
* AWS Migration Hub : Single place to track the progress of application migration to AWS (AMS and DMS)

#### Machine learning 

* AWS Comprehend : NLP - Natural language processing
* AWS Kendra : Intelligent search service
* AWS Textract : Auto extract text, handwriting or scanned
* AWS Translate : Auto language translation

* AWS Transcribe : Speech to text
* AWS Lex : build conversational interfaces using NLM - Natural Language models
* AWS Polly : Text to Lifelike speech

* AWS Forecast :  Time series data forecasting service using ML algorithms
* AWS Fraud Detector : Suspicious online payments, account fraud, prevent trail and loyalty
* AWS Rekognition : Computer vision product for photos and videos
* AWS Sagemaker : Manage, package and deploy ML Models


#### Automation 

* CloudFormation 
* Beanstalk : PaaS
* Systems Manager : View, patch, manage and configure EC2 instances and On prems resources

#### Caching 

* CloudFront : CDN 
* Global Accelerator (GA) : Networking services that sends user traffic through AWS Global network infrastructure via accelerators  
  * IP Caching -> think GA
* DAX : In Memory Cache - reduces DynamoDB response times to microseconds
* Elasticache : Managed version of Memcached and Redis

#### Web and mobile

* AWS Amplify (hosting and studio) : Web and mobile Dev
* AWS Device Farm : devices for tests
* AWS Pinpoint : Customer message channels (email, SMS, push messages, etc.)

#### Media 

* AWS Elastic transcoder : Media converter 
* AWS Kinesis Video streams : Streaming media content from large number of devices to AWS

#### Decoupling 

* AWS Batch : Batched workload on EC2 or ECS/fargate
* AWS Amazon MQ : Supports both ActiveMQ and RabbitMQ
* AWS Step functions : Serverless orchestration service (integrates many AWS Services)
* Amazon AppFlow : Bi-directional data integration between SaaS (Salesforce, Slack, etc.) and AWS Services (S3, Redshift) 

#### Big data

* Redshift : Managed PB scaled Data warehouse (up to 16PB)
* Redshift spectrum : Query and retrieve S3 Data without loading data into Redshift tables 
* EMR - Elastic MaPReduce : AWS Managed ETL  
* AWS Kinesis : Ingest, process and analyze real-time streaming data (huge data highway)
  * Kinesis Data Streams : Real time 
  * Kinesis Data Firehose : Near real time
  * Kinesis Data Analytics : Analyse data using standard SQL 
* AWS Athena : Serverless interactive Query service to analyse S3 using SQL 
* AWS Glue : Serverless data integration service 
* AWS Quick Sight : Serverless, Fully managed BI Data viz service 
* AWS Data pipeline : Managed ETL used for automated movement of data 
* AWS MSK - Managed Streaming for Apache Kafka 
* AWS OpenSearch : Managed services for search and analytics engines 

#### Serverless 

* Lambda
* AWS Serverless Application Repository
* AWS ECS, EKS
* AWS EKS Distro
* AWS EKS Anywhere and ECS Anywhere : On prems 
* Fargate : Serverless compute engine for Docker Containers
  * ECS Fargate vs EC2
* EventBridge (formally CloudWatch Event) : Serverless Event Bus
* ECR - Elastic Container Registry
* X-Ray - application insights : request tracing and analysis 
* AWS AppSync : GraphQL Interface 