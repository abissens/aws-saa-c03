### Automation 

#### CloudFormation

- Infrastructure as a code : YAML or JSON Templates
    - Immutable
    - Versioning 
    - Leverage stack tags 
    - Consistency 
  
- Resources and relationships 
- Process 
  - Write declarative template 
  - Deploy the code as Stack or Stack Set 
    - CloudFoundation do the AWS API calls to create and configure resources 
    - Admin account can create and manage stack across multiple accounts and regions with single operation 
      - This is stack sets 
    - Stacks are regional resources 
    - Can deploy portable stacks into other regions 
    - Change preview (change sets) on existing stack
    - Caution to replacement attribute (replace resource if true - lose data)
- Rollback on error 
- Prevent hard coded values to prevent CloudFormation failures
- Template sections 
  - AWSTemplateFormatVersion (Optional)
  - Parameters (Optional)
  - Mappings (Optional)
    - Parameter based on criteria 
    - Ex. RegionMap => based on region mappings 
  - Resources (Required)
  - Outputs (Optional)
    - To S3 or others 
  - Transform (Optional)
    - Macros and custom processing to transform the template before transforming 
- Can use designer for visual representations 
- Note : The immutable pattern specifies a deployment of application code by starting an entirely 
  new set of servers with a new configuration or version of application code.
  When we go immutable, we don't want to ever upgrade in place. Once the cloud resource exists, 
  it can't be modified.


#### Beanstalk 

- PaaS : Platform as a service 
- Build infrastructure from app code 
- Developer, from code based instantiation
- Free to use
- Components :
    - Application : collection of Beanstalk components (env, versions, configs, etc.)
    - App version
    - Environment
        - Collection of AWS resources
        - Tiers
            - Web Server Tier : Web Env with ELP
            - Worker Tier : No client Env with SQS Queue
        - Can have multiple environments
            - Supports :
              Go, Java, Tomcat, .NBet, NodeJS, PHP, Python, Ruby,
              Packer Builder, Docker, multi container Docker, preconf Docker
- Deployment modes
    - Single instance (Elastic IP)
    - High available with Load balancer (ALB, ASG, RDS Redundancy)
- Need IAM rights
- Uses Cloud Formation

#### Systems Manager 

- View, patch, manage and configure EC2 instances and On prems resources 
- Need IAM permissions 
- SSM Agent 
  - Software component to install on instances (EC2 or on prems)
- Capabilities 
  - Automation : use predefined or custom playbooks (documents) to manage resources 
  - Run Command : Remotely execute commands without SSH or DP 
  - Patch Manager : Automate patching (OS and application patching)
  - Parameter Store 
  - Maintenance Windows : Define a schedule for performing actions on instances 
  - Session Manager : Securely connect without needing SSH access
- Logging : SM logs all usage to CLoudWatch and CloudTrail 
- SSM Agent 
  - Amazon software that runs on your compute 
  - Preinstalled on majority of AMIs
  - Make sure to have the IAM permissions 
  - Possible de install Agent on on prems resources 
- Parameter Store 
  - Free feature to store config data and secret values in hierarchical manner with parameter policies (expiration dates )
  - Types : String, StringList, SecureString (with KMS)
  - ex. /dev/squid_conf=......
  - can be references this way : {{ssm:/dev/squid_conf}} in commands 
- Connect with SSM in Console (user : ssm-user)
- Run commands 