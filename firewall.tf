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

module "allow-ingress-from-iap-internal" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  for_each     = toset(["node1", "node2", "node3", "node4", "tor-a", "tor-b", "spine"])
  project_id   = var.project_id
  network_name = each.key
  rules = [{
  name                    = "${each.key}-allow-ingress-from-iap-internal"
  description             = null
  direction               = "INGRESS"
  priority                = 1000
  ranges                  = ["35.235.240.0/20", "10.0.0.0/8", "192.168.0.0/16"]
  source_tags             = null
  source_service_accounts = null
  target_tags             = null
  target_service_accounts = null
  deny                   = []
  allow = [{
      protocol = "all"
      ports    = []
    }]
  log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}

module "default-deny-all" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  for_each     = toset(["node1", "node2", "node3", "node4", "tor-a", "tor-b", "spine"])
  project_id   = var.project_id
  network_name = each.key
  rules = [{
  name                    = "${each.key}-deny-all"
  description             = null
  direction               = "INGRESS"
  priority                = 65524
  ranges                  = []
  source_tags             = null
  source_service_accounts = null
  target_tags             = null
  target_service_accounts = null
  allow                   = []
  deny = [{
      protocol = "all"
      ports    = []
    }]
  log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}

