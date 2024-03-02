### Governance 

#### AWS Organizations 

- Free governance tool to manage multiple AWS Accounts 
- Controls accounts from single location 
- Account types 
  - Management account - Payer account 
  - Member account - all others 
- Features 
  - Consolidated billing 
  - Isolate costs by account 
  - Usage Discounts : Aggregate usage discounts 
  - Shared Savings : share reserved instances and savings plans across the org
- Concepts 
  - Multi-account : improved security, cost management
  - Tag enforcement
  - Organizational Unit (OU) : Logical grouping of multiple accounts 
  - Service Control Policies (SCPs) : JSON Policies (IAM like) applied to OUs aor accounts to restrict actions 
  - Management account : Not affected by SCPs
  - Account Best Practices : 
    - Centralized logging account for organizational CloudTrail logs 
    - Cross-account roles for accessing member accounts 

#### AWS RAM 

- Resource Access Manager 
  - Facilitate sharing resources with other accounts (even out of organization)
  - Free to use 
- Shared resources 
  - Transit gateways 
  - VPC subnets 
  - License Manager 
  - Route 53 resolvers (Rules and Endpoints)
  - Dedicated hosts 
  - Etc. 
- Owners and participants 
  - Owner create and manage VPC resources that get shared 
  - Owner cannot delete or modify resources deployed by participants 
  - Participant is able to provision services into the shared VPC subnets
  - Participant Cannot modify or delete the shared resource 

#### Cross account Role access 

- Cross account role access gives the ability to set up temporary access that can be managed
- No need for long-term access keys or IAM users 
- Role can be revoked as needed 
- Temporary (credentials expires)
- Steps 
  - Create role with desired privileges 
  - Update Trust Policy to allow role assumption from other account identified by its ARN ID 
    (Principal = AWS account and action = sts:AssumeRole)
  - Provide ARN of the Role to the external account 

#### AWS Config 

- Inventory Management and control tool 
- Pay per item
- Historical record of configuration history of infrastructure over time 
- Can create rules to make sure resources conform to requirements 
  - Flag when something is going wrong 
- Can receive alerts via SNS 
- Configured by region 
- Aggregated results across regions and accounts
- Rules
  - AWS predefined managed config rules 
  - Custom config rules 
  - Rules evaluated on a schedule or by a trigger 
  - AWS Config is monitoring and assessment but NOT PREVENTIVE 
- Remediation 
  - Auto remediation via SSM Automation Documents 
  - AWS Managed or Custom automation documents 
  - Custom automation documents can leverage Lambda function or custom logic
  - Can retry on failure 
- Alerts and Events 
  - SNS Topics integration 
  - Alert configuration changes or compliance state notification 
  - EventBridge integration : send events to SQS or Lambda  

#### Directory Service 

- AWS Directory Service - managed Active Directory 
- Types 
  - Managed Microsoft AD : Entire AD suite
  - AD Connector : Creates a tunnel between AWS and on-prems AD 
  - Simple AD : Standalone Linux Samba AD 

#### AWS Cost explorer 

- Visualize and analyse cloud costs 
- Generate custom reports based on variety of factors including resource tags 
- Break down cost by Monthly, Hourly, etc. 
- Built in forecasting up to 12 months 
- Features 
  - Time 
  - Filter (tags, categories, accountIDs, etc.)
  - Service

#### AWS Budgets 

- Service to plan and set expectations around cloud costs 
- Track ongoing spend, create alerts when close de exceeding allotted spend 
- Types of budgets 
  - Cost budgets : How much to spend on a service 
  - Usage budgets : How much to use on one or many services 
  - RI Utilization Budgets : Utilization threshold (RIs are used or under-utilized)
  - RI Coverage Budgets : Coverage threshold (how much instance usage is covered by a reservation)
  - Savings Plans Utilization : Utilization threshold 
  - Savings Plans Coverage Budgets : Coverage threshold 

#### AWS Cost and usage reports (CUR)

- Most comprehensive set of cost and usage data 
- Publish billing reports to S3 
- Break costs down by hours, day and month, service and resource or by tags 
- Update reports in S3 once a day 
- Easily integrate with Athena, Redshift or QuickSight 
- Use within AWS Org, OU groups or individual accounts 

#### AWS Compute optimizer and Savings Plans

- Compute optimizer 
  - Disabled by default 
  - Analyzes configuration and utilization metrics of AWS resources 
  - Reports current usage 
  - Produce recommendations 
  - Visualize history and projected utilization metrics 
  - Used to make informed decisions based on graphs, metrics and recommendations 
  - Resources
    - EC2, ASG, EBS, Lambda
  - Supported Accounts : Standalone, Org Member account, Org Management account 
- Savings Plans
  - Flexible pricing models for up to 72% savings 
  - Lower prices for EC2 instances, Lambda, AWS Fargate and SageMaker
  - Regardless of instance family, size, OS, tenancy or Regions 
  - Long-term commitments : 1 or 3 years 
  - Pricing plan : All Upfront, Partial Upfront, No Upfront 
  - Savings Plans Types 
    - Compute Savings 
    - EC2 Instance Savings 
    - SageMaker Savings 
  - Use recommendations section of AWS billing console 

#### AWS Trusted Advisor 

- Best practices auditing tool 
- Recommendations for 5 categories 
  - Cost optimization 
  - Performance
  - Security 
  - Fault Tolerance 
  - Service Limits 
- Uses industry and customer established best practices 
- Works at an account level 
- Basic or Developer support plans 
- Business, Enterprise, On-Ramp support (full Advisory checks)
  - + integration with EventBridge

#### AWS Console tower 

- Orchestration service that automates account creation, management and security controls 
- Extends AWS Organizations to prevent governance drift 
- Leverage different guardrails 
- Central Admin Compliance policies
- Features 
  - Landing zone : multi account environment 
  - Guardrails :
    - High level rules
    - Preventative and detective 
  - Account factory : Account template - pre-approved configs 
  - CloudFormation StackSet : for repeated resources for governance (like config rules)
  - Shared accounts : 3 accounts used by Control Tower created during landing zone creation 

#### AWS License manager 

- Centrally manage licenses across AWS accounts and on prems env. 
- Set Usage Limits 
- Reduce Overages and prevent license abuse 
- Versatile 

#### AWS Personal Health Dashboard  

- Visibility of resource performances and availability of AWS services or accounts 
- View how health events affects services, resources and accounts 
- Naming : Shifting to call the service AWS Health
- Timely, automations  and alerts (near real time)
- EventBridge integrations
- Concepts 
  - Health event : notification
  - Account specific event 
  - Public event
  - AWS Health dashboard 
  - Event type code 
  - Event type category 
  - Event status : open, closed or upcoming 
  - Affected entity 
- Examples : EC2 system rebout maintenance scheduled, EC2 Operational issue, Billing suspension notice, etc. 

#### AWS Service Catalog and AWS Proton

- AWS Service Catalog 
  - Create and Manage Catalog of Approved IT Services 
  - Multipurpose : AMIs, servers, software, DBs, preconfigured components 
  - Centralized service using Organizations 
  - End user friendly : easy deploy of pre-approved catalog items 
  - CloudFormation templates based 

- AWS Proton
  - Create and manage infrastructure and deployment tooling for users 
    as well as serverless and container based apps
  - Automate Infra as Code provisioning and deployments 
  - Define standardized infra for serverless and container based apps 
  - Use templates to define and manage app stacks that contain ALL components 
  - Auto provision resources, configure CI/CD and deploy code 
  - Supports AWS CloudFormation and Terraform IaC providers 

#### AWS Well architected tool 

- Well-architected Framework - Six pillars 
  - Operational Excellence 
  - Reliability 
  - Security 
  - Performance Efficiency 
  - Cost optimization 
  - Sustainability 
-  Well-architected Tool 
  - Measure cloud architecture 
  - Assistance with documentation 
  - Guides 
  - Measure workloads againts years of AWS Best pratices 
  - Specific audiences : tech teams, CTOS, archi and ops teams 
