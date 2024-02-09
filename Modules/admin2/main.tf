module "webserver" {
  source = "../nginx"
  instance_type = t2.micro
}