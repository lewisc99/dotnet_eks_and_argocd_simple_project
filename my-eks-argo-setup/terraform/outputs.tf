output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "argo_cd_server_url" {
  # Assuming the Argo CD server uses a LoadBalancer.
  value = helm_release.argocd.status[0].load_balancer[0].ingress[0].hostname
}