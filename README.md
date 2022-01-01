# Git-Cheatsheet
Git-Cheatsheet - List of commands/situation you may find yourseld dealing with 

- [Official GitHub Docs](https://docs.github.com/en/github)
- [How to install Git on Windows](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

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
