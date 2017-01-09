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

coreo_uni_util_notify "advise-cloudtrail-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-cloudtrail-rollup" do
  action :nothing
end

coreo_uni_util_notify "advise-ec2-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-ec2-rollup" do
  action :nothing
end

coreo_uni_util_notify "advise-elb-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-elb-rollup" do
  action :nothing
end

coreo_uni_util_notify "advise-iam-html-report" do
  action :nothing
end
coreo_uni_util_notify "advise-iam-rollup" do
  action :nothing
end

coreo_uni_util_notify "advise-rds-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-rds-rollup" do
  action :nothing
end

coreo_uni_util_notify "advise-redshift-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-redshift-rollup" do
  action :nothing
end

coreo_uni_util_notify "advise-s3-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-s3-rollup" do
  action :nothing
end
# test

=begin
  START AWS S3 METHODS
  JSON SEND METHOD
  HTML SEND METHOD
=end


coreo_uni_util_notify "advise-aws-full-json" do
  action :nothing
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
  payload_type "json"
  endpoint ({
      :to => '${AUDIT_AWS_ALERT_RECIPIENT}', :subject => 'CloudCoreo advisor alerts on PLAN::stack_name :: PLAN::name'
  })
end



coreo_uni_util_jsrunner "tags-to-notifiers-array-aws" do
  action :run
  data_type "json"
  packages([
               {
                   :name => "cloudcoreo-jsrunner-commons",
                   :version => "1.4.1"
               }       ])
  json_input '
  {"composite name":"PLAN::stack_name","plan name":"PLAN::name", "services": {
  "cloudtrail": {
   "composite name":"PLAN::stack_name",
   "plan name":"PLAN::name",
   "audit name": "CloudTrail",
   "violations": COMPOSITE::coreo_aws_advisor_cloudtrail.advise-cloudtrail.report },
  "ec2": {
   "audit name": "EC2",
   "violations": COMPOSITE::coreo_aws_advisor_ec2.advise-ec2.report },
  "iam": {
   "audit name": "IAM",
   "violations": COMPOSITE::coreo_aws_advisor_iam.advise-iam.report },
  "elb": {
   "audit name": "ELB",
   "violations": COMPOSITE::coreo_aws_advisor_elb.advise-elb.report },
  "rds": {
   "audit name": "RDS",
   "violations": COMPOSITE::coreo_aws_advisor_rds.advise-rds.report },
  "redshift": {
   "audit name": "REDSHIFT",
   "violations": COMPOSITE::coreo_aws_advisor_redshift.advise-redshift.report },
  "s3": {
   "audit name": "S3",
   "violations": COMPOSITE::coreo_aws_advisor_s3.advise-s3.report }
  }}'
  function <<-EOH
  
const CloudCoreoJSRunner = require('cloudcoreo-jsrunner-commons');

const WHAT_NEED_TO_SHOWN = {
    OBJECT_ID: {
        headerName: 'AWS Object ID',
        isShown: true,
    },
    REGION: {
        headerName: 'Region',
        isShown: true,
    },
    AWS_CONSOLE: {
        headerName: 'AWS Console',
        isShown: true,
    },
    TAGS: {
        headerName: 'Tags',
        isShown: true,
    },
    AMI: {
        headerName: 'AMI',
        isShown: false,
    },
    KILL_SCRIPTS: {
        headerName: 'Kill Cmd',
        isShown: false,
    }
};


const JSON = json_input;
const NO_OWNER_EMAIL = "${AUDIT_AWS_ALERT_RECIPIENT}";
const OWNER_TAG = "${AUDIT_AWS_OWNER_TAG}";
const ALLOW_EMPTY = "${AUDIT_AWS_ALLOW_EMPTY}";
const SEND_ON = "${AUDIT_AWS_SEND_ON}";


const ARE_KILL_SCRIPTS_SHOWN = false;
const EC2_LOGIC = ''; // you can choose 'and' or 'or';
const EXPECTED_TAGS = [];

const VARIABLES_CLOUDTRAIL = {
    'NO_OWNER_EMAIL': NO_OWNER_EMAIL,
    'OWNER_TAG': OWNER_TAG,
    'AUDIT_NAME': 'cloudtrail',
    'ARE_KILL_SCRIPTS_SHOWN': ARE_KILL_SCRIPTS_SHOWN,
    'EC2_LOGIC': EC2_LOGIC,
    'EXPECTED_TAGS': EXPECTED_TAGS,
    WHAT_NEED_TO_SHOWN,
    ALLOW_EMPTY,
    SEND_ON
};

const VARIABLES_EC2 = {
    'NO_OWNER_EMAIL': NO_OWNER_EMAIL,
    'OWNER_TAG': OWNER_TAG,
    'AUDIT_NAME': 'ec2',
    'ARE_KILL_SCRIPTS_SHOWN': ARE_KILL_SCRIPTS_SHOWN,
    'EC2_LOGIC': EC2_LOGIC,
    'EXPECTED_TAGS': EXPECTED_TAGS,
    WHAT_NEED_TO_SHOWN,
    ALLOW_EMPTY,
    SEND_ON
};

const VARIABLES_ELB = {
    'NO_OWNER_EMAIL': NO_OWNER_EMAIL,
    'OWNER_TAG': OWNER_TAG,
    'AUDIT_NAME': 'elb',
    'ARE_KILL_SCRIPTS_SHOWN': ARE_KILL_SCRIPTS_SHOWN,
    'EC2_LOGIC': EC2_LOGIC,
    'EXPECTED_TAGS': EXPECTED_TAGS,
    WHAT_NEED_TO_SHOWN,
    ALLOW_EMPTY,
    SEND_ON
};

const VARIABLES_RDS = {
    'NO_OWNER_EMAIL': NO_OWNER_EMAIL,
    'OWNER_TAG': OWNER_TAG,
    'AUDIT_NAME': 'rds',
    'ARE_KILL_SCRIPTS_SHOWN': ARE_KILL_SCRIPTS_SHOWN,
    'EC2_LOGIC': EC2_LOGIC,
    'EXPECTED_TAGS': EXPECTED_TAGS,
    WHAT_NEED_TO_SHOWN,
    ALLOW_EMPTY,
    SEND_ON
};

const VARIABLES_REDSHIFT = {
    'NO_OWNER_EMAIL': NO_OWNER_EMAIL,
    'OWNER_TAG': OWNER_TAG,
    'AUDIT_NAME': 'redshift',
    'ARE_KILL_SCRIPTS_SHOWN': ARE_KILL_SCRIPTS_SHOWN,
    'EC2_LOGIC': EC2_LOGIC,
    'EXPECTED_TAGS': EXPECTED_TAGS,
    WHAT_NEED_TO_SHOWN,
    ALLOW_EMPTY,
    SEND_ON
};

const VARIABLES_S3 = {
    'NO_OWNER_EMAIL': NO_OWNER_EMAIL,
    'OWNER_TAG': OWNER_TAG,
    'AUDIT_NAME': 's3',
    'ARE_KILL_SCRIPTS_SHOWN': ARE_KILL_SCRIPTS_SHOWN,
    'EC2_LOGIC': EC2_LOGIC,
    'EXPECTED_TAGS': EXPECTED_TAGS,
    WHAT_NEED_TO_SHOWN,
    ALLOW_EMPTY,
    SEND_ON
};

const VARIABLES_IAM = {
    'NO_OWNER_EMAIL': NO_OWNER_EMAIL,
    'OWNER_TAG': OWNER_TAG,
    'AUDIT_NAME': 'iam',
    'ARE_KILL_SCRIPTS_SHOWN': ARE_KILL_SCRIPTS_SHOWN,
    'EC2_LOGIC': EC2_LOGIC,
    'EXPECTED_TAGS': EXPECTED_TAGS,
    WHAT_NEED_TO_SHOWN,
    ALLOW_EMPTY,
    SEND_ON
};


const cloudtrail = new CloudCoreoJSRunner(json_input['services']['cloudtrail'], VARIABLES_CLOUDTRAIL);
const ec2 = new CloudCoreoJSRunner(JSON['services']['ec2'], VARIABLES_EC2);
const elb = new CloudCoreoJSRunner(JSON['services']['elb'], VARIABLES_ELB);
const rds = new CloudCoreoJSRunner(JSON['services']['rds'], VARIABLES_RDS);
const redshift = new CloudCoreoJSRunner(JSON['services']['redshift'], VARIABLES_REDSHIFT);
const s3 = new CloudCoreoJSRunner(JSON['services']['s3'], VARIABLES_S3);
const iam = new CloudCoreoJSRunner(JSON['services']['iam'], VARIABLES_IAM);

const cloudtrailNotifiers = cloudtrail.getNotifiers();
const ec2Notifiers = ec2.getNotifiers();
const elbNotifiers = elb.getNotifiers();
const rdsNotifiers = rds.getNotifiers();
const redshiftNotifiers = redshift.getNotifiers();
const s3Notifiers = s3.getNotifiers();
const iamNotifiers = iam.getNotifiers();

const notifiersSet = new Set();


cloudtrailNotifiers.forEach(notifier => {
    notifiersSet.add(notifier);
});
ec2Notifiers.forEach(notifier => {
    notifiersSet.add(notifier);
});
elbNotifiers.forEach(notifier => {
    notifiersSet.add(notifier);
});
rdsNotifiers.forEach(notifier => {
    notifiersSet.add(notifier);
});
redshiftNotifiers.forEach(notifier => {
    notifiersSet.add(notifier);
});
s3Notifiers.forEach(notifier => {
    notifiersSet.add(notifier);
});

iamNotifiers.forEach(notifier => {
    notifiersSet.add(notifier);
});

const notifiers = [];

notifiersSet.forEach((notifier1, index1) => {
    notifiersSet.forEach((notifier2, index2) => {
        if (index1 !== index2) {
            if (notifier1.endpoint.to === notifier2.endpoint.to) {
                notifier1.payload += notifier2.payload;
                let numViol = 0;
                numViol+= parseInt(notifier1.num_violations);
                numViol+= parseInt(notifier2.num_violations);
                numViol = numViol.toString();
                notifier1.num_violations = numViol;
                notifiersSet.delete(notifier2);
            }
        }
    });
});


notifiersSet.forEach(notifier => {
    notifiers.push(notifier);
});


callback(notifiers);
  EOH
end

coreo_uni_util_jsrunner "tags-rollup-aws" do
  action :run
  data_type "text"
  json_input 'COMPOSITE::coreo_uni_util_jsrunner.tags-to-notifiers-array-aws.return'
  function <<-EOH
var rollup_string = "";
let rollup = '';
let emailText = '';
let numberOfViolations = 0;
for (var entry=0; entry < json_input.length; entry++) {
    if (json_input[entry]['endpoint']['to'].length) {
        numberOfViolations += parseInt(json_input[entry]['num_violations']);
        emailText += "recipient: " + json_input[entry]['endpoint']['to'] + " - " + "nViolations: " + json_input[entry]['num_violations'] + "\\n";
    }
}

rollup += 'number of Violations: ' + numberOfViolations + "\\n";
rollup += 'Rollup' + "\\n";
rollup += emailText;

rollup_string = rollup;
callback(rollup_string);
  EOH
end

coreo_uni_util_notify "advise-aws-to-tag-values" do
  action :${AUDIT_AWS_HTML_REPORT}
  notifiers 'COMPOSITE::coreo_uni_util_jsrunner.tags-to-notifiers-array-aws.return'
end

coreo_uni_util_notify "advise-aws-rollup" do
  action :${AUDIT_AWS_ROLLUP_REPORT}
  type 'email'
  allow_empty true
  send_on 'always'
  payload '
composite name: PLAN::stack_name
plan name: PLAN::name
COMPOSITE::coreo_uni_util_jsrunner.tags-rollup-aws.return
  '
  payload_type 'text'
  endpoint ({
      :to => '${AUDIT_AWS_ALERT_RECIPIENT}', :subject => 'CloudCoreo aws advisor alerts on PLAN::stack_name :: PLAN::name'
  })
end
