#creating the service account 
resource "google_service_account" "vm-service-account" {
  account_id   = "default-vm-service-account"
  display_name = "sa-private-vm"
}

resource "google_project_iam_member" "cluster-admin" {
  project = "peerless-aria-377213"
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.vm-service-account.email}"
}


#creating the private VM
resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a" 
#   user_data                   = file("userdata.sh")
 
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  metadata = {
  user-data = file("userdata.sh")
  enable-oslogin = "TRUE"
  }
  tags = ["management-vm"]
  network_interface {
    subnetwork = google_compute_subnetwork.management_subnet.id
   
  }

  service_account {
    email = google_service_account.vm-service-account.email
    scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  
}