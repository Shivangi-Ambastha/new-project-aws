output "instance_role_arn" {
  value = aws_iam_role.instance_role.arn
}

output "instance_role_id" {
  value = aws_iam_role.instance_role.id
}

output "instance_role_name" {
  value = aws_iam_role.instance_role.name
}

output "instance_profile_arn" {
  value = var.create_iam_instance_profile ? aws_iam_instance_profile.instance_profile[0].arn : null
}

output "instance_profile_name" {
  value = var.create_iam_instance_profile ? aws_iam_instance_profile.instance_profile[0].name : null
}