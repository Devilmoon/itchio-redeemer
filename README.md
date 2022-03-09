# itchio-redeemer
A script to automatically redeem all items in an itchio bundle and add them to your account's library.
Unfortunately itch.io does not provide the ability to redeem all bundle items at once; having recently bought the [bundle for Ukraine](https://itch.io/b/1316/bundle-for-ukraine) which contains more than 1000 items I have decided to automate this task. I think this might be handy for others as well!

## Prerequisites
You will need Python installed on your system.

You will also need to install [Robot Framework](https://robotframework.org/)
Assuming you already have Python and pip installed, you can just
```
$ pip install robotframework
```
For more information, see [their documentation](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst)

You will need to install [SeleniumLibrary for Robot Framework](https://github.com/robotframework/SeleniumLibrary)
Assuming you already have Python and pip installed, you can just
```
$ pip install robotframework-seleniumlibrary
```
For more information, see [their documentation](https://github.com/robotframework/SeleniumLibrary#installation)

For the script to work, you will need one of the browsers supported by Selenium to be installed (see [here](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser)), as well as the respective Selenium browser driver (chromedriver, geckodriver, etc.) in your PATH (see [here](https://github.com/robotframework/SeleniumLibrary#browser-drivers)).

## Usage
You will first need to clone this repo, and then move into its folder
```
$ git clone https://github.com/Devilmoon/itchio-redeemer
$ cd itchio-redeemer
```

Before launching the script, you will need to edit the `*** Variables ***` section in the `itchio-redeem.robot` file; an example is:
```
${PAGE} =   https://itch.io/bundle/download/Some-Random-String
${BROWSER} =  firefox
${AUTH} =  itchio
${USERNAME} =  MyItchioUsername
${PASSWORD} =  SecurePassword
```

After saving the changes to the file, you can launch the script by doing
```
$ robot itchio-redeem.robot
```
(this will create output log files in the root of the folder; to avoid that, you can use the `-d` option and point it to a subfolder. For more information, see `robot --help` or [here](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)

Assuming you are not using a headless browser, you should see a browser window appear shortly after; the script will then work through all the pages of the bundle redeem link and redeem each item that is yet to be redeemed. You can verify that everything is working correctly by opening your itchio library in another browser and verifying that new items are being added.

## Troubleshooting
If the script ends with a failure, there might have been either an issue on itchio's end or an attempt at throttling the user. For now what you can do is launch the script again until it ends with a PASS, like so:
![Capture](https://user-images.githubusercontent.com/18517304/157514787-d712f485-ed76-47a1-83f3-5befc11420d0.PNG)
