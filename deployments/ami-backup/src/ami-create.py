# Automated AMI Backups
# Compatible with Python 3.8
# This code refered with slight changes: https://gist.github.com/bkozora/724e01903a9ad481d21e
#
# This script will search for all instances having a tag with "Backup"
# on it and are in 'running' state. As soon as it has the instances list, it loop through each instance
# and create an AMI of it. Also, it will look for a "Retention" tag key which
# will be used as a retention policy number in days. If there is no tag with
# that name, it will use a 4 days default value for each AMI.If there is no tag with that name, it will use a 7 days default value for each AMI.
#
# After creating the AMI it creates a "DeleteOn" tag on the AMI indicating when
# it will be deleted using the Retention value and another Lambda function
# You can set a custom Tag 'Retention' in the EC2 instance to specify the amount of days to keep the AMI backups (retention period)
# If you don't set a custom Tag 'Retention' in the EC2 instance, the default value is set in the Environment Variable 'RETENTION_DAYS'

import boto3
import collections
import datetime
import os
import json

#set as AWS region the one in which this lambda is created.
region = os.environ['AWS_REGION']
ret_days = os.environ['RETENTION_DAYS']
ec = boto3.client('ec2', region)

def lambda_handler(event, context):

    reservations = ec.describe_instances(Filters=[{'Name': 'tag-key', 'Values': ['Backup']}]).get('Reservations', [])
    instances = sum(
        [
            [i for i in r['Instances']]
            for r in reservations
        ], [])

    print("Found %d instances that need backing up" % len(instances))


    to_tag = collections.defaultdict(list)

    for instance in instances:
        print("Instance name:" + [res['Value'] for res in instance['Tags'] if res['Key'] == 'Name'][0])

        #Default retention for 14 days if the tag is not specified
        try:
            retention_days = [
                int(t.get('Value')) for t in instance['Tags']
                if t['Key'] == 'Retention'][0]
        except (IndexError, ValueError, Exception) as e:
            retention_days = int(ret_days)

        finally:
            create_time = datetime.datetime.now()
            create_fmt = create_time.strftime('%d-%m-%Y')
            #create_fmt = create_time.strftime('%d-%m-%Y.%H.%M.%S')
            try:
                AMIid = ec.create_image(
                    InstanceId=instance['InstanceId'],
                    Name="Lambda - " + [result['Value'] for result in instance['Tags'] if result['Key'] == 'Name'][0] + " - " + " From " + create_fmt,
                    Description="Lambda created AMI of instance " + instance['InstanceId'],
                    NoReboot=True,
                    DryRun=False)

                to_tag[retention_days].append(AMIid['ImageId'])

                print("Retaining AMI %s of instance %s for %d days" % (
                        AMIid['ImageId'],
                        instance['InstanceId'],
                        retention_days,
                    ))

                for retention_days in to_tag.keys():
                    delete_date = datetime.date.today() + datetime.timedelta(days=retention_days)
                    delete_fmt = delete_date.strftime('%d-%m-%Y')
                    print("Will delete %d AMIs on %s" % (len(to_tag[retention_days]), delete_fmt))

                    #To create a tag to an AMI when it can be deleted after retention period expires
                    ec.create_tags(
                        Resources=to_tag[retention_days],
                        Tags=[
                            {'Key': 'DeleteOn', 'Value': delete_fmt},
                            ]
                        )

            except Exception as e:
                raise Exception('Error ->> %s' % e.args[0])

    return {
        "statusCode": 200,
        "body": json.dumps('AMI Snapshots successful')
    }
