## Assignment is completed, documentation here

* [x] Dockerized frontend-backend
* [x]  Deployed on Cloud (EC2)
* [x]Created cloud resources using Terraform to deploy on AWS
* [x] Used Docker best practices and multistage builds along with no root user to run images.
* [x] Logic for securely copying environment variables  with committing to GitHub
* [x] Complied with all resource management practices. 

# AS asked setup and assignment details in DEVOPS.md by Mooaz Sayyed prev readme.md is pruned

- 📘 [DevOps Guide](DEVOPS.md)

CI/CD setup

<img width="1121" height="524" alt="image" src="https://github.com/user-attachments/assets/1a2a525f-d013-4dda-a787-af81bfeeecda" />

## View PRODUCTION application here

https://nextgensis.mooazsayyed.live

<img width="1913" height="1035" alt="image" src="https://github.com/user-attachments/assets/6b725735-0a83-480c-a2f2-5466ba07e651" />

## View PRODUCTION API here

https://api.nextgensis.mooazsayyed.live/api/hello 

<br>

{
"message": "Hello World from Django Backend!"
}
<img width="609" height="201" alt="image" src="https://github.com/user-attachments/assets/d11b2fe2-b0a3-45e8-ae5d-c22307ffc0e9" />

## VIEW PREPRODUCITON APPLICATION HERE <br>

![alt text](image.png)

## VIEW PREPRODUCITON API HERE

https://preprod.api.nextgensis.mooazsayyed.live/api/hello  

<br>
{
"message": "Hello World from Django Backend!"
}
![alt text](image-2.png)

# EC2 and application SETUP FOR PRE-PROD AND PROD BOTH ATTACHED TO ELASTIC IP

<img width="3292" height="1676" alt="image" src="https://github.com/user-attachments/assets/7c2f3372-781f-4fc7-916d-46cc2a81450e" />

# Added health endpoint to see api health

https://api.nextgensis.mooazsayyed.live/api/health 

<br>

{
"status": "healthy",
"environment": "production",
"debug": "False",
"timestamp": "2026-01-24T14:42:58Z"
}

<img width="680" height="242" alt="image" src="https://github.com/user-attachments/assets/cf6e7382-81f3-4ecc-a0f6-7a16571a5191" />

## Infrastructure as Code (Terraform)

Terraform was used to provision EC2 instances, security groups, private keys, and Elastic IPs.
[Terraform Directory](./Terraform) <br>

### Resources Created

- **PRE-PROD EC2 Instance:** `i-0937c46a11f153a92` (devops-assessment-preprod)
- **Elastic IP:** Attached to `i-0937c46a11f153a92`
- **Authentication:** PEM file generated for SSH access.
- **Security Rules:**
  - SSH (Port 22)
  - HTTP (Port 80)
  - HTTPS (Port 443)

### Self-Hosted Runner

A self-hosted runner is configured on the EC2 instance.

<img width="1043" height="318" alt="image" src="https://github.com/user-attachments/assets/14f34770-10e8-4168-9459-0b6df1bfb5aa" />

**Tags:** `preprod`, `production`
