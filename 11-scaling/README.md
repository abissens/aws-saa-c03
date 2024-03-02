### Scaling 

- The 3 W's of scaling
  - What ? EC2, DB, etc ? 
  - Where ? how many AZ, what Load Balancers, scale DB or Web ?
  - When ? Most of the time Cloudwatch alarms

### Launch template 
- Launch template
    - Settings needed to configure EC2
    - Capable or leveraging all EC2 auto scaling features
    - Support versioning
    - More granularity
- Launch configuration (predecessor of Launch template)
    - Only for certain EC2 auto scaling features
    - Immutable
    - Limited configuration options
    - Dont include Networking information 


### Vertical scaling 

- Turn off and resize instances (t2.micro -> other class)


#### ASG - Auto scaling group (Horizontal scaling)

- Scale out (add EC2) on increased load
- Scale in (remove EC2) on decreased load
- Only for EC2
- Ensure min / max instances
    - Min, max and desired capacities (desired = only initial)
- Note : Bake AMIs to reduce build times 
- Auto register new instances to load balancer
- re-create EC2 instance in case previous is terminated (ex. if unhealthy)
- ASG are free
- EC2 instances can be registered behind a Load Balancer 
  - Auto scaling group can be set to respect the LB health checks
- To create ASG
    - Networking 
      - Select subnets in multi AZ for High availability  
      - /!\ do not change the default network interface
    - ASG Launch template
        - AMI + Instance type
        - User Data
        - EBS Volumes
        - SG
        - IAM Roles
        - Network + subnet inf
        - LB informations
        - etc.
    - Can be attached to existing or new LB (with target group)
    - Scaling Policies
        - CloudWatch alarms (avg cpu, custom metric, etc.)
        - Dynamic scaling
            - Target Tracking (based on target state - ex. avg cpu = 50%)
            - Step Scaling (based on alarms)
              - Ex. Scale out add 5 instances when memory is between 60-80 % and 3 instances when between 80%-100%
              - Ex. scale in Terminate 5 instances when memory between 40%-10%
        - Scheduled scaling (ex. on Fridays increase to 10)
        - Predictive Scaling (forecasts)
    - Notification : when scaling activity happens 
      - Using Amazon SNS Notifications
    - Purchase Option : On-Demand vs Spot %
- Example of scaling metrics :
    - AVG CPU
    - Request Count per target
    - Avg Network I/O
    - Any custom metric pushed to CloudWatch
- Warm up period - time before placing behind LB and do health check  
- Cool down period (default to 300 seconds) after scaling activity 
- Lifecycle Hooks 
  - Perform custom actions on instances when lifecycle events occur 

### Scaling Relational DB 

- Types of scaling 
  - Vertical scaling 
  - Scaling storage : only scale up, not down
  - Read replicas 
  - Aurora serverless (unpredictable workloads)

### Scaling non Relational DB

- Dynamo DB 
  - Capacity model
    - Provisioned capacity (predictable workload)
    - On-Demand Capacity mode (sporadic workload)
    - Can switch between models (2 times within 24 hours period)
  - Read Capacity Unit RCU = Reads per second for in item up to 4KB in size
    - 1 RCU strongly consistent 
    - 2 RCU eventually consistent 
  - Write Capacity Unit WCU = Writes per second for an item up to 1KB in size

### Disaster Recovery Strategies 

- RPO : Recovery Point Objective 
  - At what point in time
- RTO : Recovery Time Objective
  - How quickly 
- Strategies 
  - Backup and restore 
  - Pilot Light : replicate DB (live replication) and deploy services (Web and others) 
  - Warm Standby : replicate DB (live replication) and scale-up services (Web and others)
  - Active/Active : most expansive 


### Exam tips 

/!\ Consider Switching DB as an answer in exam
/!\ Spread out - select multiple AZ