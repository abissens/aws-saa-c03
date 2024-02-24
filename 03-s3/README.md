### S3 - Object storage 

- S3 operates across global space (but bucket deployed regionally)
- Upload any file type 
- Not used for OS or DB Storage 
- Unlimited storage (volume + number of objects)
- Objects up to 5 TB
- Ensures High availability and High durability (data is spread across multiple DC)
  - 99.95-99.99 Availability 
  - 11 nines durability (9 decimals)
- Standard S3
  - multi-devices / AZ redundancy (>= 3 AZ)
  - 4 nines Availability / 11 nines Durability 
  - Frequent access
- Tiered Storage (different storage classes)
- Lifecycle management
- Versioning 
- Security 
  - Server side encryption 
  - ACLs : can be granted to individual objects within bucket
  - Bucket policies (allowed/denied actions on buckets - all its objects)
- Strong read (get file, list, etc.) after write consistency
- Object can have prefixes (folder structure)
- By default, you have the ability to create a maximum of 100 buckets in every one of your AWS accounts. 
  In case you require more buckets, you have the option to raise your account bucket quota to 
  a maximum of 1,000 buckets by submitting a request to increase your quota.


#### S3 buckets 

- Universal Namespace (globally unique)
  - All AWS Accounts share the S3 namespace 
- URL format : https://[bucket-name].s3.[region].amazonaws.cm/[key-name]
- Successfull upload -> HTTP 200 

#### Key-Value Store 

- Key (string) / value (bytes)
- Version ID (multiple versions of same object)
- Metadata (content-type, last-modified, etc.)

#### Enable static web site hosting 

- Specify index and error .html files

#### Security 

- Block public access
  - Buckets are private by default
  - Have to allow public access on both bucket and objects
    - Add bucket policy that applies to all bucket objects 
    - Bucket policy editor in the console 
    - Ex. 
      ```json
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
              "s3:GetObject"
            ],
            "Resource": [
              "arn:aws:s3:::BUCKET_NAME/*"
            ]
          }
        ]
      }
      ```
      
#### Versioning 

- Activate "Enable bucket versioning"
- All writes, it remains even after object delete
- Use case : backup tool 
- Once enabled, it cannot be disabled (only suspended)
- Integration with lifecycle rules
- Supports MFA (multi-factor auth) to delete object 
- Version One ID = null, subsequent versions have version ID strings 
- When deleting object type = "Delete marker"
  - All are versioned even deleted
  - In order to restore -> Delete the "Delete marker"

#### Storage classes 

- S3 standard 
  - 4 nines availability and 11 nines durability 
  - Frequent access 
  - Use cases : Web content, mobile, data analytics, gaming, etc.
- S3 Standard IA (infrequent access)
  - 3 nines availability and 11 nines durability
  - Rapid access
  - Pay per GB storage and per GB retrieval fee
  - Use cases : Long term storage like Backup, Disaster recovery 
- S3 One Zone IA (infrequent access)
  - 99.5 availability and 11 nines durability
  - One AZ
  - cost 20% less 
  - Use case : same as IA but for non critical Data
- S3 Intelligent tiering 
  - 3 nines availability and 11 nines durability
  - auto move data to the most cost effective tier based on access frequency 
- Glacier 
  - 4 nines availability and 11 nines durability
  - Very infrequent access (archive)
  - Pay per access 
  - Option 1 - Glacier Instant retrieval
  - Option 2 - Glacier Flexible retrieval (minutes or up to 12 hours retrieval time)
    - No cost retrieval 
  - Option 3 - Glacial Deep Archive
    - Cheapest Storage class 
    - 7-10 years retention 
    - Standard retrieval time = 12 hours 
    - Bulk retrieval = 48 hours 

#### Lifecycle Management 

- Automates object movement between storage classes, archive or delete
  - Keep period (after creation) before move
  - Lifecycle policies can't work backwards. (from less freq. access storage class to more)
  - Use object filter or apply to all bucket 
  - Use on current version or old versions 

#### Locks 

- S3 Object Lock
  - WORM - Write Once, Read Many
  - Prevent deletion and update for fixed amount of time
  - Retention period
    - protects an object version for a fixed amount of time 
    - AWS use metadata to set timestamp attribute 
    - Object is again changeable after retention period - unless legal hold is placed
  - Legal Hold 
    - Placed on object to prevent update/deletion 
    - Can be placed or removed by users having s3:PutObjectLegalHold permission
  - 2 Modes 
    - Governance Mode 
      - All users cannot delete or overwrite unless explicitly permitted 
    - Compliance Mode 
      - A protected object version cannot be overwritten or deleted at all (including by root)
      - This for the duration of the retention period
      - Retention mode can't be changed 
      - Retention period can't be shortened 
- Glacier Vault Lock 
  - Apply WORM model to Glacier by vault lock policy 
  - Once locked it can no longer be changed

#### Encryption 

- Types 
  - Encryption in Transit : SSL/TLS - HTTPS
  - Encryption at Rest (server side encryption)
    - SSE-S3 : fully managed by S3
    - SSE-KMS: Use AWS KMS to manage the keys 
    - SSE-C : Customer side keys 
  - Encryption at Rest (client side) - Encrypt before upload
- Can change default encryption on bucket creation 
- SSE-S3 enabled by default 
- Add x-amz-server-side-encryption header in PUT File request 
  - x-amz-server-side-encryption: AES256 (SSE-S3) - even for recent S3 version it is active by default 
  - x-amz-server-side-encryption: aws:kms (SSE-KMS)
- One can create a Bucket Policy that denies any S3 request without the x-amz-server-side-encryption header

#### Performances 

- 3.5K request write & 5.5 K request read per second per prefix 
- => The more the prefixes the better the performances 
- Limitations 
  - If SSE-KMS used keep in mind KMS limits
  - Upload/download count toward the KMS quota (5.5K, 10k or 30K request per second depending on region)
  - Cannot request KMS quota increase
- Multipart uploads (parallelize uploads)
  - Recommended for files over 100 MB
  - Required for over 5GB files 
- Byte Range fetches (parallelize downloads)
  - If failure it's only for specific byte range

#### Backup 

- Replicate object from one bucket to another 
- Replication requires versioning enabled 
- Can apply replication to all object or to some objects using filters 
- Delete markers are not replicated by default 