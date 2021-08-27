# ebiten-deploy

## What this project does
This repo contains a single Makefile, which tries to provide a few useful targets to build and deploy an Ebiten project to [itch.io](https://itch.io/).

## Prerequisites
- a standard version of Make for your system
- if you plan on deploying to itch.io, [butler](https://itch.io/docs/butler/) - run `butler login` before you use the Makefile
- go!

## Setup
```
# projects folder for ebiten projects
- myEbitenProjets
# an Ebiten project here
    - helloWorld
    - ...
```

- for each project you're working on, create a folder and put the relevant files inside this folder
- create a Makefile (empty for now) in each one of your "project folders"

Now let's give make actual data: In the "root Makefile", you'll see that there's a variable called `go`; this is where you tell make where your go executable (go.exe in windows) is.

```
# just an example
go = "C:\Program Files\Go\bin\go.exe"
```

In your "project Makefile" (the one that's empty in your project folder), add the two following variables:
```
# this is the your project name, it will be used in `name.exe`
name = MY_PROJECT
# this is your username and the name of your project on itch.io
itchio = USERNAME/TEST-GAME
```
⚠ itch.io tends to convert the name of the project when there's underscores in it, replacing them with hyphens, so make sure you use the one that's shown in the URL and not the actual project name.

⚠ also, make sure you created the project on itch.io before you deploy to it, because butler doesn't create it for you.

Note that you have to provide your own index.html by putting it in your project folder, and it will be copied to your `web` folder.

## How to run
In the root "ebiten projects" folder, run
```
make TARGET project=FOLDER
```
to run the operation TARGET on the project FOLDER.

### List of useful targets
- all: builds web and windows
- web: builds web
- windows: builds windows
- run: runs the .exe version
- deploy: exports and deploys web and windows
- deploy_windows: exports and deploys windows
- deploy_web: exports and deploys web
- clean: removes the exports for both web and windows
- clean_web: removes the exports for web
- clean_windows: removes the exports for windows

Or just have a read through the Makefile! 😉

Feel free to modify it however you want, and let me know if you come up with something cool, I'll be happy to integrate it to this project!

## Sample run
Given the following folder structure:
```
ROOT_FOLDER/
 |_ Makefile
 |_ ebiten-template/
    |_ index.html
    |_ main.go
    |_ go.mod
    |_ go.sum
    |_ Makefile
```
```Makefile
# ebiten-template/Makefile
name = template
itchio = tducasse/test-deploy
```
```sh
make deploy project=ebiten-template
```
![image](https://user-images.githubusercontent.com/11507599/131134456-0f51d7a4-d4c9-419d-9db8-2503e55b9afa.png)

