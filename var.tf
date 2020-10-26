variable "public_subnet" {
    default = ["13.0.1.0/24", "13.0.2.0/24"]
}
variable "private_subnet" {
    default= ["13.0.3.0/24", "13.0.4.0/24"]
}
variable "vpc_cidr" {
    default="13.0.0.0/16"
}
variable "instance_type"{
    default = ["t2.micro"]
}
variable "key-pair"{
    default= "Wahaj-ohio"
}
variable "kubeversion" {
    default = 1.17
}
variable "clustername"{
    default= "wahaj-eks"
}