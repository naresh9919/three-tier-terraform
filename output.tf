output "mgt_static_public_ip_address" {
  value = module.mgt-ec2.eip[*].public_ip
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.main-alb.load_balancer.dns_name
}
