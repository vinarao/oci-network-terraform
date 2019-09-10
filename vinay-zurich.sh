export TF_VAR_tenancy_ocid=ocid1.tenancy.oc1..aaaaaaaa4gep7cixk2ky6et7l2nj2n6ugjq5fyi26mjnyxk5ehmowl3unenq
export TF_VAR_user_ocid=ocid1.user.oc1..aaaaaaaaa46dsn42bkks7wgzzkxj6zekf2uikb7wwkbiwz5t4qjj6eohzc2a
#export TF_VAR_fingerprint=71:9c:f6:6f:76:a5:e4:8e:98:8d:f7:c3:0f:50:f0:9c
export TF_VAR_fingerprint=e1:42:2f:a1:23:e2:25:5e:cf:1c:9b:0d:f5:0d:71:48
### Region
export TF_VAR_region=ap-sydney-1
### Compartment
export TF_VAR_compartment_ocid=ocid1.compartment.oc1..aaaaaaaa4pzsicew56cxzjdicfjyop3awalvy57uro6lgw5o24hnbhkwncfq
export TF_VAR_public_key_path=oci_api_new_key_public.pem
export TF_VAR_private_key_path=oci_api_new_key.pem
##Compute
export TF_VAR_image_ocid="ocid1.image.oc1.ap-sydney-1.aaaaaaaazxqgyblayejmgoabszoc7psza3hyf33z4ovyw4v74zbke6vnufia"
export TF_VAR_instance_shape="VM.Standard2.2"
##Key
export TF_VAR_ssh_public_key_path=$(cat vinay_ssh.pub)
export TF_VAR_ssh_public_key=$(cat vinay_ssh.pub)
export TF_VAR_ssh_authorized_private_key=$(cat vinay_ssh)
export TF_VAR_private_key_password=$(cat vinay_ssh)
export TF_VAR_customer_network="172.20.0.0/24"
