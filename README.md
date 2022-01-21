# Git-Cheatsheet
Git-Cheatsheet - List of commands/situation you may find yourseld dealing with 

## Git, GitHub and GitLab
- **GIT** stands for Global Information Tracker. - GitHub and GitLab are remote server repositories based on GIT.
- GitHub is a collaboration platform that helps review and manage codes remotely. - GitLab is the same but is majorly focused on DevOps and CI/CD. 

## Cloning the project
- This is the case where the repository is created first on GitHub. 
```
# Clone with HTTPS
git clone https://gitlab.com/*******
# Clone with SSH
git clone git@gitlab.com:*******
```

## Clone, venv and installing requirements
- This is how to start using a git project:
```
$ git clone https://github.com/username/project_name.git
$ cd project_name
$ virtualenv -p python3 my_venv_name
$ source my_venv_name/bin/activate
$(my_venv_name) pip install -r requirements.txt
```

## Branch
- Once you clone the project to your local machine, you only have the **master branch**. 
- You should make all the changes on a new branch that can be created using the git **branch command**. 
- Your branch is the copy of the master branch. 
- Creating a new branch does not mean that you are working on the new branch. You need to **switch to that branch**.
```
# Create a branch
git branch mybranch
# Make sure you swith to this branch
git switch mybranch
```

## Getting the current status
- To know what branch you are workign on 
- To show you what changes (if any) they have made 
```
# Get current status
git status
```

## Adding changes
 - This stepp is different from the **commit** phase. 
 - When you make changes in the code, the branch you work on becomes different from the master branch. These changes are not visible in the master branch unless you take a series of actions.
 - The first action is the git add command. This command adds the changes to what is called the **staging area**. 
 
![image](https://user-images.githubusercontent.com/89139139/147848375-842d8495-06ce-485e-96c6-5efa8b5f35b5.png)

```
# Adding everything in the current directoru
git add .
# Adding a specific file
git add <name of your specific file>
# Add manually a folder which is NOT shown in the list of commitments
git add —all <name of your folder>
```

## Commit changes
- It is not enough to add your updated files or scripts to the staging area. You also need to “commit” these changes using the git commit command.
- The important part of the git commit command is the message part. It briefly explains what has been changed or the purpose of this change. 
- There is not a strict set of rules to write commit messages. 

```
# Commit plus add a message
git commit -m <add here your message>
# Alternativaly you can use this, which will bring you to current status
# of what changes, you can add a message (via vim for instance) there and save the file
git commit -a
```

## Ignoring some files
- There may be situations where: 
  - You do not want to share a specific files because of confidentiality reason
  - The file is too big and Git-based remote server are not meant for this.
  - There are a lot not useful files such as `.pyc` and `.so`. 
```
# Create a file named: .gitignore where the “.” is important
vim .gitignore
# Tell Git where the .gitingore file is and how to add files
git config --global core.excludesfile '~/.gitignore'
# Add a new file type to gitignore
echo '.ipynb_checkpoints' >> .gitignore
```
- This is an example:
```
# Some of my current configuration of .gitignore
*.ipynb_checkpoints
*.pyc
*.pyo
__pycache__/
```

## Push to the server
- Pushing your code will save your changes in a remote branch = **master branch**
- If you were not on a branch this will still work.
- After your branch is pushed, A **merge request** is asking the maintainer of the project to “merge” your code to the master branch. The maintainer will first review your code. If the changes are OK, your code will be merged. 
```
# This will push the changes to the server
git push
# If you are not working in a branch
git push origin master
```
- Suppose the file you want to update in git but you made some small changes **locally** that you do **NOT** want to keep anymore. 
- If you use `git pull` it will throw you an error saying: `Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded'. 
```
# Discard local changes to all files, permanently
git reset –hard
# Then you can use “git pull” to update your local directory
git pull
```
## Push to the server failed because of large file (even after deletion)
- You have to option here: squashing or filter-branch. The latter seems to better because it does not mess with the entire history. [Ref](https://stackoverflow.com/questions/19573031/cant-push-to-github-because-of-large-file-which-i-already-deleted)
    - Locally delete or modify (reduce) large files.
    - Commit the local deletes.
    - Soft reset back X number of commits: `git reset --soft HEAD~X`.
    - Then recommit all the changes together (AKA squash) `git commit -m "New message for the combined commit"`
    - Push squashed commit.

## Hot to force push
- If you get an error like this: `Git push failed, "Non-fast forward updates were rejected"`. Then you can use `git push --force` to force push your changes to the server. You need to push about what you are doing and this may not be ideal when working in large projects where others are involved. [Ref](https://stackoverflow.com/questions/6897600/git-push-failed-non-fast-forward-updates-were-rejected)

## Pulling from server
- While you are working on a task in your local branch, there might be some changes in the remote branch.
- The git pull command is used for making your local branch up to date. You should use the git pull command to update your local working directory with the latest files in the remote branch. 
```
# If repository installed locally, this updates it from server
git pull
```

## Dealing with errors
```
# If it throws an error saying there is another process live
rm -f .git/index.lock
```

## Getting your token (password no longer accpeted)
- From August 13, 2021, GitHub is no longer accepting account passwords when authenticating Git operations. You need to add a PAT (Personal Access Token) instead, and you can follow the below method to add a PAT on your system.
- From your GitHub account, go to Settings => Developer Settings => Personal Access Token => Generate New Token (Give your password) => Fillup the form => click Generate token => Copy the generated Token, it will be something like ghp_sFhFsSHhTzMDreGRLjmks4Tzuzgthdvfsrta
- Click on the Spotlight icon (magnifying glass) on the right side of the menu bar. Type Keychain access then press the Enter key to launch the app => In Keychain Access, search for github.com => Find the internet password entry for github.com => Edit or delete the entry accordingly => You are done. However, once you use this taken once, when you are prompted for the password this steo is not generally required.

## References
- https://www.kdnuggets.com/2021/10/8-git-commands-data-scientists.html 
- https://www.upgrad.com/blog/github-vs-gitlab-difference-between-github-and-gitlab/ - https://chryswoods.com/beginning_git/README.html
- [Official GitHub Docs](https://docs.github.com/en/github)
- [How to install Git on Windows](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
