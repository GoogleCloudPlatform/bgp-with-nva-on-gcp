/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "node1" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "node1"
  network_interfaces = [
    {
      network    = "node1"
      subnetwork = google_compute_subnetwork.subnets["node1"].self_link
      address    = "10.0.1.2"
      alias      = null
    },
  ]
  ssh_key         = trimspace(file(var.ssh_key_file))
  config = templatefile("./csr-conf/nodes.config", {
    router-id          = "11.11.11.11"
    tunnel0-ip         = "192.168.1.2"
    peer-address       = "10.0.1.3"
    peer-bgp-address   = "192.168.1.3"
    local-as           = "65001"
    peer-as            = "65001"
    advertised-network = "1.1.1.0"
    local-loopback     = "1.1.1.1"
  })
}

module "node2" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "node2"
  network_interfaces = [
    {
      network    = "node2"
      subnetwork = google_compute_subnetwork.subnets["node2"].self_link
      address    = "10.0.2.2"
      alias      = null
    },
  ]
  ssh_key         = trimspace(file(var.ssh_key_file))
  config = templatefile("./csr-conf/nodes.config", {
    router-id          = "12.12.12.12"
    tunnel0-ip         = "192.168.2.2"
    peer-address       = "10.0.2.3"
    peer-bgp-address   = "192.168.2.3"
    local-as           = "65001"
    peer-as            = "65001"
    advertised-network = "2.2.2.0"
    local-loopback     = "2.2.2.2"
  })
}

module "node3" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "node3"
  network_interfaces = [
    {
      network    = "node3"
      subnetwork = google_compute_subnetwork.subnets["node3"].self_link
      address    = "10.0.3.2"
      alias      = null
    },
  ]
  ssh_key         = trimspace(file(var.ssh_key_file))
  config = templatefile("./csr-conf/nodes.config", {
    router-id          = "13.13.13.13"
    tunnel0-ip         = "192.168.3.2"
    peer-address       = "10.0.3.3"
    peer-bgp-address   = "192.168.3.3"
    local-as           = "65002"
    peer-as            = "65002"
    advertised-network = "3.3.3.0"
    local-loopback     = "3.3.3.3"
  })
}

module "node4" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "node4"
  network_interfaces = [
    {
      network    = "node4"
      subnetwork = google_compute_subnetwork.subnets["node4"].self_link
      address    = "10.0.4.2"
      alias      = null
    },
  ]
  ssh_key         = trimspace(file(var.ssh_key_file))
  config = templatefile("./csr-conf/nodes.config", {
    router-id          = "14.14.14.14"
    tunnel0-ip         = "192.168.4.2"
    peer-address       = "10.0.4.3"
    peer-bgp-address   = "192.168.4.3"
    local-as           = "65002"
    peer-as            = "65002"
    advertised-network = "4.4.4.0"
    local-loopback     = "4.4.4.4"
  })
}
