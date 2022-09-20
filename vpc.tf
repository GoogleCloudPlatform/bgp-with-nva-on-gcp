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

#########################################
###### VPC Declaration
#########################################
resource "google_compute_network" "vpcs" {
  for_each                = toset(["node1", "node2", "node3", "node4", "tor-a", "tor-b", "spine"])
  project                 = var.project_id
  name                    = each.key
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "GLOBAL"
  lifecycle {
    prevent_destroy = true
  }
}

#########################################
###### Single subnet in each VPC
#########################################
resource "google_compute_subnetwork" "subnets" {
  for_each                = {
    node1 = "10.0.1.0/24",
    node2 = "10.0.2.0/24",
    node3 = "10.0.3.0/24",
    node4 = "10.0.4.0/24",
    tor-a = "10.0.11.0/24",
    tor-b = "10.0.12.0/24",
    spine = "10.0.21.0/24",
  }
  project                 = var.project_id
  name                    = "${each.key}-default"
  region                  = "us-central1"
  network                 = each.key
  ip_cidr_range           = each.value
  depends_on              = [google_compute_network.vpcs]
}
