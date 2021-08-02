# Terraform Part

1. Configure VPC and Subnetwork
2. Configure google_project_service with:
    "container.googleapis.com",
    "monitoring.googleapis.com",
    "cloudtrace.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudprofiler.googleapis.com"
3. Configure Cluster and Node Pool. They should be independent from each other in order to change nodes easier in future

4. git copy from https://github.com/GoogleCloudPlatform/microservices-demo for website resources 

# Kubernetes part 

5. Apply content of yaml file
```bash
kubectl apply -f ./release/kubernetes-manifests.yaml
```

6. Check if all pods are running
```bash
kubectl get pods
```
7. Access the web frontend in a browser using the frontend's EXTERNAL_IP.
```bash
kubectl get service frontend-external | awk '{print $4}'
```
# Error
1. The connection to the server localhost:8080 was refused - did you specify the right host or port?
Solution: 
```bash
gcloud container clusters get-credentials <name of the container>
```

# Unresolved Error
Error: Error when reading or editing Project Service dotted-chiller-320309/cloudtrace.googleapis.com: Error disabling service "cloudtrace.googleapis.com" for project "dotted-chiller-320309": googleapi: Error 400: The service cloudtrace.googleapis.com is depended on by the following active service(s): cloudapis.googleapis.com; Please specify disable_dependent_services=true if you want to proceed with disabling all services.
│ Help Token: Ae-hA1NL05cuJUZk5Yvs_9BFgpNL3Rhv31P6vEPYGCr0YQ-Q7jHDdwxCwytF_-uuveWGWUn5sRowf5J4BzJHpEWi_yPMBqAFQ42SIs0EhFZWkEXkfLZnbp4=, failedPrecondition
