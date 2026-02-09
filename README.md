# Policy as Code (PaC)- No Public Buckets Allowed

## Overview
Preventing accidental public S3 buckets is one of the most critical security wins for any cloud team. This lab demonstrates Policy as Code (PaC) by using Rego and Conftest to catch misconfigurations before they reach production.

### Objectives
* Understand the fundamentals of Policy as Code.

* Author a security policy using the Rego language.

* Validate Infrastructure as Code (IaC) data against security standards.

* Automate enforcement within a cloud-native environment.

### Step-by-Step Instructions
**1. Environment Setup**
Create a new GitHub repository named no-public-s3.

Launch a GitHub Codespace from the repository.

**2. Define the Infrastructure (input.json)**
Create a file named input.json to represent our S3 bucket configuration:
```
{
  "resource_type": "aws_s3_bucket",
  "acl": "public-read"
}
```

**3. Author the Security Policy (policy/input.rego)**
Create a folder named policy and a file inside it named input.rego.

**Note: I use rego.v1 syntax to ensure compatibility with modern OPA engines.**
```
package s3policy
import rego.v1

deny contains message if {
    input.resource_type == "aws_s3_bucket"
    input.acl == "public-read"
    message := "S3 buckets cannot be publicly readable (acl: public-read)"
}
```
**4. Execute the Policy Test**
Run the following command in your terminal:
```
conftest test input.json --all-namespaces
```
You should see output like this:

<img width="358" height="34" alt="s3 no bucket" src="https://github.com/user-attachments/assets/6380d85e-d3a8-4e72-b52d-1f9e18fb2e00" />

**5. Remediate and Verify**
Update input.json to set the acl to "private", then re-run the test. Expected Result: PASS — The secure configuration is approved.

**Security & Compliance Impact**
This lab demonstrates the automated enforcement of industry-standard security controls:

NIST SP 800-53 | AC-6(10) – Least Privilege (Automated): This policy automatically restricts data storage permissions to the minimum necessary level. By programmatically blocking public access, we eliminate human error and ensure that "Least Privilege" is a default state, not an afterthought.

NIST SP 800-53 | SC-12 – Unauthorized Public Access: This acts as a primary technical safeguard against data exfiltration. By strictly prohibiting public bucket configurations, we maintain data confidentiality and ensure sensitive information is never exposed to the public internet.



