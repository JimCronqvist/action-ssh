# Github Action - SSH Execute Commands

GitHub Action (yml) to execute SSH commands on remote server(s).

**Supports:** 
- Multiple hosts
- Environment variables
- Multiple commands
- Private key authentication

*Password authentication is generally seen as unsafe and is therefore not supported.*

## Example usage

**Basic Example** 
```yml
- name: Execute SSH commmands on remote server
  uses: JimCronqvist/action-ssh@master
  with:
    hosts: 'user@domain.com'
    privateKey: ${{ secrets.PRIVATE_KEY }}
    command: ls -lah
```

**Advanced Example - envs, multiple hosts, multiple commands**
```yml
- name: Execute SSH commmands on remote server
  uses: JimCronqvist/action-ssh@master
  env:
    NAME: "Root"
  with:
    hosts: 'user@domain.com user@domain2.com:2222'
    privateKey: ${{ secrets.PRIVATE_KEY }}
    debug: false
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

**`debug`**: Used to view all environment variables in the logs, please note that this could expose sensitive data. Default as `false`

## Outputs

The output from the commands ran on the remote server(s).

## External links

To set up ssh keys, please see the following guide:
*https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-1804*
