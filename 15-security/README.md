### Security 


#### DDos 

- Layer 4 DDos attack : SYN flood attack 
  - Amplification Attack : NTP, SSDP, DNS, CharGEN, SNMP attacks, etc. 
    - Using Spoofed IP Address
- Layer 7 Attacks : Floods of GET and POST attacks 

#### AWS CloudTrail

- Record AWS Management Console actions and API calls 
- Increase visibility into user (user, source IP, time) and resource activity 
- Logged Data
  - Metadata
  - Identify of caller
  - Time
  - Source IP address
  - Request 
  - Response elements
- Can enable log file integrity validation within the CloudTrail console for  trails.
- Use cases 
  - After the fact incident investigation 
  - Near real-time intrusion detection (coupled with Lambda)
  - Compliance 

#### AWS Shield 

- Free DDOS Protection 
- Applies to all AWS Accounts on ELB, CloudFront and Route 53
- Protects against SYN/UDP floods, reflection attacks and other layer 3 and 4 attacks 
- AWS Shield advanced 
  - Protects against larger and more sophisticated attacks
  - Always on, flow based monitoring of network traffic - near real time notification of DDos 
  - 24/7 access to DDoS Response Team (DRT)
  - Protects AWS bill against higher fees during spikes of DDoS Attach 
  - Cost 3K$ per month 

#### AWS WAF 

- Web application Firewall (layer 7)
- Applies to CloudFront or ALB 
- Configure conditions (IP, request params, content, etc.)
- HTTP 403 if blocking 
- 3 behaviours : Allow all except, Block all except, count requests matching property 
- Conditions
  - IP
  - Country 
  - Values in Request header 
  - Presence of SQL 
  - Presence of script 
  - Strings and regex in requests 

#### AWS Firewall manager 

- Security management service in a single pane of glass 
- Centrally set up and manage firewall (and WAF) rules across multiple AWS accounts and applications 
- Need AWS Organizations 
- Force compliance 

#### GuardDuty 

- Threat detection service with AI 
  - 7-14 days to set a baseline 
  - 1 month free then charged based on quantity of activity 
- Uses machine learning to continuously monitor for malicious behavior 
  - Unusual API calls
  - Calls from known malicious IP 
  - Attempts to disable CloudTrail logging 
  - Unauthorized deployments 
  - Compromised instances 
  - Reconnaissance by would-be attackers 
  - Port scanning, failed log in 
- Alerts : GuardDury console and CloudWatch Events 
- Receives feeds from third parties : Proofpoint, CrowdStrike, AWS Security, etc. 
- Monitors CloudTrail logs, VPC Flow logs and DNS logs 
- Centralize threat detection across multiple AWS accounts 
- Automated response using CloudWatch and Lambda 

#### AWS Macie 


- PII - Personally Identifiable Information (HIPAA and GDPR)
  - Plus PHI and financial data
- Monitor S3 buckets (ML and Pattern matching) to discover sensitive data 
  - Alerts about unencrypted buckets 
  - Alerts about public buckets 
  - Alerts about shared buckets (outside of organization)
- Alerts : 
  - Macie Console 
  - Integrates with EventBridge 
  - Integrates with AWS Security Hub and other AWS Services 

#### AWS Inspector 

- Inspects Network and EC2 instances 
- Assessment findings 
  - Network assessment: Network config analysis - Check for ports reachable from outside VPC
  - Host assessment : Vulnerable Software, host hardening (CIS Benchmarks), secu best practices 
- Need Agents on EC2 instances 
- Run once or weekly 

#### AWS KMS

- Key management service - create and control (lifecycle) encryption keys 
- Integrates with other AWS Services 
- CMK : Customer Master Key 
  - Logical representation of a master key 
  - Includes metadata : Key ID, creation date, description and key state 
  - Contains Key material used to encrypt / decrypt data 
- Start with creating CMK - you control its lifecycle and who can use and manage it 
- HSM : Hardware security module : physical computing device that safeguards and manages digital keys
  and performs encryption / decryption functions
- CloudHSM : rent HSM from AWS 
- 3 ways to generate CMK 
  - AWS Created - generated with HSMs managed by AWS 
  - Import key material from customer Key management infra 
  - Import key material on AWS CloudHSM cluster as custom key store feature 
- Key rotation 
  - Can auto rotate CMK each year 
  - Auto Rotation not supported for 
    - Imported keys
    - Asymmetric keys 
    - CloudHSM custom generated keys 
- Policies : who has access to what 
  - IAM policies vs Resource based policies 
  - Key policies : resource based policies attached to CMK 
  - 3 Ways 
    - Key policy 
    - IAM Policies in combination with Key policy 
    - Grants in combination with key policy 
- KMS vs CloudHSM 
  - Shared tenancy of underlying hardware in KMS
  - Dedicated HSM to the account in CloudHSM
  - No automatic key rotation in CloudHSM

#### AWS Secret Manager 

- Stores, encrypts and rotates database credentials and other secrets
- Encryption in transit and at rest - using KSM 
- Fine grained access control using IAM policies 
- Highly scalable 
- Secrets are retrievable by API call 
- /!\ if rotation enabled, Secrets Manager immediately rotates once to test the configuration  
  - All applications should not hard code secrets but retrieve them from secret manager
  - Do not enable rotation if applications use embedded credentials 

#### Parameter Store 

- Secure, hierarchical storage for configuration data management and secrets management 
- Data such as : passwords, database strings, license codes, etc. 
- Plain text or encrypted data 
- free service 
- Limitation 
  - number of parameters 10K max 
  - no rotation 

#### Temporarily share S3 Objects 

- All object in S3 are private by default 
- Only the owner has access 
- Owner can share presigned URL using their security credentials to grant time limited permission to download
  - Security credentials 
  - Bucket name and object key 
  - HTTP method 
  - expiration date time 
- Any one who received the presigned URL can access 
- Presigned Cookies 
  - Access to multiple restricted files 
  - Users having Cookies can access to the entire contents 

#### Advanced IAM Policy Document 

- ARNs : Amazon resource names syntax 
  - arn:partition:service:region:account_id:[resource; resource_type/resource; resource_type/resource/qualifier; etc.]
  - partition can be : aws, aws-cn, etc.
  - service : iam, s3, ec2, etc. 
  - Region is omitted for global services : arn:aws:iam::::123456789:user/ryan
  - Account is omitted in S3 :  arn:aws:s3:::bucket_name/image.png
  - Wild cards : arn:aws:ec2:123456:instances/*
- IAM Policies 
  - JSON Document that defines permissions 
  - Identity Policy (to users and groups)
  - Resource Policy (to resources)
  - Policies have no effects until attached 
  - List of statements 
  - Each statement matches an AWS API Request
  - Statement 
    - SID 
    - Effect : Allow |Deny 
    - Action : generally resource:Action (ex. dynamodb:Query, dynamodb:BatchGet*)
      - Uses wildcards 
    - Resource : what the action is against (ex. arn:aws:dynamodb:*:*:table/MyTable)
      - ARN using wildcards 
  - Permission Boundaries 
    - Delegate admin to other users 
    - Prevent privilege escalation or unnecessarily broad permissions 
    - Use cases :
      - Dev. creating roles for Lambda functions 
      - Admins creating ad hoc users 
  - Not explicitly allowed = implicitly denied 
  - AWS joins all applicable policies 
  - AWS Managed vs Customer managed policies 

#### AWS Certificate manager 

- Create, manage and deploy public and private SSL certificates for user with  other services 
- Integrates with ELB, CloudFront, API Gateway, etc. 
- No paying for SSL 
- Automate renewals and Deployment 


#### AWS Audit manager 

- Continuously audit AWS usage 
- Compliance with industry standards and regulations 
- Produces specific reports to auditors for PCI compliance, GDPR, etc. 

#### AWS Artifacts 

- Artifact : single source to get compliance related informations 
  - AWS Security and compliance reports 
  - Select online agreements 
- Huge number of reports available 
- Download compliance document 

#### Amazon Cognito 

- Authentication, authorization and user management for Web and mobile apps (Identity broker)
- Single service without custom code 
- Access server-side resources (token with permissions)
- Access AWS AppSync (remember : GraphQL / Serverless) Resources 
- Third party sign-in 
- Sign-up / Sign-in 
- Guest user access 
- Sync user data across multiple devises 
- Recommended for mobile applications 
- Two components 
  - User pools 
    - Directory of users providing sign-up / sign-in
  - Identity pools 
    - Allow to give user access to other AWS Services 
    - Exchange tokens and get AWS credentials to access AWS Services with them
  - User and Identity pools can be used separately or together 
- STS - AWS Security Token Service to validate tokens

#### Amazon Detective 

- Analyse, investigate and identify the root cause of potential security issues or suspicious activities 
- Uses ML, Statistical analysis and graph theory 
- Sources : VPC Flow Logs, CLoudTrail logs, EKS audi logs, GuardDuty findings, etc.

#### AWS Network firewall 

- Managed service to deploy a physical firewall protection across VPCs 
- Has a managed infrastructure (physical firewalls by AWS)
- Complete control over network traffic 
- Use cases :
  - Filtering traffic before it reaches internet Gateway 
  - Intrusion prevention system 
  - hardware requirements 

#### AWS Security Hub 

- Single place to view all security alters from services like 
  - GuardDuty 
  - Inspector 
  - Macie 
  - Firewall manager
- Works across multiple accounts 