### Decoupling Workflow

- Services 
  - SQS - Simple Queue Service : Managed Message queue service
  - SNS - Simple Notification Service 
    - A2A (Application 2 Application)
    - A2P (Application 2 Person)
  - API Gateway 
    - Create, publish, maintain, monitor and secure APIs

### SQS 

- SQS - Simple Queue Service : Managed Message queue service
- Asynchronous 
- SQS Settings 
  - Delivery Delay : default to 0, can be set up to 15 minutes 
  - Message size : can be up to 256KB of text in any format 
  - Encryption : 
    - in transit : by default yes
    - at rest : by default no
  - Retention : 
    - Default is 4 days, can be between 1 min and 14 days 
  - Long (connect and wait - more cpu time) vs Short polling (frequently)
    - Short polling is default
  - Queue Depth 
    - Can be a trigger for autoscaling 
  - Visibility timeout 
    - Polled message is locked (invisible) for 30 seconds 
    - Instance having polled the message send ACK to the queue to delete the message
    - If no ACK sent, the message is again visible

#### SQS FIFO 

- Standard Queue 
  - Best effort ordering 
  - Can order on application level 
  - Duplicate messages
  - unlimited tx/sec
- FIFO Queue 
  - Guaranteed ordering
  - Must append ".fifo" to queue name
  - No message duplications (explicit message deduplication ID)
    - Can be based on message content 
    - Message deduplication ID
  - Message Group ID 
  - 300 tx/sec
  - Batching can achieve up to 3K tx/sec
  - if FIFO High throughput activated 
    - 9K and 90K (with batching) tx/sec

#### Dead Letter queues - DLQ

- targets for messages that cannot be processed successfully 
  - Technically DLQ are just other SQS queues 
  - Same retention period as source 
  - For FIFO SQS Queues, corresponding DLQs must be of type FIFO
- Work with both SQS and SNS 
- Usefully for debugging and isolating unconsumed messages to troubleshoot 
- Redrive capability : Move message back into the source queue
- Can configure alarms based on availability counts 
- Troubleshoot consumer permissions 


### SNS 

- Push based messaging service 
- Proactively delivers messages to endpoints that are subscribed
  - Subscriber types : SQS, Lambda, email, HTTP(S), SMS, platform application endpoint, Kinesis Data Firehose
- On message can be sent to many receiver
- Message size : can be up to 256KB of text in any format
  - If SNS Extended Library installed -> Message can go to 2 GB in size (using S3 intermediate storage)
- Supports DLQs 
- FIFO SNS only support FIFO SQS as a subscriber 
- Encryption :
  - in transit : by default yes
  - at rest : by default no
- Access Policies 
- SNS Fanout 
  - Messages are replicated to multiple endpoint subscriptions 
  - Fully decoupled parallel asynchronous processing 
- SNS Architectures 
  - SNS -> Multi SQS -> Processing 
  - SNS -> Kinesis Data Firehose -> Massive amount of data to be ingested / transformed -> Services 
- Message filtering 
  - Filter subscriber based on content 
- /!\ Custom retry policies for HTTP(s) endpoints only 
- Use cases : real time alerts or push based messaging 

### API Gateway 

- Managed AWS Service to Create, publish, maintain, monitor and secure APIs
- Integrates with Lambda, HTTP Endpoints, etc. 
- Auto attach WAF 
- Stop Abuse : DDoS protection 
- API Options 
  - REST API 
  - HTTP API 
  - Websocket API 
- Endpoint types 
  - Edge-Optimized : Default option 
  - Regional : for APIs only reserved to particular region 
  - Private : Only accessible via VPCs using VPC Endpoints 
- Security 
  - User authentication : IAM, AWS Cognito, custom authorizer (Lambda function)
  - Edge optimized endpoints require ACM certs in us-east-1 
  - Regional endpoints require ACM certs in the same region 
  - Can leverage AWS WAF for DDoS protection 

### AWS Batch

- Batched workload on EC2 or ECS/fargate
- Optimize the resource computation size accuracy based on number of submitted jobs  
- Optimize the workload distribution
- Components 
  - Job (shell scripts, executable or docker dimages)
  - Job definition : Blueprint of resources in the job 
  - Job Queues : Jobs are submitted to queue an reside there until scheduled to run 
  - Compute environment : Set of manager or unmanaged compute resources
- Fargate : recommended approach for most Workload 
  - Fast start time < 30s
  - Require 16 vCPI or less and no GPUs
  - Require 120 GiB of memory or less 
- EC2 : 
  - If more controle is needed 
  - Requires GPU, Elastic Fabric Adapter of custom AMIs
  - High levels of concurrency 
  - Access to Linux parameters 
- Note : Batch vs Lambda 
  - Lambda have 15 minutes execution time limit 
  - Lambda have limited disk space and EFS requires functions live within VPC
  - Lambda is fully serverless - no runtime 
  - Batch uses Docker 
- Note lambda can initiate Batch command 
- Managed vs Unmanaged environment

### AWS Amazon MQ 

- Message broker server that allow easier migration of existing apps in the Cloud 
- Supports both ActiveMQ and RabbitMQ
- Required private networking like VOC, DDirect Connect or VPN
  - In contrast SNS and SQS are publicly accessible 
- Amazon MQ Brokers 
  - ActiveMQ
    - Active/standby deployment
  - RabbitMQ
    - Logical grouping of three broker nodes across multiple AZs 
    - Behind NLB

### AWS Step functions 

- Serverless orchestration service (integrates many AWS Services)
- Graphical console 
- COpponents : state machines, tasks
  - State machine : Workflow with event-driven steps 
  - Task; Specific states within a state machine representing a Single Unit of Work 
  - States Every single step in the state machine 
  - Execution : instance of state-machine 
- Amazon State Language to describe states 
- Two types 
  - Standard 
    - Have only one execution 
    - Execution can run for up to 1 year
    - long-running workflows that have auditable history 
    - Rates up to 2K executions/sec
    - Pricing based on state transition 
  - Express 
    - At least once 
    - Execution can run for up to 5 minutes 
    - High event rate workloads 
    - Use case : IoT data streaming and ingestion 
    - Pricing based on number of executions, durations and memory consumed 
- Different states 
  - Pass : pass any input to output 
  - Task 
  - Choice 
  - Wait 
  - Succeed 
  - Fail
  - Parallel 
  - Map : runs a set of steps based on elements of an input array

### Amazon AppFlow 

- Integrate data between SaaS (Salesforce, Slack, etc.) and AWS Services (S3, Redshift) via ingestion 
- Bi-directional data transfers with limited combinations 
- Concepts 
  - Flow : Transfer data between sources and destinations 
  - Data Mapping 
  - Filters 
  - Trigger 
    - Run on demand
    - Run on event 
    - Run on schedule 

### Exam Tips 

- /!\ Never Tightly couple - always Loose Couple
- /!\ Every level of an application should be Loosely coupled 
- Loosely Coupled = LB + Gateways + Async Messaging 