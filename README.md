# Github Action - SSH Execute Commands

GitHub Action (yml) to execute commands on one or more remote servers using a private key to authenticate.

## Example usage

Example - one command to one host 
```yml
uses: JimCronqvist/action-ssh@master
with:
  command: 'pwd'
  hosts: 'user@domain.com'
  privateKey: ${{ secrets.PRIVATE_KEY }}
```

## Inputs

**command**: Command(s) to execute on the remote server.

**hosts**: Hostname or IP address of the remote server(s). Separate multiple servers with a blank space. Example: user@mydomain.com:22

**privateKey**: The private key (id_rsa) content for authenticating to the SSH server(s). Recommended to store it as a GitHub Secret.

## Outputs

The output from the commands ran on the remote server(s).