### Serverless 
 
- Run code
- Event based 
- Pay as you go : provisioned resources and length of runtime 


#### Lambda

- Free tier 1M request, 400K GBs of compute per month 
  - After that, pay per request 
- Integrates with numerous AWS services (S3, DynamoDB, EventBridge, SQS/SNS, Kinesis) 
- Built-in Monitoring and Logging (CloudWatch)
- Up to 10, 240 MB Memory - CPUs scale with memory 
- 900 seconds (15minutes) execution length (short time executions)
- Support large variety of languages : Python, Golan, Java, Node.js, etc. 
- Run inside or outside (default) a VPC 
  - Ex. if we need to access private RDS instance we need to run inside VPC 
- Configuration
  - Runtime
  - Permission (attach Role)
  - Networking (VPC/subnet/SG/etc.)
  - Resources : Memory
  - Trigger : Event that runs Lambda 
- Quotas 
  - 1K concurrent execution
  - 512 MB - 10 GB dist storage /tmp
  - EFS if needed 
  - 4 KB for all env variables 
  - 128 MB - 10 GB memory allocation 
  - Compressed deployment package (.zip) siez <= 50 MB 
  - Uncompressed deployment package must be <= 250 MB
  - Request and response payload up to 6 MB 
  - Streamed responses up to 20 MB
- Use case 1 
  - Put object in S3
  - Launch trigger 
  - Execute Lambda
  - Send output processed to S3 bucket or store to DynamoDB
- Use case 2
    - EventBridge Rule (Rate or CRON)
    - Launches Lambda function 
    - The lambda function shuts down Dev Instances 

#### AWS Serverless Application Repository 

- Repository : Find, deploy, publish serverless applications 
- Ability to privately or publicly share applications 
- Manifest file : SAM Template 
- Deeply integrated with AWS Lambda service 
- 2 Options 
  - Publish
    - Private by default 
    - Explicit share 
  - Deploy 
    - Find and deploy published applications 
    - Public applications don't need AWS Account to browse 
    - Be careful of trusting all applications

#### AWS ECS, EKS 

- Running containers, Orchestration 
- ECS - AWS Elastic Container service
  - Manage up to 1000s of containers 
  - Place containers and keep them online 
  - Appropriately registered with chosen load balancers 
  - IAM : individual roles by containers 
- Kubernetes : large scale orchestration 
- EKS - AWS Elastic Kubernetes Service 
  - Managed Kubernetes 
  - Best used when you're not all in on AWS 
- ECS and EKS : Good for long running applications 

#### AWS EKS Distro 

- Kubernetes distribution based on Amazon EKS 
- Fully managed on prem / in cloud / anywhere (self managed)

#### AWS EKS Anywhere and ECS Anywhere 

- EKS Anywhere 
  - On prems kubernetes cluster based on EKS Distro
  - Full lifecycle management of multiple k8s clusters and operates indep of AWS
  - Curated packages (extended core functionalities) Enterprise subscription 
- ECS Anywhere 
  - ECS on prems 
  - Inbound traffic : no ELB support 
  - Requirements : SSM Agent, ECS agent, Docker installed 
  - Register external instances as SSM Managed instances 
  - Installation script within ECS console (with SSM activation keys and commands)
  - Execute scripts on on prem VMSs or bare metal 
  - Deploy containers using external launch type 

#### Fargate 

- Serverless compute engine for Docker Containers 
- Requires the use of ECS or EKS 
- Supports Windows and Linux apps 
- ECS Launch types : 
  - EC2 
    - EC2 pricing model 
    - User is responsible for underlying OS
    - Multi containers can share same host 
    - Capable of mounting EFS 
  - Fargate 
    - AWS Managed the infra entirely (including OS and Host)
    - Pay based on resources and time run 
    - Short-running tasks 
    - Isolated Env by container 
    - Can use IAM roles for tasks / services 
    - Capable of mounting EFS 

- Fargate vs Lambda 
  - Chose Fargate for more consistent Workloads 
  - To allow Docker use and better developers control
  - Chose Lambda fr unpredictable or inconsistent Workloads 

#### EventBridge (formally CloudWatch Event)

- Serverless Event Bus 
- Pass events from a source to and endpoint 
  - Connects serverless application together 
- Concepts 
  - Events : Recorded change in AWS Env, SaaS partner or configured app/service including Scheduled or Realtime events 
  - Rules : Criteria to match incoming events and send them to appropriate targets (patterns or schedules)
    - Event Pattern : Ex. EC2 Terminated 
    - Scheduled : Rate Based or Cron Based 
  - Event Bus : A router between events and targets 
    - Every account have default bus 
    - Can create custom bus 
- Ex. Use case 
  - User terminates instance
  - Event matches rule 
    - Trigger lambda -> retarts instance 
    - Publish SNS Message 


#### ECR - Elastic Container Registry 

- AWS Managed Container Image Registry 
  - Each registry is regional 
- Private container image repositories with resource based permissions via IAM
- Support Open Container Initiative OCI images, Docker images and OCI Artifacts 
- Component 
  - Registry : provided to each Account (one or more) for image storage
  - Authorization token 
  - Repository : contain images 
  - Repository Policy 
  - Image
- Note: AWS ECR Public if for public image repositories 
- Lifecycle Policies 
  - RUses for cleaning up 
  - can test before run 
- Image scanning : identify software vulnerabilities 
  - Scan on push 
  - Generate reports 
- Sharing :
  - Cross region 
  - Cross account 
  - Configured Per repo per region
- Cache Rules : 
  - Caching public repos privately 
- Tag mutability 
  - Prevents image tags from being overwinter 
- Integration : ECS, EKS, on Prems,

#### AWS Aurora Serverless 

- Aurora provisioned vs Aurora Serverless 
- Aurora Serverless 
  - On Demand and Auto scaling (based on app demands)
  - Automation and adjusting capacity 
  - Charged only for resources consumed per-second (budget friendly)
- Concepts 
  - ACUs : Aurora Capacity Unit 
  - Set min and max ACUs for scaling requirements - can be zero 
  - AWS Managed Warm pools : Allocated quickly 
  - Each ACU : 2 GiB mem with matching CPU and Networking capability 
  - Same data resiliency as Aurora provisioned : 6 copies of data across 3 AZ 
  - Multi-AZ for high availability
- Use cases : 
  - Variable Workloads 
  - Multi-tenant Apps 
  - New Apps : unsure what db instance needed 
  - Dev and Test 
  - Mixed Use Apps : different traffic spikes 
  - Capacity Planning : Easy to swap from provision to serverless and vice-versa 

#### X-Ray - application insights 

- Collects application data for insights about requests / responses 
- View calls to downstream AWS resources 
- Use traces 
  - Tracing headers, trace data, X-Ray Daemon 
- Concepts 
  - Segments : resource names, request details, other data
  - Subsegments : more granular info 
  - Service graph : graphical representation of interacting services 
  - Traces : Trace ID 
  - Tracing Header : named X-Amzn-Trace-Id
- X-Ray Daemon : Listen to port 2000, collects raw segment data and sends it to X-Ray API 
  - When daemon is running it works along with AWS X-Ray SDKs
- Integrations : EC2, ECS Tasks, Lambda, SNS, SQS, API Gateway, Elastic Beanstalk 

#### AWS AppSync 

- GraphQL Interface 
- Data from multiple sources