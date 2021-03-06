
# How to run CI-droid on your machine

This repository contains a script and the config files necessary to run [CI-droid](https://github.com/societe-generale/ci-droid) easily on your machine and give it a try.

### Disclaimer

If you want to deploy it further than on your machine, so that your team can benefit from it, review all the deployment and security aspects : whatever is provided here is probably not adapted !

### Pre-requisite

You only need to have Docker and Docker-compose installed and working on your machine.

### What the script does

The main script is [ci-droid-run.sh](./ci-droid-run.sh). It does simple things in sequence :
1. download [CI-droid](https://github.com/societe-generale/ci-droid)  starter jar (the REST API part of it), and puts it with the proper config file, on top of a Java Docker image
2. download [CI-droid-tasks-consumer](https://github.com/societe-generale/ci-droid-tasks-consumer/)  starter jar, and puts it with the proper config file, on top of a Java Docker image
3. Using docker-compose, it starts :
    - a RabbitMq instance, with a very basic config, just enough to demonstrate how it works
    - a CI-droid-rest instance, reachable on http://localhost:8080
    - 2 CI-droid-tasks-consumer instances

### What to tweak

##### Mandatory

-  CI-droid-tasks-consumer needs to be provided with some [github credentials](https://github.com/societe-generale/ci-droid-run/blob/38eab772b4da223c136d1c10e1fea4496b2b8722/ci-droid-tasks-consumer-config.yml#L52-L53) to perform some actions : to test, you can provide yours (but typically, you would put a service account with proper rights)
-  The GitHubEnterprise URL on which CI-droid will perform tasks.
    - Make sure you provide the API URL, ie it should end with /api/v3
    - An [issue](https://github.com/societe-generale/ci-droid-tasks-consumer/issues/8) is open to make it compatible with github.com


##### Optional

- the [versions to use](https://github.com/societe-generale/ci-droid-run/blob/38eab772b4da223c136d1c10e1fea4496b2b8722/ci-droid-run.sh#L3-L4) for both jars. We'll try to update the scripts regularly with latest versions, but in case we forget, check yourself that you're using the latest versions.

- Anything you want to try in the 2 config files :
    - [ci-droid-rest-config.yml](./ci-droid-rest-config.yml)
    - [ci-droid-tasks-consumer-config.yml](./ci-droid-tasks-consumer-config.yml)

- If you want to test features that involve emails, you'll obviously need to define your [email server](https://github.com/societe-generale/ci-droid-run/blob/564f6105eed4cb8dc63c99fc7042f3f76774a8db/ci-droid-tasks-consumer-config.yml#L12)

#### Testing CI-droid

Once you've tweaked what was needed and launched ci-droid-run.sh, CI-droid should now be running on your machine.. You can check that you can connect to RabbitMq management GUI on http://localhost:15672 (connect with guest/guest), and you should see exchanges and queues created with 2 consumers on queues)

You should be able to send POST requests to http://localhost:8080/cidroid-webhook/ (with messages emitted by github as payload) or http://localhost:8080/cidroid-actions (with your own payload, according to [the documentation](https://github.com/societe-generale/ci-droid#ad-hoc-bulk-actions))


