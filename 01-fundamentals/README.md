### Fundamentals 

### AWS Global infrastructure

- Regions, AZ, Data centers and Edge locations / Points of Presence
- Region = cluster of Data centers
    - Most AWS Services are region scoped
    - How to choose a Region : Compliance, Proximity (reduce latency), Available services and Pricing
- Edge Location : Endpoints for caching content (typically CloudFront CDN)
- Each region has many availability zones (usually 3, min is 2, max is 6)
    - Example for Region Sydney (ap-southeast-2) : ap-southeast-2a, ap-southeast-2b, ap-southeast-2c
    - Each availability zone (AZ) is one or more discrete data centers with redundant power, networking, and connectivity
    - They're separate from each other, so that they're isolated from disasters
    - They're connected with high bandwidth, ultra-low latency networking

### Ownership and responsibilities 

- Shared Responsibility Model

### Well architected framework White paper 

- Six pillars
  - Operational Excellence 
  - Perf. efficiency 
  - Security 
  - Cost opt. 
  - Reliability 
  - Sustainability 