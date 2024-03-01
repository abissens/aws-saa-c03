### Machine learning 

- /!\ Rekognition and Sagemaker are most used 

#### Amazon Comprehend 

- Comprehend : NLP - Natural language processing
  - Use cases : Call center analytics, Index and search product reviews, process financial documents
- Kendra : Intelligent search service
  - Use cases : Accelerate R&D, improve customer interactions 
- Textract : Auto extract text, handwriting or scanned 
  - Use cases : Financial services, Health case, etc.  

#### Amazon Forecast 

- Time series data forecasting service using ML algorithms
- Use cases : IoT, Analytics, DevOps, etc.

#### Amazon Fraud Detector 

- Account fraud detection 
- Suspicious online payments, account fraud, prevent trail and loyalty
- Improve account takeover detection 


#### Amazon Text and speech

- Transcribe : Speech to text 
- Lex : build conversational interfaces using NLM - Natural Language models 
  - + Voice assistants 
- Polly : Text to Lifelike speech 

#### Amazon Rekognition

- AWS Computer vision product for photos and videos 
- Use cases 
  - Content moderation 
  - Face detection and analysis 
  - Celebrity recognition 
  - Streaming Video Events Detection 

#### Amazon Sagemaker

- Manage, package and deploy ML Models 
- Components 
  - Ground Truth : Labeling jobs for training datasets using active learning and human labeling 
  - Notebook : Managed Jupyter Notebook environment 
  - Training : train and tune models 
  - Inference : Package and deploy ML Models at scale 
- 2 Deployment types 
  - Offline Usage (async or batch)
  - Online Usage (real time) - if need immediate response 
- Stages 
  - Create a Model 
  - Create and Endpoint configuration 
  - Create an Endpoint 
- Model training 
  - Load data in container registry 
  - Etc. 
- SageMaker Neo 
  - Customize ML models for specific Hardware : ARM, Intel, NVidia
  - Use TensofFlow, ONNX, etc. software 
- Elastic Inference 
  - EI speeds up throughput and decrease latency of real time inferences using only CPU instances 
  - Much more cost effective thant full GPU instance
- High availability 
  - Recommendation : Deploy ML in different AZ


#### Amazon Translate

- Auto language translation 
- Uses deep learning and neural network 
- Scalable, Cost effective, easy to integrate with application 
