
#Opsworks ec2 role
resource "aws_iam_role" "instance_role" {
  name               = var.name
  assume_role_policy = var.assume_role_policy
  tags               = var.tags
}

resource "aws_iam_instance_profile" "instance_profile" {
  count = var.create_iam_instance_profile ? 1 : 0

  name = var.name
  role = aws_iam_role.instance_role.name
}


resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  count = length(var.policy_arns)

  role       = aws_iam_role.instance_role.name
  policy_arn = var.policy_arns[count.index]
}
