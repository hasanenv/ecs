resource "aws_iam_role_policy_attachment" "cicd_read_attach" {
  role       = data.aws_iam_role.cicd.name
  policy_arn = aws_iam_policy.cicd_read.arn
}

resource "aws_iam_role_policy_attachment" "cicd_apply_attach" {
  role       = data.aws_iam_role.cicd.name
  policy_arn = aws_iam_policy.cicd_apply.arn
}