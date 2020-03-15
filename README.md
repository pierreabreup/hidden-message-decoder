# Message decoder

## What is it?
Read data from Json or CSV contents available in URLs defined on configuration files.  This project is build on Docker adn Ruby

# What is the project for?

The project was made to help computer programmers who are applying for positions in companies, during the interview process. However, I strongly recommend that you DO NOT COPY THIS WHOLE PROJECT, but try to use it as reference for your solution. I suggest it to you because it is important to show to your recruiter how you solve problems in a smart way without doing "copy and paste".


## How to run?

### Production
After you've cloned this project in your machine, follow the steps:
- open a terminal session in your terminal tool (Iterm, Terminal, Putty)
- go to folder where you've clone the project (Ex.: ```cd hidden-message-decoder```)
- type the command: ```make run```

This command will run the container a and the application. If all goes well, you will see the message:
```
=> Decoding data from sources 'sentinels, sniffers, loopholes' and sending them to [ https://challenge.distribusion.com/the_one/routes ], it will takes a while.

----> All data has been sent. The send log:

```

### Development
After you've cloned this project in your machine, follow the steps:
- open a terminal session in your terminal tool (Iterm, Terminal, Putty)
- go to folder where you've clone the project (Ex.: ```cd hidden-message-decoder```)
- type the command: ```make dev```

This command will run the container. If all goes well, you will be inside container session (`/usr/src/app #`). Inside the container session, you can run commands such as `ruby start.rb`, `bundle`, `rspec`


## Automated testing

To run the tests, to go the terminal session where you've run `make dev` and type `rspec` (Ex.: `/usr/src/app # rspec`) __OR__ open a new terminal session, go to folder where you've clone the project (Ex.: ```cd hidden-message-decoder```) and type `make test`

# Extra tools

* If you want to destroy the project, go to the terminal session in your machine where you've run ```make run``` and type de command ```make destroy```. IMPORTANT: you are running de application development mode, you must type `exit` to exit de session and after that you can type ```make destroy```
