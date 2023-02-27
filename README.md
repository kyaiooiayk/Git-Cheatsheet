# GIT Cheatsheet
*List of commands & case studies you may find yourselF dealing with.* 
***

## Git, GitHub and GitLab
- **GIT** stands for Global Information Tracker. - GitHub and GitLab are remote server repositories based on GIT.
- GitHub is a collaboration platform that helps review and manage codes remotely.
- GitLab is the same but is majorly focused on DevOps and CI/CD. 
***

## How to install `git`
- If you have a conda virtual environment: `conda install git`
- On MacOS, if you are getting this error `xcrun: error: invalid active developer path`, set this discussion [here](https://apple.stackexchange.com/questions/254380/why-am-i-getting-an-invalid-active-developer-path-when-attempting-to-use-git-a).
***

## How to change your email and username
- Your name and email address are configured automatically based on your username and hostname. If this is not done you can always overwrite it with:
```
git config --global user.name <your_name>
git config --global user.email <your_email_address>
```
- To change this defaul option, run the following command and follow the instructions in your editor to edit your configuration file: `git config --global --edit`
- After doing this, you may fix the identity used for this commit with: `git commit --amend --reset-author`
***

## How to change the `AUTHOR/COMMITTER_NAME` for all your previous commits
- There are cases where youstart working on your another PC, you push the commits and you then realise you fortgot to update your credentials. If do this what is shown in the remote server is not what you generally see but what git used as a default. This [answer](https://stackoverflow.com/questions/4493936/could-i-change-my-name-and-surname-in-all-previous-commits) on stackoverflow how to ammend this: 
- Suppose you want to change the `GIT_AUTHOR_NAME` then run this (`-f` is the forced option):
```
git filter-branch --commit-filter \
'if [ "$GIT_AUTHOR_NAME" = "your_old_author_name" ]; then \
export GIT_AUTHOR_NAME="your_new_name";\
export GIT_AUTHOR_EMAIL=your_email_addressi@gmail.com;\
export GIT_COMMITTER_NAME="your_new_name";\
export GIT_COMMITTER_EMAIL=your_new_name@gmail.com;\
fi;\
git commit-tree "$@"' -f
```
- Alternative you can also try this (contrary to the one above there is no if statement it will update everything with no distinction):
```
git filter-branch --commit-filter 'export GIT_COMMITTER_NAME="your_new_commiter_name"; \
export GIT_AUTHOR_EMAIL=your_email_address@gmail.com; git commit-tree "$@"'
```
- Once this is done you want to update the remote server: `git push --all origin --force`
***

## How to delete your commits history?
- Say you have some sensitive information on your commits history and you'd like to remove them all.
- One option would be to delete the `.git` folder but this may cause problems in your git repository. If you want to delete all your commit history but keep the code in its current state, it is very safe to do it as in the [following](https://stackoverflow.com/questions/13716658/how-to-delete-all-commit-history-in-github).
 - Find our which branch you are on (generally either `main` or `master`): `git rev-parse --abbrev-ref HEAD`. Then change the code below accordingly on the branch you are on.
 - Checkout: `git checkout --orphan latest_branch`
 - Add all the files (move it the stage area): `git add -A`
 - (Alternative you can move a single/folder file): `git add <path_to_specific_file_or_folder>`
 - Commit the changes: `git commit -am "commit message"`
 - Delete the branch: `git branch -D main`
 - Rename the current branch to main: `git branch -m main`
 - Finally, force update your repository: `git push -f origin main`
***

## How to write your commit texts
- [Use templates for better Git commit messages: a casa stade from Autotrader](https://engineering.autotrader.co.uk/2018/06/11/use-templates-for-better-commit-messages.html)
- [Here](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) is the template written by Tim Pope:

```
Capitalized, short (50 chars or less) summary

More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the imperative: “Fix bug” and not “Fixed bug”
or “Fixes bug.”  This convention matches up with commit messages generated
by commands like git merge and git revert.

Further paragraphs come after blank lines.

- Bullet points are okay, too

- Typically a hyphen or asterisk is used for the bullet, followed by a
  single space, with blank lines in between, but conventions vary here

- Use a hanging indent
```
***

## How to unstage/delete changes made locally
- Before we make a commit, we must tell Git what files we want to commit (new untracked files, modified files, or deleted files). This is called staging and uses the add command. 
- To unstage a file that has been staged but keep the modifications in the working directory:  `git restore --staged <your_file_path>`
- Alternatively, you can simply delete any modification and restore the previous commit: `git restore <your_file_path>` Restore can be dangerous: anything committed in Git can be recovered in one way or another, but restoring a file will delete the modifications forever.
- How to remove the staged files but keep the files: `git rm -r --cached <name of the file to be removed>`
***

## Cloning the project
- This is the case where the repository is created first on GitHub. 
```
# Clone with HTTPS
git clone https://gitlab.com/*******
# Clone with SSH
git clone git@gitlab.com:*******
```
***

## Clone, venv and requirements.txt installation
- This is how to start using a git project:
```
$ git clone https://github.com/username/project_name.git
$ cd project_name
$ virtualenv -p python3 my_venv_name
$ source my_venv_name/bin/activate
$(my_venv_name) pip install -r requirements.txt
```
***

## How to check the commits history
- `git log`
- `git log -3`: get the last 3 commit messages
- `git log --oneline`: shorthand for --pretty=oneline --abbrev-commit used together.
- `git log --graph`: display an ASCII graph of the branch and merge history beside the log output.
***

## Branch
- Creating a branch is useful because it allows us to freely experiment (generally keep a different model of the code) withouth touching the original code. At a later stage, you can always merged what you have done in the branch version into the main one.
- Once you clone the project to your local machine, you only have the **master branch**. 
- You should make all the changes on a new branch that can be created using the git **branch command**. 
- Your branch is the copy of the master branch/main. 
- Creating a new branch does not mean that you are working on the new branch. You need to **switch to that branch**.
- WARNING! `git switch` is very similar to `git checkout` to the point that they do effectively the same thing. See this discussion [here](https://stackoverflow.com/questions/57265785/whats-the-difference-between-git-switch-and-git-checkout-branch).
```
# Create a branch
git branch mybranch
# Make sure you switch to this branch
git switch mybranch
# Show all the local branches of your repo. The starred branch is your current branch.
git branch
# Show the branch you are in 
git branch --show-current
```
***

## `main` vs. `master`
- The computer industry's use of the terms master and slave was considered no longer appropriate after the eventis that took place in the summer of 2020. 
- Amid the many protests and the growing social unrest, these harmful and antiquated terms were no longer considered appropriate.
- The option is not a default one, GitHub encourage this but does not ban the use.
***

## Getting the current status
- To know what branch you are workign on 
- To show what changes (if any) have been staged: ```git status```
***

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
***

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
***

## Undo commits
- `git revert <commit>` Git revert undoes the changes back to a specific commit and adds it as a new commit, keeping the log intact. To revert, you need to provide a hash of a specific commit. 
- `git reset <commit>` You can also undo changes by using the reset command. It reset the changes back to a specific commit, discarding all commits made after. Note: Using reset command is **discouraged** as it modifies your git log history. 
***

## Ignoring some files
- There may be situations where: 
 - You do not want to share a specific files because of confidentiality reason
 - The file is too big and Git-based remote server are not meant for this.
 - There are a lot not useful files such as `.pyc` and `.so`. 
 - Create a hidden file named: .gitignore where the “.” is important: `vim .gitignore`
 - Tell Git where the `.gitingore` file is and how to add files: `git config --global core.excludesfile '~/.gitignore'`
 - Add a new file type to gitignore: `echo '.ipynb_checkpoints' >> .gitignore`
- This is an example:
```shell
# Some of my current configuration of .gitignore
*.ipynb_checkpoints
*.pyc
*.pyo
__pycache__/
```
***

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
***

## Push to the server failed because of large file (even after deletion)
- You have to option here: squashing or filter-branch. The latter seems to better because it does not mess with the entire history. [Ref](https://stackoverflow.com/questions/19573031/cant-push-to-github-because-of-large-file-which-i-already-deleted)
    - Locally delete or modify (reduce) large files.
    - Commit the local deletes.
    - Soft reset back X number of commits: `git reset --soft HEAD~X`.
    - Then recommit all the changes together (AKA squash) `git commit -m "New message for the combined commit"`
    - Push squashed commit.
***

## How to force push
- If you get an error like this: `Git push failed, "Non-fast forward updates were rejected"`. Then you can use `git push --force` to force push your changes to the server. You need to push about what you are doing and this may not be ideal when working in large projects where others are involved. [Ref](https://stackoverflow.com/questions/6897600/git-push-failed-non-fast-forward-updates-were-rejected)
***

## Pulling from server
- While you are working on a task in your local branch, there might be some changes in the remote branch. The `git pull` command is used for making your local branch up to date. You should use the git pull command to update your local working directory with the latest files in the remote branch. 
- By default, the pull command fetches the changes and merges them with the current branch. To rebase, instead of merge, you can add the `--rebase` flag before the remote name and branch: `git pull --rebase origin master`

***

## Dealing with errors
- If it throws an error saying there is another process live. Try: zrm -f .git/index.lockz
- If `git push` hangs after Total, try to increase the maximum size of the buffer with as suggested [here](https://stackoverflow.com/questions/15843937/git-push-hangs-after-total-line): `git config --global http.postBuffer 157286400` then try to push again.
***

## Getting your token (password no longer accepted)
- From August 13, 2021, GitHub is no longer accepting account passwords when authenticating Git operations. You need to add a PAT (Personal Access Token) instead, and you can follow the below method to add a PAT on your system.
- From your GitHub account, go to Settings => Developer Settings => Personal Access Token => Generate New Token (Give your password) => Fillup the form => click Generate token => Copy the generated Token, it will be something like ghp_sFhFsSHhTzMDreGRLjmks4Tzuzgthdvfsrta
- Click on the Spotlight icon (magnifying glass) on the right side of the menu bar. Type Keychain access then press the Enter key to launch the app => In Keychain Access, search for github.com => Find the internet password entry for github.com => Edit or delete the entry accordingly => You are done. However, once you use this taken once, when you are prompted for the password this steo is not generally required.
***

## Saving token on your Mac
- Unset any previous credentia storage you are using with: `git config --global --unset credential.helper`
- Tell tell Git you want to store credentials in the osxkeychain by running the following: `git config --global credential.helper osxkeychain`
- You can remove an existing password or token stored in the osxkeychain using the following command: `git credential-osxkeychain erase`
- See this [refence](https://gist.github.com/jonjack/bf295d4170edeb00e96fb158f9b1ba3c) for more.
***

## Large files
- GitHub limits the size of files allowed in repositories. To track files beyond this limit, you can use Git Large File Storage.
- In order to use Git LFS, you'll need to download and install a new program that's **separate** from Git.
- You can read more about it [here](https://docs.github.com/en/repositories/working-with-files/managing-large-files)
***

## How to delete the cache from another git repository
- Suppose you have clone a folder inside one of your git repository. If you try to push git will throw you this error message `You've added another git repository inside your current repository.` You now have two options:
   - Option #1: navigate to the clones repositoy and delete all the hidden files that start wiht `.git` 
   - Option #2: `git rm --cached <path_of_clone_folder>`
***

## CI/CD with GitHub Actions
- [How to build a CI/CD pipeline with GitHub Actions in four simple steps](https://github.blog/2022-02-02-build-ci-cd-pipeline-github-actions-four-steps/)
- [How to Build MLOps Pipelines with GitHub Actions [Step by Step Guide]](https://neptune.ai/blog/build-mlops-pipelines-with-github-actions-guide)
***

## Tagging
- Listing the existing tags in Git is straightforward: `git tag`
- Listing the existing tags with a particular patter: `git tag -l "v1.8.5*"`
- Create a tag along with a commit message: `git tag -a v1.4 -m "my version 1.4"`
- See more [here](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
***

## References
- https://www.kdnuggets.com/2021/10/8-git-commands-data-scientists.html 
- https://www.upgrad.com/blog/github-vs-gitlab-difference-between-github-and-gitlab/ - https://chryswoods.com/beginning_git/README.html
- [Official GitHub Docs](https://docs.github.com/en/github)
- [How to install Git on Windows](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Quick guide of what VC is and how to use GIT](https://docs.google.com/presentation/d/1_AYIcCyVI59QiiXqU4Sn7VzwtVyfqv-lG36EPFzeSdY/edit#slide=id.gc0ca3f56b2_0_12)
- [Use templates for better Git commit messages](https://engineering.autotrader.co.uk/2018/06/11/use-templates-for-better-commit-messages.html)
- [Git cheatsheet](https://www.kdnuggets.com/publications/sheets/Git_Cheatsheet_KDnuggets.pdf)
- [Why GitHub renamed its master branch to main](https://www.theserverside.com/feature/Why-GitHub-renamed-its-master-branch-to-main)
***
