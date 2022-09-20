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

module "tor-a" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "tor-a"
  network_interfaces = [
    {
      network    = "tor-a"
      subnetwork = google_compute_subnetwork.subnets["tor-a"].self_link
      address    = "10.0.11.2"
      alias      = null
    },
    {
      network    = "node1"
      subnetwork = google_compute_subnetwork.subnets["node1"].self_link
      address    = "10.0.1.3"
      alias      = null
    },
    {
      network    = "node2"
      subnetwork = google_compute_subnetwork.subnets["node2"].self_link
      address    = "10.0.2.3"
      alias      = null
    },
  ]
  config          = file("./csr-conf/tor-a.config")
  ssh_key         = trimspace(file(var.ssh_key_file))
}

module "tor-b" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "tor-b"
  network_interfaces = [
    {
      network    = "tor-b"
      subnetwork = google_compute_subnetwork.subnets["tor-b"].self_link
      address    = "10.0.12.2"
      alias      = null
    },
    {
      network    = "node3"
      subnetwork = google_compute_subnetwork.subnets["node3"].self_link
      address    = "10.0.3.3"
      alias      = null
    },
    {
      network    = "node4"
      subnetwork = google_compute_subnetwork.subnets["node4"].self_link
      address    = "10.0.4.3"
      alias      = null
    },
  ]
  config          = file("./csr-conf/tor-b.config")
  ssh_key         = trimspace(file(var.ssh_key_file))
}
