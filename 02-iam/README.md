###  IAM = Identity and Access Management, Global service

IAM is Global (Universal) Not bound to Region

#### Abstract

- Root account created by default, shouldn't be used or shared (Add MFA to it)
- Users and Groups
- Groups only contain users, not other groups
- Users don't have to belong to a group, and user can belong to multiple groups
- Permissions are managed by JSON documents = Policies
- Creating IAM User : Account ID  / Alias / Signin URL
- Roles
- Can add tags to users (or any resources)

#### Policies

- Add policies to users / groups in the console
- Browse policies
- Create custom policy in the console builder (VisualEditor)
- Policies types 
  - AWS Managed
  - Job Function (preconfigured permissions like PowerUser)
  - Customer Managed
- Default new User Permission : IAMUserChangePassword
- Deny always overrides Allows 

Policy JSON example :

```json
{
  "Version": "2012-10-17",
  "Id": "....", // Optional 
  "Statement": [
    {
      "Sid" : "1",  // Optional 
      "Effect": "Allow", // Allow or Deny
      "Action": "ec2:Describe*", // String or Array
      "Principal": {
        "AWS" : ["arn:aws:iam:545454455:root"] // account user role to which policy applies
      },
      "Resource": "*" // String or Array
      "Condition" : ... // Optional 
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:Describe*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:ListMetrics",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:Describe*"
      ],
      "Resource": "*"
    }
  ]
}
```

#### Password Policy
- Password length, strength
- Expiration and rotation
- Identical to name / email prevention
- Old password prevention

#### MFA - Multi Factor Authentication

- Virtual MFA devices : Google Auth, Authy
- U2F Key
- Hardware TOTP

#### AWS Access

- AWS Management console (Web)
- AWS CLI (access keys - generated from AWS console) 
- AWS SDK (access keys)

#### AWS Cli

```shell
aws configure # this will prompt for Access Key ID, Secret and Region name 
# example (if permissions OK)
aws iam list-users
aws iam list-users --region .....

aws s3 ls
```

#### AWS CloudShell (not available for all regions)

- Web Cloud based terminal

#### IAM Roles for Services

- Role = like users but assigned to services to do operations on behalf of actual users (kind of machine account)
- Role: Services (example : EC2 Instance) + Permissions
- Trusted entity type - user or resource that can assume the Role 
  - AWS Service 
  - AWS Account (log as Role)
    - Can be related to this account or another one
    - Attach Role to user by "Trust relationships"
  - etc.

#### IAM Security Tools (Audit)

- IAM Credentials Report  (account-level)
- IAM Access Advisor (user-level)

#### Identify providers 

- Add new Identity Provider (SAML for AD or OIDC)


#### MISC 

- ARN Amazon Resource Name ex. arn:aws:iam::339712790957:user/user-1