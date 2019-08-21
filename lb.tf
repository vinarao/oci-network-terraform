// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.
/* Load Balancer */
resource "oci_load_balancer" "public-lb" {
  shape          = "100Mbps"
  compartment_id = "${var.compartment_ocid}"
  is_private = "false"
  subnet_ids = [
    "${oci_core_subnet.public_subnet1.id}",
  ]

  #"${oci_core_subnet.public_subnet2.id}"

  display_name = "public-lb"
}

resource "oci_load_balancer" "public-lb2" {
  shape          = "400Mbps"
  compartment_id = "${var.compartment_ocid}"
  is_private = "false"
  subnet_ids = [
    "${oci_core_subnet.public_subnet1.id}",
  ]

  #"${oci_core_subnet.public_subnet2.id}"

  display_name = "public-lb"
}

/* resource "oci_load_balancer" "public-lb3" {
  shape          = "8000Mbps"
  compartment_id = "${var.compartment_ocid}"
  is_private = "false"
  subnet_ids = [
    "${oci_core_subnet.public_subnet1.id}",
  ]

  #"${oci_core_subnet.public_subnet2.id}"

  display_name = "public-lb"
} */
resource "oci_load_balancer" "private-lb" {
  shape          = "100Mbps"
  compartment_id = "${var.compartment_ocid}"
  is_private = "true"
  subnet_ids = [
    "${oci_core_subnet.private_subnet1.id}",
  ]

  display_name = "private-lb"
}

resource "oci_load_balancer" "private-lb2" {
  shape          = "400Mbps"
  compartment_id = "${var.compartment_ocid}"
  is_private = "true"
  subnet_ids = [
    "${oci_core_subnet.private_subnet1.id}",
  ]

  display_name = "private-lb"
}

/* resource "oci_load_balancer" "private-lb3" {
  shape          = "8000Mbps"
  compartment_id = "${var.compartment_ocid}"
  is_private = "true"
  subnet_ids = [
    "${oci_core_subnet.private_subnet1.id}",
  ]

  display_name = "private-lb"
}
 */

resource "oci_load_balancer_backend_set" "web-lb1-bes1" {
  name             = "web-lb-bes1"
  load_balancer_id = "${oci_load_balancer.public-lb.id}"
  policy           = "ROUND_ROBIN"

  session_persistence_configuration {
    #Required
    cookie_name = "JSESSIONID"
  }

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

resource "oci_load_balancer_backend_set" "web-lb2-bes1" {
  name             = "web-lb-bes1-2"
  load_balancer_id = "${oci_load_balancer.public-lb2.id}"
  policy           = "ROUND_ROBIN"

  session_persistence_configuration {
    #Required
    cookie_name = "JSESSIONID"
  }

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}
/* resource "oci_load_balancer_backend_set" "web-lb3-bes1" {
  name             = "web-lb-3-bes1"
  load_balancer_id = "${oci_load_balancer.public-lb3.id}"
  policy           = "ROUND_ROBIN"

  session_persistence_configuration {
    #Required
    cookie_name = "JSESSIONID"
  }

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
} */

resource "oci_load_balancer_backend_set" "web-lb1-bes2" {
  name             = "web-lb-bes2"
  load_balancer_id = "${oci_load_balancer.private-lb.id}"
  policy           = "ROUND_ROBIN"

  session_persistence_configuration {
    #Required
    cookie_name = "JSESSIONID"
  }

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

resource "oci_load_balancer_backend_set" "web-lb2-bes2" {
  name             = "web-lb2-bes2"
  load_balancer_id = "${oci_load_balancer.private-lb2.id}"
  policy           = "ROUND_ROBIN"

  session_persistence_configuration {
    #Required
    cookie_name = "JSESSIONID"
  }

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

/* resource "oci_load_balancer_backend_set" "web-lb3-bes2" {
  name             = "web-lb-3-bes2"
  load_balancer_id = "${oci_load_balancer.private-lb3.id}"
  policy           = "ROUND_ROBIN"

  session_persistence_configuration {
    #Required
    cookie_name = "JSESSIONID"
  }

  health_checker {
    port                = "8080"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
} */

  resource "oci_load_balancer_certificate" "lb-cert1" {
  load_balancer_id   = "${oci_load_balancer.public-lb.id}"
  private_key    = "${data.template_file.privkey.rendered}"
  certificate_name   = "${var.hostname}"
  #ca_certificate        = "${data.template_file.cacert.rendered}"
  public_certificate = "${data.template_file.cert.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
  
    resource "oci_load_balancer_certificate" "lb-cert2" {
  load_balancer_id   = "${oci_load_balancer.public-lb2.id}"
  private_key    = "${data.template_file.privkey.rendered}"
  certificate_name   = "${var.hostname}"
  #ca_certificate        = "${data.template_file.cacert.rendered}"
  public_certificate = "${data.template_file.cert.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}/* 
  resource "oci_load_balancer_certificate" "lb-cert3" {
  load_balancer_id   = "${oci_load_balancer.public-lb3.id}"
  private_key    = "${data.template_file.privkey.rendered}"
  certificate_name   = "${var.hostname}"
  ca_certificate        = "${data.template_file.cacert.rendered}"
  public_certificate = "${data.template_file.cert.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
 */
  resource "oci_load_balancer_certificate" "lb-cert2-1" {
  load_balancer_id   = "${oci_load_balancer.private-lb.id}"
  private_key    = "${data.template_file.privkey.rendered}"
  certificate_name   = "${var.hostname}"
  #ca_certificate        = "${data.template_file.cacert.rendered}"
  public_certificate = "${data.template_file.cert.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
  
    resource "oci_load_balancer_certificate" "lb-cert2-2" {
  load_balancer_id   = "${oci_load_balancer.private-lb2.id}"
  private_key    = "${data.template_file.privkey.rendered}"
  certificate_name   = "${var.hostname}"
  #ca_certificate        = "${data.template_file.cacert.rendered}"
  public_certificate = "${data.template_file.cert.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
/*   resource "oci_load_balancer_certificate" "lb-cert2-3" {
  load_balancer_id   = "${oci_load_balancer.private-lb3.id}"
  private_key    = "${data.template_file.privkey.rendered}"
  certificate_name   = "${var.hostname}"
  #ca_certificate        = "${data.template_file.cacert.rendered}"
  public_certificate = "${data.template_file.cert.rendered}"

  lifecycle {
    create_before_destroy = true
  }
} */
resource "oci_load_balancer_hostname" "test_hostname1" {
  #Required
  hostname         = "${var.hostname}"
  load_balancer_id = "${oci_load_balancer.public-lb.id}"
  name             = "hostname1"
}

resource "oci_load_balancer_listener" "lb-listener1" {
  load_balancer_id         = "${oci_load_balancer.public-lb.id}"
  name                     = "http80"
  default_backend_set_name = "${oci_load_balancer_backend_set.web-lb1-bes1.name}"
  hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_listener" "lb-listener1-2" {
  load_balancer_id         = "${oci_load_balancer.public-lb2.id}"
  name                     = "http80"
  default_backend_set_name = "${oci_load_balancer_backend_set.web-lb2-bes1.name}"
  #hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}


/* resource "oci_load_balancer_listener" "lb-listener1-3" {
  load_balancer_id         = "${oci_load_balancer.public-lb3.id}"
  name                     = "http80"
  default_backend_set_name = "${oci_load_balancer_backend_set.web-lb3-bes1.name}"
  #hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}
 */

resource "oci_load_balancer_listener" "lb-listener2" {
  load_balancer_id         = "${oci_load_balancer.private-lb.id}"
  name                     = "http80"
  default_backend_set_name = "${oci_load_balancer_backend_set.web-lb1-bes2.name}"
  #hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}


resource "oci_load_balancer_listener" "lb-listener2-2" {
  load_balancer_id         = "${oci_load_balancer.private-lb2.id}"
  name                     = "http80"
  default_backend_set_name = "${oci_load_balancer_backend_set.web-lb2-bes2.name}"
  #hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}


/* resource "oci_load_balancer_listener" "lb-listener2-3" {
  load_balancer_id         = "${oci_load_balancer.public-lb3.id}"
  name                     = "http80"
  default_backend_set_name = "${oci_load_balancer_backend_set.web-lb3-bes2.name}"
  #hostname_names           = ["${oci_load_balancer_hostname.test_hostname1.name}"]
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}
 */


resource "oci_load_balancer_path_route_set" "test_path_route_set" {
  #Required
  load_balancer_id = "${oci_load_balancer.public-lb.id}"
  name             = "pr-set1"

  path_routes {
    #Required
    backend_set_name = "${oci_load_balancer_backend_set.web-lb1-bes1.name}"
    path             = "/sample"

    path_match_type {
      #Required
      match_type = "PREFIX_MATCH"
    }
  }
}

resource "oci_load_balancer_path_route_set" "test_path_route_set_private" {
  #Required
  load_balancer_id = "${oci_load_balancer.private-lb.id}"
  name             = "pr-set1"

  path_routes {
    #Required
    backend_set_name = "${oci_load_balancer_backend_set.web-lb1-bes2.name}"
    path             = "/sample"

    path_match_type {
      #Required
      match_type = "PREFIX_MATCH"
    }
  }
}
resource "oci_load_balancer_rule_set" "test_rule_set" {
  items {
    action = "ADD_HTTP_REQUEST_HEADER"
    header = "WL-Proxy-SSL"
    value  = "true"
  }

  load_balancer_id = "${oci_load_balancer.public-lb.id}"
  name             = "example_rule_set_name"
}
