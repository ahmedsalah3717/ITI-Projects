# DevOps Challenge Demo Code:Gcp-Project
![image info](Project/projectgcp/ProjectInfo.jpeg)

### 1-Terraform Ifrastructure
create the Terraform Infrastructure:
1-Vpc & Subnets Firewalls
2-IGW & NAT
3-Private GKE Cluster
4-create the providers file ofcourse 
5-create the private vm 
 
###terraform Commannds that might help 

```bash
terraform init 
terraform plan 
terraform apply
```

### 2-clone the repo from https://github.com/atefhares DevOps-Challenge-Demo-Code

```bash
 $git clone git@github.com:atefhares/DevOps-Challenge-Demo-Code.git 

```

### 3-Build The Python docker image then push it to the GCE you created using Terraform 
build the repo with command:
```bash
docker build -t gcr.io/peerless-aria-377213/devops-challenge-image . 
docker push gcr.io/peerless-aria-377213/devops-challenge-image:latest

#replace peerless-aria-377213 with your Project name then name the image what ever you want 
```
![image info](Project/projectgcp/screenshots/buildandpushimage.png)

3-Build The Redis docker image then push it to the GCE you created using Terraform 
```bash
docker build -t gcr.io/peerless-aria-377213/redis-image .
docker push gcr.io/peerless-aria-377213/redis-image:latest
```
![image info](Project/projectgcp/screenshots/redis-image-Build&Push.png)

-------------------- GCP ScreenShots --------------------

1-Providers&project
![image info](Project//projectgcp/screenshots/providers&projectName.png)
2.Nat&Subnets
![image info](Project//projectgcp/screenshots/nat&subnets.png)
3.Firewalls&GKE
![image info](Project//projectgcp/screenshots/firewalls&GKE.png)
4.SAS&GKE
![image info](/Project/projectgcp/screenshots/ServiceAccounts&VMS.png)

Deploying Using Kubectl 
```bash
$ kubectl apply -f .
```




