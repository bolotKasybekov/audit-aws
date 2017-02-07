coreo_uni_util_jsrunner "jsrunner-process-suppression-cloudtrail" do
  action :nothing
end
coreo_uni_util_variables "cloudtrail-suppression-update-advisor-output" do
  action :nothing
end
coreo_uni_util_jsrunner "jsrunner-process-table-cloudtrail" do
  action :nothing
end
coreo_uni_util_jsrunner "cloudtrail-tags-to-notifiers-array" do
  action :nothing
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

# cloudtrail and

coreo_uni_util_jsrunner "jsrunner-process-suppression-ec2" do
  action :nothing
end
coreo_uni_util_variables "ec2-for-suppression-update-advisor-output" do
  action :nothing
end
coreo_uni_util_jsrunner "jsrunner-process-table-ec2" do
  action :nothing
end
coreo_uni_util_jsrunner "ec2-tags-to-notifiers-array" do
  action :nothing
end
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

coreo_uni_util_jsrunner "jsrunner-process-suppression-elb" do
  action :nothing
end
coreo_uni_util_variables "elb-for-suppression-update-advisor-output" do
  action :nothing
end
coreo_uni_util_jsrunner "jsrunner-process-table-elb" do
  action :nothing
end
coreo_uni_util_jsrunner "elb-tags-to-notifiers-array" do
  action :nothing
end
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

coreo_uni_util_jsrunner "jsrunner-process-suppression-iam" do
  action :nothing
end
coreo_uni_util_variables "iam-for-suppression-update-advisor-output" do
  action :nothing
end
coreo_uni_util_jsrunner "jsrunner-process-table-iam" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-to-notifiers-array-iam" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-rollup-iam" do
  action :nothing
end
coreo_uni_util_notify "advise-iam-html-report" do
  action :nothing
end
coreo_uni_util_notify "advise-iam-rollup" do
  action :nothing
end

#  iam end

coreo_uni_util_jsrunner "jsrunner-process-suppression-rds" do
  action :nothing
end
coreo_uni_util_variables "rds-for-suppression-update-advisor-output" do
  action :nothing
end
coreo_uni_util_jsrunner "jsrunner-process-table-rds" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-to-notifiers-array-rds" do
  action :nothing
end
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

coreo_uni_util_jsrunner "jsrunner-process-suppression-redshift" do
  action :nothing
end
coreo_uni_util_variables "redshift-for-suppression-update-advisor-output" do
  action :nothing
end
coreo_uni_util_jsrunner "jsrunner-process-table-redshift" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-to-notifiers-array-redshift" do
  action :nothing
end
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

coreo_uni_util_jsrunner "jsrunner-process-suppression-s3" do
  action :nothing
end
coreo_uni_util_variables "s3-for-suppression-update-advisor-output" do
  action :nothing
end
coreo_uni_util_jsrunner "jsrunner-process-table-s3" do
  action :nothing
end
coreo_uni_util_jsrunner "tags-to-notifiers-array-s3" do
  action :nothing
end
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

coreo_uni_util_jsrunner "splice-violation-object" do
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
   "violations": COMPOSITE::coreo_aws_rule_runner_cloudtrail.advise-cloudtrail.report },
  "ec2": {
   "audit name": "EC2",
   "violations": COMPOSITE::coreo_aws_rule_runner_ec2.advise-ec2.report },
  "iam": {
   "audit name": "IAM",
   "violations": COMPOSITE::coreo_aws_rule_runner_iam.advise-iam.report },
  "elb": {
   "audit name": "ELB",
   "violations": COMPOSITE::coreo_aws_rule_runner_elb.advise-elb.report },
  "rds": {
   "audit name": "RDS",
   "violations": COMPOSITE::coreo_aws_rule_runner_rds.advise-rds.report },
  "redshift": {
   "audit name": "REDSHIFT",
   "violations": COMPOSITE::coreo_aws_rule_runner_redshift.advise-redshift.report },
  "s3": {
   "audit name": "S3",
   "violations": COMPOSITE::coreo_aws_rule_runner_s3.advise-s3.report }
  }}'
  function <<-EOH
  const wayToServices = json_input['services'];
  let newViolation = {};
  const auditStackKeys = Object.keys(wayToServices);
  auditStackKeys.forEach(auditStackKey => {
      let wayForViolation = wayToServices[auditStackKey]['violations'];
      const violationKeys = Object.keys(wayForViolation);
      violationKeys.forEach(violationRegion => {
          if(!newViolation.hasOwnProperty(violationRegion)) {
              newViolation[violationRegion] = {};
          }
          const ruleKeys = Object.keys(wayForViolation[violationRegion]);
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
  callback(newViolation);
  EOH
end

coreo_uni_util_jsrunner "jsrunner-process-suppression-aws" do
  action :run
  provide_composite_access true
  json_input '{"violations":COMPOSITE::coreo_uni_util_jsrunner.splice-violation-object.return}'
  packages([
               {
                   :name => "js-yaml",
                   :version => "3.7.0"
               }       ])
  function <<-EOH
  const fs = require('fs');
  const yaml = require('js-yaml');
  let suppression;
  try {
      suppression = yaml.safeLoad(fs.readFileSync('./suppression.yaml', 'utf8'));
  } catch (e) {
  }
  coreoExport('suppression', JSON.stringify(suppression));
  function createViolationWithSuppression(result) {
      const regionKeys = Object.keys(violations);
      regionKeys.forEach(regionKey => {
          result[regionKey] = {};
          const objectIdKeys = Object.keys(violations[regionKey]);
          objectIdKeys.forEach(objectIdKey => {
              createObjectId(regionKey, objectIdKey);
          });
      });
  }
  
  function createObjectId(regionKey, objectIdKey) {
      const wayToResultObjectId = result[regionKey][objectIdKey] = {};
      const wayToViolationObjectId = violations[regionKey][objectIdKey];
      wayToResultObjectId.tags = wayToViolationObjectId.tags;
      wayToResultObjectId.violations = {};
      createSuppression(wayToViolationObjectId, regionKey, objectIdKey);
  }
  
  
  function createSuppression(wayToViolationObjectId, regionKey, violationObjectIdKey) {
      const ruleKeys = Object.keys(wayToViolationObjectId['violations']);
      ruleKeys.forEach(violationRuleKey => {
          result[regionKey][violationObjectIdKey].violations[violationRuleKey] = wayToViolationObjectId['violations'][violationRuleKey];
          Object.keys(suppression).forEach(suppressRuleKey => {
              suppression[suppressRuleKey].forEach(suppressionObject => {
                  Object.keys(suppressionObject).forEach(suppressObjectIdKey => {
                      setDateForSuppression(
                          suppressionObject, suppressObjectIdKey,
                          violationRuleKey, suppressRuleKey,
                          violationObjectIdKey, regionKey
                      );
                  });
              });
          });
      });
  }
  
  
  function setDateForSuppression(
      suppressionObject, suppressObjectIdKey,
      violationRuleKey, suppressRuleKey,
      violationObjectIdKey, regionKey
  ) {
      file_date = null;
      let suppressDate = suppressionObject[suppressObjectIdKey];
      const areViolationsEqual = violationRuleKey === suppressRuleKey && violationObjectIdKey === suppressObjectIdKey;
      if (areViolationsEqual) {
          const nowDate = new Date();
          const correctDateSuppress = getCorrectSuppressDate(suppressDate);
          const isSuppressionDate = nowDate <= correctDateSuppress;
          if (isSuppressionDate) {
              setSuppressionProp(regionKey, violationObjectIdKey, violationRuleKey, file_date);
          } else {
              setSuppressionExpired(regionKey, violationObjectIdKey, violationRuleKey, file_date);
          }
      }
  }
  
  
  function getCorrectSuppressDate(suppressDate) {
      const hasSuppressionDate = suppressDate !== '';
      if (hasSuppressionDate) {
          file_date = suppressDate;
      } else {
          suppressDate = new Date();
      }
      let correctDateSuppress = new Date(suppressDate);
      if (isNaN(correctDateSuppress.getTime())) {
          correctDateSuppress = new Date(0);
      }
      return correctDateSuppress;
  }
  
  
  function setSuppressionProp(regionKey, objectIdKey, violationRuleKey, file_date) {
      const wayToViolationObject = result[regionKey][objectIdKey].violations[violationRuleKey];
      wayToViolationObject["suppressed"] = true;
      if (file_date != null) {
          wayToViolationObject["suppression_until"] = file_date;
          wayToViolationObject["suppression_expired"] = false;
      }
  }
  
  function setSuppressionExpired(regionKey, objectIdKey, violationRuleKey, file_date) {
      if (file_date !== null) {
          result[regionKey][objectIdKey].violations[violationRuleKey]["suppression_until"] = file_date;
          result[regionKey][objectIdKey].violations[violationRuleKey]["suppression_expired"] = true;
      } else {
          result[regionKey][objectIdKey].violations[violationRuleKey]["suppression_expired"] = false;
      }
      result[regionKey][objectIdKey].violations[violationRuleKey]["suppressed"] = false;
  }
  
  const violations = json_input['violations'];
  const result = {};
  createViolationWithSuppression(result, json_input);
  
  callback(result);
  EOH
end

coreo_uni_util_variables "aws-for-suppression-update-advisor-output" do
  action :set
  variables([
                {'COMPOSITE::coreo_uni_util_jsrunner.splice-violation-object.return' => 'COMPOSITE::coreo_uni_util_jsrunner.jsrunner-process-suppression-aws.return'}
            ])
end

coreo_uni_util_jsrunner "jsrunner-process-table-aws" do
  action :run
  provide_composite_access true
  json_input '{"violations":COMPOSITE::coreo_uni_util_jsrunner.jsrunner-process-suppression-aws.return}'
  packages([
               {
                   :name => "js-yaml",
                   :version => "3.7.0"
               }       ])
  function <<-EOH
    var fs = require('fs');
    var yaml = require('js-yaml');
    var table;
    try {
        table = yaml.safeLoad(fs.readFileSync('./table.yaml', 'utf8'));
    } catch (e) {
    }
    coreoExport('table', JSON.stringify(table));
    callback(table);
  EOH
end

coreo_uni_util_jsrunner "jsrunner-process-alert-list-aws" do
  action :run
  provide_composite_access true
  json_input '{"composite name":"PLAN::stack_name"}'
  packages([
               {
                   :name => "js-yaml",
                   :version => "3.7.0"
               }       ])
  function <<-EOH
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
    
    alertListMap.add(JSON.parse(cloudtrailAlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(redshiftAlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(rdsAlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(iamAlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(elbAlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(ec2AlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(s3AlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(cloudwatchAlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(kmsAlertListToJSON.replace(/'/g, '"')));
    alertListMap.add(JSON.parse(snsAlertListToJSON.replace(/'/g, '"')));
    
    
    let auditAwsAlertList = [];
    
    alertListMap.forEach(alertList => {
        console.log(alertList);
        auditAwsAlertList = auditAwsAlertList.concat(alertList);
    });
    
    auditAwsAlertList = JSON.stringify(auditAwsAlertList);
    callback(auditAwsAlertList);
  EOH
end

coreo_uni_util_jsrunner "tags-to-notifiers-array-aws" do
  action :run
  data_type "json"
  packages([
               {
                   :name => "cloudcoreo-jsrunner-commons",
                   :version => "1.7.8"
               }       ])
  json_input '{ "composite name":"PLAN::stack_name",
      "plan name":"PLAN::name",
                "alert list": COMPOSITE::coreo_uni_util_jsrunner.jsrunner-process-alert-list-aws.return,
      "table": COMPOSITE::coreo_uni_util_jsrunner.jsrunner-process-table-aws.return,
      "violations": COMPOSITE::coreo_uni_util_jsrunner.jsrunner-process-suppression-aws.return}'
  function <<-EOH
  
const JSON_INPUT = json_input;
const NO_OWNER_EMAIL = "${AUDIT_AWS_ALERT_RECIPIENT}";
const OWNER_TAG = "${AUDIT_AWS_OWNER_TAG}";
const ALLOW_EMPTY = "${AUDIT_AWS_ALLOW_EMPTY}";
const SEND_ON = "${AUDIT_AWS_SEND_ON}";
const SHOWN_NOT_SORTED_VIOLATIONS_COUNTER = false;
const VARIABLES = { NO_OWNER_EMAIL, OWNER_TAG,
     ALLOW_EMPTY, SEND_ON, SHOWN_NOT_SORTED_VIOLATIONS_COUNTER};
const CloudCoreoJSRunner = require('cloudcoreo-jsrunner-commons');
const AuditELB = new CloudCoreoJSRunner(JSON_INPUT, VARIABLES);
const notifiers = AuditELB.getNotifiers();
callback(notifiers);
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
        emailText += "recipient: " + json_input[entry]['endpoint']['to'] + " - " + "Violations: " + json_input[entry]['num_violations'] + "\\n";
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
      :to => '${AUDIT_AWS_ALERT_RECIPIENT}', :subject => 'CloudCoreo aws rule results on PLAN::stack_name :: PLAN::name'
  })
end
