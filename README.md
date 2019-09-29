# Github Action - SSH Execute Commands

GitHub Action (yml) to execute commands on one or more remote servers using a private key to authenticate.

## Example usage

**Basic Example** 
```yml
uses: JimCronqvist/action-ssh@master
with:
  hosts: 'user@domain.com'
  privateKey: ${{ secrets.PRIVATE_KEY }}
  command: ls -lah
```

**Advanced Example - envs, multiple hosts, multiple commands**
```yml
uses: JimCronqvist/action-ssh@master
env:
  NAME: "Root"
with:
  hosts: 'user@domain.com user@domain2.com:2222'
  privateKey: ${{ secrets.PRIVATE_KEY }}
  envs: NAME
  command: |
    ls -lah
    echo "I am $NAME"
```

*Create your secrets here: `https://github.com/USERNAME/REPO/settings/secrets`*

## Inputs

**`command`**:
Command(s) to execute on the remote server.

**`hosts`**: 
Hostname or IP address of the remote server(s). Separate multiple servers with a blank space.
Example: "user@mydomain.com:22 user@otherdomain.com:2222"

**`privateKey`**: The private key (id_rsa) content for authenticating to the SSH server(s). 
Recommended to store it as a GitHub Secret.

**`envs`**: Pass environment variables to the commands.

## Outputs

The output from the commands ran on the remote server(s).