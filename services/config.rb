
coreo_uni_util_variables "aws-planwide" do
  action :set
  variables([
                {'COMPOSITE::coreo_uni_util_variables.aws-planwide.composite_name' => 'PLAN::stack_name'},
                {'COMPOSITE::coreo_uni_util_variables.aws-planwide.plan_name' => 'PLAN::name'},
                {'COMPOSITE::coreo_uni_util_variables.aws-planwide.results' => 'unset'},
                {'GLOBAL::number_violations' => '0'}
            ])
end

coreo_uni_util_jsrunner "cloudtrail-tags-rollup" do
  action :nothing
end
coreo_uni_util_notify "advise-cloudtrail-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-cloudtrail-rollup" do
  action :nothing
end


# cloudtrail end
coreo_uni_util_jsrunner "ec2-tags-rollup" do
  action :nothing
end
coreo_uni_util_notify "advise-ec2-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-ec2-rollup" do
  action :nothing
end

# ec2 end
coreo_uni_util_jsrunner "elb-tags-rollup" do
  action :nothing
end
coreo_uni_util_notify "advise-elb-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-elb-rollup" do
  action :nothing
end

# elb end
coreo_uni_util_jsrunner "tags-rollup-iam" do
  action :nothing
end
coreo_uni_util_notify "advise-iam-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-iam-rollup" do
  action :nothing
end

#  iam end

coreo_uni_util_jsrunner "tags-rollup-rds" do
  action :nothing
end
coreo_uni_util_notify "advise-rds-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-rds-rollup" do
  action :nothing
end

# rds end
coreo_uni_util_jsrunner "tags-rollup-redshift" do
  action :nothing
end
coreo_uni_util_notify "advise-redshift-to-tag-values" do
  action :nothing
end
coreo_uni_util_notify "advise-redshift-rollup" do
  action :nothing
end

# redshift end
coreo_uni_util_notify "advise-s3-to-tag-values" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-rollup-s3" do
  action :nothing
end
coreo_uni_util_notify "advise-s3-rollup" do
  action :nothing
end

# s3 end

coreo_uni_util_notify "advise-cloudwatch-to-tag-values" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-rollup-cloudwatch" do
  action :nothing
end
coreo_uni_util_notify "advise-cloudwatch-rollup" do
  action :nothing
end

# cloudwatch end

coreo_uni_util_notify "advise-kms-to-tag-values" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-rollup-kms" do
  action :nothing
end
coreo_uni_util_notify "advise-kms-rollup" do
  action :nothing
end

# kms end

coreo_uni_util_notify "advise-sns-to-tag-values" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-rollup-sns" do
  action :nothing
end
coreo_uni_util_notify "advise-sns-rollup" do
  action :nothing
end

# sns end

coreo_uni_util_jsrunner "splice-violation-object" do
  action :run
  data_type "json"
  json_input '
  {"composite name":"PLAN::stack_name","plan name":"PLAN::name", "services": {
  "cloudtrail": {
   "composite name":"PLAN::stack_name",
   "plan name":"PLAN::name",
   "audit name": "CloudTrail",
    "cloud account name":"PLAN::cloud_account_name",
   "violations": COMPOSITE::coreo_aws_rule_runner.advise-cloudtrail.report },
  "ec2": {
   "audit name": "EC2",
   "violations": COMPOSITE::coreo_aws_rule_runner.advise-ec2.report },
  "iam": {
   "audit name": "IAM",
   "violations": COMPOSITE::coreo_aws_rule_runner.advise-iam.report },
  "elb": {
   "audit name": "ELB",
   "violations": COMPOSITE::coreo_aws_rule_runner.advise-elb.report },
  "rds": {
   "audit name": "RDS",
   "violations": COMPOSITE::coreo_aws_rule_runner.advise-rds.report },
  "redshift": {
   "audit name": "REDSHIFT",
   "violations": COMPOSITE::coreo_aws_rule_runner.advise-redshift.report },
  "s3": {
   "audit name": "S3",
   "violations": COMPOSITE::coreo_aws_rule_runner.advise-s3.report }
  }}'
  function <<-EOH
    const wayToServices = json_input['services'];
    let newViolation = {};
    let violationCounter = 0;
    const auditStackKeys = Object.keys(wayToServices);
    auditStackKeys.forEach(auditStackKey => {
        let wayForViolation = wayToServices[auditStackKey]['violations'];
        const violationKeys = Object.keys(wayForViolation);
        violationKeys.forEach(violationRegion => {
            if(!newViolation.hasOwnProperty(violationRegion)) {
                newViolation[violationRegion] = {};
            }
            const ruleKeys = Object.keys(wayForViolation[violationRegion]);
            violationCounter+= ruleKeys.length;
            ruleKeys.forEach(objectKey => {
                if(!newViolation[violationRegion].hasOwnProperty(objectKey)) {
                    newViolation[violationRegion][objectKey] = {};
                    newViolation[violationRegion][objectKey]['violations'] = {};
                }
                const objectKeys = Object.keys(wayForViolation[violationRegion][objectKey]['violations']);
                objectKeys.forEach(ruleKey => {
                    newViolation[violationRegion][objectKey]['tags'] = wayForViolation[violationRegion][objectKey]['tags'];
                    newViolation[violationRegion][objectKey]['violations'][ruleKey] = wayForViolation[violationRegion][objectKey]['violations'][ruleKey];
                })
            })
        });
    });
    coreoExport('violationCounter', JSON.stringify(violationCounter));
    callback(newViolation);
  EOH
end

coreo_uni_util_variables "aws-update-planwide-1" do
  action :set
  variables([
                {'COMPOSITE::coreo_uni_util_variables.aws-planwide.results' => 'COMPOSITE::coreo_aws_rule_runner.splice-violation-object.report'},
                {'GLOBAL::number_violations' => 'COMPOSITE::coreo_aws_rule_runner.splice-violation-object.violationCounter'},

            ])
end

coreo_uni_util_jsrunner "tags-to-notifiers-array-aws" do
  action :run
  data_type "json"
  provide_composite_access true
  packages([
               {
                   :name => "cloudcoreo-jsrunner-commons",
                   :version => "1.10.7-beta57"
               },
               {
                   :name => "js-yaml",
                   :version => "3.7.0"
               }])
  json_input '{ "compositeName":"PLAN::stack_name",
                "planName":"PLAN::name",
                "cloudAccountName": "PLAN::cloud_account_name",
                "violations": COMPOSITE::coreo_uni_util_jsrunner.splice-violation-object.return}'
  function <<-EOH
const compositeName = json_input.compositeName;
const planName = json_input.planName;
const cloudAccount = json_input.cloudAccountName;
const cloudObjects = json_input.violations;

const NO_OWNER_EMAIL = "${AUDIT_AWS_ALERT_RECIPIENT}";
const OWNER_TAG = "${AUDIT_AWS_OWNER_TAG}";
const ALLOW_EMPTY = "${AUDIT_AWS_ALLOW_EMPTY}";
const SEND_ON = "${AUDIT_AWS_SEND_ON}";
const htmlReportSubject = "${HTML_REPORT_SUBJECT}";

let cloudtrailAlertListToJSON = "${AUDIT_AWS_CLOUDTRAIL_ALERT_LIST}";
let redshiftAlertListToJSON = "${AUDIT_AWS_REDSHIFT_ALERT_LIST}";
let rdsAlertListToJSON = "${AUDIT_AWS_RDS_ALERT_LIST}";
let iamAlertListToJSON = "${AUDIT_AWS_IAM_ALERT_LIST}";
let elbAlertListToJSON = "${AUDIT_AWS_ELB_ALERT_LIST}";
let ec2AlertListToJSON = "${AUDIT_AWS_EC2_ALERT_LIST}";
let s3AlertListToJSON = "${AUDIT_AWS_S3_ALERT_LIST}";
let cloudwatchAlertListToJSON = "${AUDIT_AWS_CLOUDWATCH_ALERT_LIST}";
let kmsAlertListToJSON = "${AUDIT_AWS_KMS_ALERT_LIST}";
let snsAlertListToJSON = "${AUDIT_AWS_SNS_ALERT_LIST}";
const alertListMap = new Set();
alertListMap.add(cloudtrailAlertListToJSON.replace(/'/g, '"'));
alertListMap.add(redshiftAlertListToJSON.replace(/'/g, '"'));
alertListMap.add(rdsAlertListToJSON.replace(/'/g, '"'));
alertListMap.add(iamAlertListToJSON.replace(/'/g, '"'));
alertListMap.add(elbAlertListToJSON.replace(/'/g, '"'));
alertListMap.add(ec2AlertListToJSON.replace(/'/g, '"'));
alertListMap.add(s3AlertListToJSON.replace(/'/g, '"'));
alertListMap.add(cloudwatchAlertListToJSON.replace(/'/g, '"'));
alertListMap.add(kmsAlertListToJSON.replace(/'/g, '"'));
alertListMap.add(snsAlertListToJSON.replace(/'/g, '"'));
let auditAwsAlertList = [];
alertListMap.forEach(alertList => {
    auditAwsAlertList = auditAwsAlertList.concat(alertList);
});
const alertListArray = auditAwsAlertList;
const ruleInputs = {};
let userSuppression;
let userSchemes;
const fs = require('fs');
const yaml = require('js-yaml');
function setSuppression() {
  try {
    userSuppression = yaml.safeLoad(fs.readFileSync('./suppression.yaml', 'utf8'));
  } catch (e) {
    console.log(`Error reading suppression.yaml file`);
    userSuppression = [];
  }
  coreoExport('suppression', JSON.stringify(userSuppression));
}
function setTable() {
  try {
    userSchemes = yaml.safeLoad(fs.readFileSync('./table.yaml', 'utf8'));
  } catch (e) {
    console.log(`Error reading table.yaml file`);
    userSchemes = {};
  }
  coreoExport('table', JSON.stringify(userSchemes));
}
setSuppression();
setTable();
const argForConfig = {
    NO_OWNER_EMAIL, cloudObjects, userSuppression, OWNER_TAG,
    userSchemes, alertListArray, ruleInputs, ALLOW_EMPTY,
    SEND_ON, cloudAccount, compositeName, planName, htmlReportSubject
}
function createConfig(argForConfig) {
    let JSON_INPUT = {
        compositeName: argForConfig.compositeName,
        htmlReportSubject: argForConfig.htmlReportSubject,
        planName: argForConfig.planName,
        violations: argForConfig.cloudObjects,
        userSchemes: argForConfig.userSchemes,
        userSuppression: argForConfig.userSuppression,
        alertList: argForConfig.alertListArray,
        disabled: argForConfig.ruleInputs,
        cloudAccount: argForConfig.cloudAccount
    };
    let SETTINGS = {
        NO_OWNER_EMAIL: argForConfig.NO_OWNER_EMAIL,
        OWNER_TAG: argForConfig.OWNER_TAG,
        ALLOW_EMPTY: argForConfig.ALLOW_EMPTY, SEND_ON: argForConfig.SEND_ON,
        SHOWN_NOT_SORTED_VIOLATIONS_COUNTER: false
    };
    return {JSON_INPUT, SETTINGS};
}
const {JSON_INPUT, SETTINGS} = createConfig(argForConfig);
const CloudCoreoJSRunner = require('cloudcoreo-jsrunner-commons');
const emails = CloudCoreoJSRunner.createEmails(JSON_INPUT, SETTINGS);
const suppressionJSON = CloudCoreoJSRunner.createJSONWithSuppress(JSON_INPUT, SETTINGS);
coreoExport('JSONReport', JSON.stringify(suppressionJSON));
coreoExport('report', JSON.stringify(suppressionJSON['violations']));
callback(emails);
  EOH
end


coreo_uni_util_variables "aws-update-planwide-2" do
  action :set
  variables([
                {'COMPOSITE::coreo_uni_util_variables.aws-planwide.results' => 'COMPOSITE::coreo_uni_util_jsrunner.tags-to-notifiers-array-aws.JSONReport'},
                {'GLOBAL::table' => 'COMPOSITE::coreo_uni_util_jsrunner.tags-to-notifiers-array-aws.table'}
            ])
end

coreo_uni_util_jsrunner "tags-rollup-aws" do
  action :run
  data_type "text"
  json_input 'COMPOSITE::coreo_uni_util_jsrunner.tags-to-notifiers-array-aws.return'
  function <<-EOH
const notifiers = json_input;
function setTextRollup() {
    let emailText = '';
    let allReport = '';
    let numberOfViolations = 0;
    notifiers.forEach(notifier => {
        const hasEmail = notifier['endpoint']['to'].length;
        if(hasEmail) {
            numberOfViolations += parseInt(notifier['num_violations']);
            emailText += "recipient: " + notifier['endpoint']['to'] + " - " + "Violations: " + notifier['num_violations'] + "\\n";
            allReport += notifier['payload'];  
        }
    });

    textRollup += 'Total Number of Violating Cloud Objects: ' + numberOfViolations + "\\n";
    textRollup += 'Rollup' + "\\n";
    textRollup += emailText;
    
    textRollup += allReport;

}
let textRollup = '';
setTextRollup();
callback(textRollup);
  EOH
end

coreo_uni_util_notify "advise-aws-to-tag-values" do
  action((("${AUDIT_AWS_ALERT_RECIPIENT}".length > 0)) ? :notify : :nothing)
  notifiers 'COMPOSITE::coreo_uni_util_jsrunner.tags-to-notifiers-array-aws.return'
end

coreo_uni_util_notify "advise-aws-rollup" do
  action((("${AUDIT_AWS_ALERT_RECIPIENT}".length > 0) and (! "${AUDIT_AWS_OWNER_TAG}".eql?("NOT_A_TAG"))) ? :notify : :nothing)
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
      :to => '${AUDIT_AWS_ALERT_RECIPIENT}', :subject => 'CloudCoreo aws rule results on PLAN::stack_name :: PLAN::name'
  })
end
