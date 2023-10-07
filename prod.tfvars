ami="ami-06e46074ae430fba6"
instance_type="t2.micro"
region="eu-central-1"
vpc_cidr_block="10.0.0.0/16"
public_subnets_cidr_blocks=["10.0.1.0/24","10.0.2.0/24"]
private_subnets_cidr_blocks=["10.0.3.0/24","10.0.4.0/24"]
availability_zones=["eu-central-1c","eu-central-1d"] 
protocol="tcp"
//////
sender_email="alaa.seif.3112@gmail.com"
receiver_email="alaa.seif.3112@gmail.com"
function_name="testing-lambda-fn"
handler_name="lambda_handler"
lambda_role_name = "lambda-role"
lambda_iam_policy_name="lambda_iam_policy"
runtime="python3.8"