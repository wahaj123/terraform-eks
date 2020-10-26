provider "aws" {
  region = "us-east-2"
   ignore_tags {
    key_prefixes = ["kubernetes.io/cluster/"]
  }
}
