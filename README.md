# Final Project
![MicrosoftTeams-image (4)](https://user-images.githubusercontent.com/58382911/220772533-7d19497e-48d2-426d-a8ad-9ca2abc2f49b.png)

![MicrosoftTeams-image (5)](https://user-images.githubusercontent.com/58382911/220772602-918ac72b-df9f-4537-bfb9-5d2cf56c2950.png)

![MicrosoftTeams-image (6)](https://user-images.githubusercontent.com/58382911/220772646-ab80e335-9eac-48ff-83a0-096b4da34442.png)



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
note : you can use 2 containers in the same pod 1 for the redis image and one for the app so you don't have to create an image for redis just use the 2nd container
or 
create 2 deployment files and services and seperate gce images (I used this way at the start but changed it to the 1st method later on and updated the commit)

build the repo with command:
```bash
docker build -t gcr.io/peerless-aria-377213/devops-challenge-image . 
docker push gcr.io/peerless-aria-377213/devops-challenge-image:latest

#replace peerless-aria-377213 with your Project name then name the image what ever you want 
```
![buildandpushimage](https://user-images.githubusercontent.com/58382911/219983748-54ba51e1-5443-4de0-8939-656de3b34072.png)


3-Build The Redis docker image then push it to the GCE you created using Terraform 
```bash
docker build -t gcr.io/peerless-aria-377213/redis-image .
docker push gcr.io/peerless-aria-377213/redis-image:latest
```
![redis-image-Build Push](https://user-images.githubusercontent.com/58382911/219984107-101d053d-dd9e-4548-b2fc-f4988129a9f8.png)

after I changed the commit 



-------------------- GCP ScreenShots --------------------

1-Providers&project
![providers projectName](https://user-images.githubusercontent.com/58382911/219984383-dc2a71f1-bf74-4954-8543-953ebb1b18b7.png)
2.Nat&Subnets
![nat subnets](https://user-images.githubusercontent.com/58382911/219984345-f69a7a9c-449d-482c-8daa-762f91197a42.png)

3.Firewalls&GKE
![firewalls GKE](https://user-images.githubusercontent.com/58382911/219984402-8464276c-d302-4d7b-baf4-04bc304eafaa.png)

4.SAS&GKE
![ServiceAccounts VMS](https://user-images.githubusercontent.com/58382911/219984429-a3d2404a-8594-420d-89b2-54a79e84d03e.png)

###Deplyoing SVC and Deployment files on the vm
![Deployments SVC](https://user-images.githubusercontent.com/58382911/219984548-44730c8d-9bd4-4295-b7f4-8832b6e938b6.png)







Deploying Using Kubectl 
```bash
$ kubectl apply -f .
```




### Copy the loadBalancer Ip then paste it in your browser
```bash
$ kubectl get po,svc
``` 

### Install Jenkins and jenkins slave on the cluster & configure the slave 

![Screenshot from 2023-02-22 01-35-01](https://user-images.githubusercontent.com/58382911/220773069-c3bc137b-9ebb-470b-b065-aa82cbc2b2d7.png)

### login - building - pushing (Image to dockerhub)
![release stage sucess elhamdllah](https://user-images.githubusercontent.com/58382911/220784289-16d272c4-5c51-401c-90d1-4e95e004dc9e.png)

![Dockerhub image](https://user-images.githubusercontent.com/58382911/220784342-09ef7698-f2b7-4835-9940-36b7bec25354.png)
### logs 
![screencapture-34-28-146-6-8080-job-iti-final-job-Final-Project-1-console-2023-02-22-10_05_51](https://user-images.githubusercontent.com/58382911/220784422-980965ec-4ac0-4e77-9b25-043ebd498cc9.png)





 




