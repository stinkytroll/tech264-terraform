# GitHub Provider setup

provider "github" {
  token = var.github_token
}

# Create a new GitHub repository
resource "github_repository" "tech264_repo" {
  name        = "tech264-tf-create-github-repo"
  description = "A new repo created using Terraform"
  visibility  = "public" # Set to "private" if needed
  auto_init   = true     # Automatically create an initial commit with a README
}

# Outputs to verify repository details
output "repo_url" {
  value = github_repository.tech264_repo.html_url
}