# Salesforce - Unit Testing

## Preconditions

1. Install GIT https://git-scm.com/downloads
2. Install SFDX CLI https://developer.salesforce.com/tools/sfdxcli

## Steps

First of all clone project from GitHub:

    git clone https://github.com/alexhooke/sfedu-unit-testing.git <project-folder-name>

Authorize to your Developer Hub (Dev Hub) org. You can create your own dev hub org [here](https://developer.salesforce.com/promotions/orgs/dx-signup)
    
    sfdx force:auth:web:login -d -a "Hub Org"
    
If you already have an authorized Dev Hub, set it as the default:
    
    sfdx force:config:set defaultdevhubusername=<username|alias>
    
Create a scratch org.

    sfdx force:org:create -s -f config/project-scratch-def.json
    
Push your source.

    sfdx force:source:push
    
Open the scratch org.

    sfdx force:org:open --path one/one.app
