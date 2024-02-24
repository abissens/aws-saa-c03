### Beanstalk 

- Developer, from code based instantiation 
- Free to use 
- Components :
  - Application : collection of Beanstalk components (env, versions, configs, etc.)
  - App version
  - Environment 
    - Collection of AWS resources 
    - Tiers 
      - Web Server Tier : Web Env with ELP
      - Woker Tier : No client Env with SQS Queue 
    - Can have multiple environments
      - Supports : 
          Go, Java, Tomcat, .NBet, NodeJS, PHP, Python, Ruby, 
          Packer Builder, Docker, multi container Docker, preconf Docker
- Deployment modes 
  - Single instance (Elastic IP)
  - High available with Load balancer (ALB, ASG, RDS Redundancy)
- Need IAM rights 
- Uses Cloud Formation 