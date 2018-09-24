Getting Started:
1. Fill in the -Input Default Account Name, Account ID(s), and region
2. Run terraform apply
3. Replace 'account_name' values in s3-remote state with the account name value from -input.tf
4. Fill in the ARN of the kms_key_id value in s3-remote-state - e.g. arn:aws:kms:us-east-1:##############:key/aa###aa##-aa##-###a-####-##aaaaa####aa
5. Get access keys from terraform user and document
6. Get access keys from terraform-remote-state, document, and add to s3-remote-state
7. Uncomment remote state and run terraform apply
8. Answer yes when prompted to fill remote state with existing local state
9. Remove any root access keys if possible


Todo:
 - Add Password policy
 - Add MFA Policy
 - Add default roles (admin, etc.)
 - Add CloudTrail Config
