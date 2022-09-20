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

#############################
#### data and variables
#############################
data "google_folder" "workloads" {
  folder = "folders/550748890019"
}

resource "google_project" "bgp-with-nva" {
  name                = "bgp-with-nva"
  project_id          = var.project_id
  folder_id           = var.folder_id
  billing_account     = var.billing-account-id
  auto_create_network = false
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_project_service" "bgp-with-nva" {
  for_each                   = toset([
    "compute.googleapis.com",
    "iap.googleapis.com",
    "iam.googleapis.com",
    "cloudbuild.googleapis.com",
    "logging.googleapis.com",
  ])
  project                    = google_project.bgp-with-nva.id
  service                    = each.key
  disable_dependent_services = true
}

