# `chusri/postgres-client-awscli:alpine-3.21-pg17`

Minimal Docker image based on Alpine 3.21 containing:
- PostgreSQL 17 client (`psql`)
- AWS CLI v2

Perfect for database operations, backup, and restore tasks in Kubernetes CronJobs, CI/CD pipelines, and scripting environments.

---

## 🧰 Included Tools

| Tool               | Version  |
|--------------------|----------|
| Alpine Linux       | 3.21     |
| PostgreSQL Client	 | 17.x     |
| AWS CLI            | v2.x     |

---

## 🐳 Docker Hub

```bash
docker pull chusri/postgres-client-awscli:alpine-3.21-pg17
```

## 🚀 Usage

### 📦 Usage Examples

Connect to a PostgreSQL database

```bash
docker run --rm chusri/postgres-client-awscli:alpine-3.21-pg17 \
  psql -h your-db-hostname -U your-username -d your-database
```

Backup a PostgreSQL database to a file

```bash
docker run --rm -v $(pwd):/backup chusri/postgres-client-awscli:alpine-3.21-pg17 \
  pg_dump -h your-db-hostname -U your-username your-database > /backup/backup.sql
```

Upload backup to S3

```bash
docker run --rm -v $(pwd):/backup chusri/postgres-client-awscli:alpine-3.21-pg17 \
  aws s3 cp /backup/backup.sql s3://your-bucket-name/path/to/backup.sql
``` 

### 🛠 Kubernetes CronJob Example

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: postgres-backup
spec:
  schedule: "0 2 * * *" # every day at 2AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: backup
              image: chusri/postgres-client-awscli:alpine-3.21-pg17
              command: ["/bin/sh", "-c"]
              args:
                - |
                  pg_dump -h your-db-host -U your-user your-db > /backup/backup.sql &&
                  aws s3 cp /backup/backup.sql s3://your-bucket-name/path/to/backup.sql
              env:
                - name: AWS_ACCESS_KEY_ID
                  valueFrom:
                    secretKeyRef:
                      name: aws-secret
                      key: accessKeyId
                - name: AWS_SECRET_ACCESS_KEY
                  valueFrom:
                    secretKeyRef:
                      name: aws-secret
                      key: secretAccessKey
          restartPolicy: OnFailure
```

## 📝 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

