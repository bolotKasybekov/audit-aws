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
  const wayToServices = json_input['services'];
  const auditStackKeys = Object.keys(wayToServices);
  let newViolation = {};
  auditStackKeys.forEach(auditStackKey => {
      let wayForViolation = wayToServices[auditStackKey]['violations'];
      if(wayForViolation.hasOwnProperty('violations')) {
          wayForViolation = wayForViolation['violations'];
      }
      const violationKeys = Object.keys(wayForViolation);
      violationKeys.forEach(violation => {
          if(!newViolation.hasOwnProperty(violation)) {
              newViolation[violation] = wayForViolation[violation];
          }
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
  var fs = require('fs');
  var yaml = require('js-yaml');
  let suppression;
  try {
      suppression = yaml.safeLoad(fs.readFileSync('./suppression.yaml', 'utf8'));
  } catch (e) {
  }
  coreoExport('suppression', JSON.stringify(suppression));
  var violations = json_input.violations;
  var result = {};
    var file_date = null;
    for (var violator_id in violations) {
        result[violator_id] = {};
        result[violator_id].tags = violations[violator_id].tags;
        result[violator_id].violations = {}
        for (var rule_id in violations[violator_id].violations) {
            is_violation = true;
 
            result[violator_id].violations[rule_id] = violations[violator_id].violations[rule_id];
            for (var suppress_rule_id in suppression) {
                for (var suppress_violator_num in suppression[suppress_rule_id]) {
                    for (var suppress_violator_id in suppression[suppress_rule_id][suppress_violator_num]) {
                        file_date = null;
                        var suppress_obj_id_time = suppression[suppress_rule_id][suppress_violator_num][suppress_violator_id];
                        if (rule_id === suppress_rule_id) {
 
                            if (violator_id === suppress_violator_id) {
                                var now_date = new Date();
 
                                if (suppress_obj_id_time === "") {
                                    suppress_obj_id_time = new Date();
                                } else {
                                    file_date = suppress_obj_id_time;
                                    suppress_obj_id_time = file_date;
                                }
                                var rule_date = new Date(suppress_obj_id_time);
                                if (isNaN(rule_date.getTime())) {
                                    rule_date = new Date(0);
                                }
 
                                if (now_date <= rule_date) {
 
                                    is_violation = false;
 
                                    result[violator_id].violations[rule_id]["suppressed"] = true;
                                    if (file_date != null) {
                                        result[violator_id].violations[rule_id]["suppressed_until"] = file_date;
                                        result[violator_id].violations[rule_id]["suppression_expired"] = false;
                                    }
                                }
                            }
                        }
                    }
 
                }
            }
            if (is_violation) {
 
                if (file_date !== null) {
                    result[violator_id].violations[rule_id]["suppressed_until"] = file_date;
                    result[violator_id].violations[rule_id]["suppression_expired"] = true;
                } else {
                    result[violator_id].violations[rule_id]["suppression_expired"] = false;
                }
                result[violator_id].violations[rule_id]["suppressed"] = false;
            }
        }
    }
 
    var rtn = result;
  
  var rtn = result;
  
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
    try {
        var table = yaml.safeLoad(fs.readFileSync('./table.yaml', 'utf8'));
    } catch (e) {
    }
    coreoExport('table', JSON.stringify(table));
    callback(table);
  EOH
end

coreo_uni_util_jsrunner "tags-to-notifiers-array-aws" do
  action :run
  data_type "json"
  packages([
               {
                   :name => "cloudcoreo-jsrunner-commons",
                   :version => "1.6.9"
               }       ])
  json_input '{ "composite name":"PLAN::stack_name",
      "plan name":"PLAN::name",
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
