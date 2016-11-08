## This file was auto-generated by CloudCoreo CLI
## This file was automatically generated using the CloudCoreo CLI
##
## This config.rb file exists to create and maintain services not related to compute.
## for example, a VPC might be maintained using:
##
## coreo_aws_vpc_vpc "my-vpc" do
##   action :sustain
##   cidr "12.0.0.0/16"
##   internet_gateway true
## end
##

coreo_uni_util_notify "advise-cloudtrail" do
  action :nothing
end

coreo_uni_util_notify "advise-ec2" do
  action :nothing
end

coreo_uni_util_notify "advise-elb" do
  action :nothing
end

coreo_uni_util_notify "advise-iam" do
  action :nothing
end

coreo_uni_util_notify "advise-rds" do
  action :nothing
end

coreo_uni_util_notify "advise-redshift" do
  action :nothing
end

coreo_uni_util_notify "advise-s3" do
  action :nothing
end

coreo_uni_util_notify "advise-aws" do
  action :notify
  type 'email'
  allow_empty ${AUDIT_AWS_ALLOW_EMPTY}
  send_on "${AUDIT_AWS_SEND_ON}"
  payload '
  {"stack name":"PLAN::stack_name","instance name":"PLAN::name", "services": {
  "cloudtrail": {
   "cloudtrail_checks":"COMPOSITE::coreo_aws_advisor_cloudtrail.advise-cloudtrail.number_checks",
   "cloudtrail_violations":"COMPOSITE::coreo_aws_advisor_cloudtrail.advise-cloudtrail.number_violations", 
   "cloudtrail_violations_ignored":"COMPOSITE::coreo_aws_advisor_cloudtrail.advise-cloudtrail.number_ignored_violations",
   "violations": COMPOSITE::coreo_aws_advisor_cloudtrail.advise-cloudtrail.report },
  "ec2": {
   "ec2_checks":"COMPOSITE::coreo_aws_advisor_ec2.advise-ec2.number_checks",
   "ec2_violations":"COMPOSITE::coreo_aws_advisor_ec2.advise-ec2.number_violations", 
   "ec2_violations_ignored":"COMPOSITE::coreo_aws_advisor_ec2.advise-ec2.number_ignored_violations",
   "violations": COMPOSITE::coreo_aws_advisor_ec2.advise-ec2.report },
  "elb": {
    "elb_checks":"COMPOSITE::coreo_aws_advisor_elb.advise-elb.number_checks",
   "elb_violations":"COMPOSITE::coreo_aws_advisor_elb.advise-elb.number_violations", 
   "elb_violations_ignored":"COMPOSITE::coreo_aws_advisor_elb.advise-elb.number_ignored_violations",
   "violations": COMPOSITE::coreo_aws_advisor_elb.advise-elb.report },
  "iam": {
    "iam_checks":"COMPOSITE::coreo_aws_advisor_iam.advise-iam.number_checks",
   "iam_violations":"COMPOSITE::coreo_aws_advisor_iam.advise-iam.number_violations", 
   "iam_violations_ignored":"COMPOSITE::coreo_aws_advisor_iam.advise-iam.number_ignored_violations",
   "violations": COMPOSITE::coreo_aws_advisor_iam.advise-iam.report },
  "rds": {
    "rds_checks":"COMPOSITE::coreo_aws_advisor_rds.advise-rds.number_checks",
   "rds_violations":"COMPOSITE::coreo_aws_advisor_rds.advise-rds.number_violations", 
   "rds_violations_ignored":"COMPOSITE::coreo_aws_advisor_rds.advise-rds.number_ignored_violations",
   "violations": COMPOSITE::coreo_aws_advisor_rds.advise-rds.report },
  "redshift": {
    "redshift_checks":"COMPOSITE::coreo_aws_advisor_redshift.advise-redshift.number_checks",
   "redshift_violations":"COMPOSITE::coreo_aws_advisor_redshift.advise-redshift.number_violations", 
   "redshift_violations_ignored":"COMPOSITE::coreo_aws_advisor_redshift.advise-redshift.number_ignored_violations",
   "violations": COMPOSITE::coreo_aws_advisor_redshift.advise-redshift.report },
  "s3": {
    "s3_checks":"COMPOSITE::coreo_aws_advisor_s3.advise-s3.number_checks",
   "s3_violations":"COMPOSITE::coreo_aws_advisor_s3.advise-s3.number_violations", 
   "s3_violations_ignored":"COMPOSITE::coreo_aws_advisor_s3.advise-s3.number_ignored_violations",
   "violations": COMPOSITE::coreo_aws_advisor_s3.advise-s3.report }
  }}'
  payload_type "${AUDIT_AWS_PAYLOAD_TYPE}"
  endpoint ({ 
              :to => '${AUDIT_AWS_ALERT_RECIPIENT}', :subject => 'CloudCoreo advisor alerts on PLAN::stack_name :: PLAN::name'
            })
end
