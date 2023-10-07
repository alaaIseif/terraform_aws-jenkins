import boto3
import hashlib
import json

def send_email_notification(subject, body):
    # Create the SES client
    ses_client = boto3.client('ses')
    

    # Send the email 
    response = ses_client.send_email(
        Source= "${var.sender_email}",
        Destination={
            'ToAddresses': ["${var.receiver_email}"]
        },
        Message={
            'Subject': {'Data': subject},
            'Body': {'Text': {'Data': body}}
        }
    )

    print('Email sent successfully.')

def main():
    # Read the state file
    with open('.terraform/terraform.tfstate', 'r') as f:
        state = json.load(f)

    # Calculate the hash of the state file
    state_hash = hashlib.md5(json.dumps(state, sort_keys=True).encode()).hexdigest()

    # Check if the state file has changed
    previous_hash = 'previous_state_hash.txt'
    try:
        with open(previous_hash, 'r') as f:
            previous_state_hash = f.read()
            if previous_state_hash == state_hash:
                print('No changes in the state file.')
                return
    except FileNotFoundError:
        pass

    # Save the new state hash
    with open(previous_hash, 'w') as f:
        f.write(state_hash)

    # Send the SES email notification
    subject = 'Terraform State Change Detected'
    body = 'The Terraform state file has changed.'
    send_email_notification(subject, body)

if __name__ == '__main__':
    main()