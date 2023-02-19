resource "google_compute_router" "IGW_router" {
  name = "router"
  region = google_compute_subnetwork.management_subnet.region
  network = google_compute_network.vpc_network.id
  bgp {
    asn = 64514
  }

  
}


resource "google_compute_router_nat" "nat_gateway" {
  name = "nat-gateway"
  router = google_compute_router.IGW_router.name
  region = google_compute_router.IGW_router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  # source_subnetwork_ip_ranges_to_nat = "${google_compute_subnetwork.management_subnet.self_link}"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"


  # subnetwork {
  #   name                    = google_compute_subnetwork.management_subnet.id
  #   source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  # }



  
}




# resource "google_compute_route" "nat_route" {
#   name               = "nat-route"
#   network            = google_compute_network.vpc_network.self_link
#   dest_range         = "0.0.0.0/0"
#   next_hop_gateway   = google_compute_router_nat.nat_gateway.id
#   priority           = 800
#   tags               = ["mgmt"]
# }