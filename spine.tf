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

module "spine-a" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "spine-a"
  network_interfaces = [
    {
      network    = "spine"
      subnetwork = google_compute_subnetwork.subnets["spine"].self_link
      address    = "10.0.21.2"
      alias      = null
    },
    {
      network    = "tor-a"
      subnetwork = google_compute_subnetwork.subnets["tor-a"].self_link
      address    = "10.0.11.3"
      alias      = null
    },
  ]
  ssh_key         = trimspace(file(var.ssh_key_file))
  config          = file("./csr-conf/spine-a.config")
}

module "spine-b" {
  source     = "./modules/csr1000v"
  project_id = var.project_id
  region     = "us-central1"
  zone       = "us-central1-b"
  name       = "spine-b"
  network_interfaces = [
    {
      network    = "spine"
      subnetwork = google_compute_subnetwork.subnets["spine"].self_link
      address    = "10.0.21.3"
      alias      = null
    },
    {
      network    = "tor-b"
      subnetwork = google_compute_subnetwork.subnets["tor-b"].self_link
      address    = "10.0.12.3"
      alias      = null
    },
  ]
  ssh_key         = trimspace(file(var.ssh_key_file))
  config          = file("./csr-conf/spine-b.config")
}
