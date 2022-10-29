## Steps

### Prequisites

You need to install:

- terraform  (>=1.3)

You have setup aws credentials (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

Verify your aws account:

```
aws sts get-caller-identity
```

### Execute terraform

Update value of user and s3 bucket in `terraform.tfvars` file

Initialize providers

```
terraform init
```

Run plan

```
terraform plan
```

Review plan and apply

```
terraform apply
```

After terraform executed successfully, get output

```
terraform output access_key
terraform output secret_key
```

Export these two values with env vars:

```
export AWS_ACCESS_KEY_ID=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_key>
```

Verify current user is one created by terraform after exported env vars

```
aws sts get-caller-identity
```

Try to copy a file to the bucket

```
aws s3 cp <somefile> s3://<bucket_name>
```

