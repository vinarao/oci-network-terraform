// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
variable "tenancy_ocid" {}

variable "user_ocid" {}
variable "fingerprint" {}
variable "customer_network" {}
variable "private_key_path" {}
variable "private_key_password" {}
variable "compartment_ocid" {}
variable "region" {}
variable "instance_shape" {}
variable "autoscale_instance_shape" {}
variable "availability_domain" {}

variable "instance_image_ocid" {
  type = "map"

  default = {
    // See https://docs.us-phoenix-1.oraclecloud.com/images/
    // Oracle-provided image "Oracle-Linux-7.4-2018.02.21-1"
    us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaaupbfz5f5hdvejulmalhyb6goieolullgkpumorbvxlwkaowglslq"
    ap-mumbai-1    = "ocid1.image.oc1.ap-mumbai-1.aaaaaaaaf6bipkx4bexuqwkjhttzkccoew6jktnskasx7g46mnpfp5p2uncq"
    ap-sydney-1    = "ocid1.image.oc1.ap-sydney-1.aaaaaaaazxqgyblayejmgoabszoc7psza3hyf33z4ovyw4v74zbke6vnufia"
    sa-saopaulo-1  = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaacvzqswlkixoj4mmhyvxajburto5ulbicbh4pssfgqf5efmsowqga"
    ap-tokyo-1   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaabf42ugaxsbovl7jjyef5kkucvie43eo3a3m3aluxvw7yiymzxhfa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaajlw3xfie2t5t52uegyhiq2npx7bqyu4uvi2zyu3w3mqayc2bxmaa"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa7d3fsb6272srnftyi4dphdgfjf6gurxqhmv6ileds7ba3m2gltxq"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaaa6h6gj6v4n56mqrbgnosskq63blyv2752g36zerymy63cfkojiiq"
    eu-zurich-1    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaakidf6ybt4ea3sldl2wzlkcy2ojijzbt5wfpkrjs3gwtvtfrskrbq"
  }
}

variable "hostname" {}
variable "admin_subnet" {}
variable "assign_public_ip_instance" {}

variable "ssh_public_key_path" {}

variable "instance_count" {}
