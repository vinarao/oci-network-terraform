// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
output "lb_public_ip" {
  value = ["${oci_load_balancer.public-lb.ip_addresses}"]
}

output "lb_public2_ip" {
  value = ["${oci_load_balancer.public-lb2.ip_addresses}"]
}

/* output "lb_public3_ip" {
  value = ["${oci_load_balancer.public-lb3.ip_addresses}"]
}
 */

output "lb_private_ip" {
  value = ["${oci_load_balancer.private-lb.ip_addresses}"]
}

output "lb_private2_ip" {
  value = ["${oci_load_balancer.private-lb2.ip_addresses}"]
}
/* output "lb_private3_ip" {
  value = ["${oci_load_balancer.private-lb3.ip_addresses}"]
} */

output "bastion_public_ip" {
  value = ["${oci_core_instance.vcn1-bastion.public_ip}"]
}
