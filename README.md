## Shell script that allows you to update a dependency on different modules directly from the command line.
This script is particularly useful when you need to update one or more dependencies on different modules.
You are allowed to choose between two different options:
1. Choose single modules among the available ones and perform the update.
2. Choose to update all available modules without selecting them.

## How it works?
1. Change the path to the directory where the modules you want to work on are located.
2. List the name of the modules by separating them with a space.
3. Modify the $dependency variable by adding the artifactId of the dependency you want to search inside the modules instead.

[![Screenshot1.png](https://i.postimg.cc/25wMNvFk/Screenshot1.png)](https://postimg.cc/HJrBQrhR)

Here is a screenshot of how the shell works.

[![Screenshot2.png](https://i.postimg.cc/c1jjWdYn/Screenshot2.png)](https://postimg.cc/mhYVNfmL)

At the moment, following the indicated steps, it is directly usable only with Maven, but making some modifications you can adapt it also for Gradle.

:right_anger_bubble:
## Upcoming features
- [ ] List all available dependencies and update them
- [ ] Choose between Maven or Gradle
- [ ] Insert more than one module directory from the command line :tada:

## Join the Discord server:
:astronaut:
https://discord.gg/QCFdkvq4
 

