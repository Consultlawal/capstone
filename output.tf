output "public_ip_EC2" {
  value = aws_instance.USTeam2_ACP-web.public_ip
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.USTeam2_ACP_distribution.domain_name
}

output "ns_records" {
  value = aws_route53_zone.usteam2-acp-zone.name_servers
}

output "name_servers" {
  value = aws_route53_record.usteam2-acp-www.name
}
output "loadbalancer" {
  value = aws_lb.USTeam2_ACP-alb.dns_name

}

# output "Redis_testing" {
#   value = aws_elasticache_replication_group.elasticache-cluster.primary_endpoint_address
  
# }

# output "EFS" {
#   value = aws_efs_mount_target.alpha.dns_name
  
# }